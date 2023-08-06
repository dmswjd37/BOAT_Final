package com.boat.chat;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.boat.domain.Member;

@Component
public class WebSocketHandler extends TextWebSocketHandler {
	private static final Logger Logger = LoggerFactory.getLogger(WebSocketHandler.class);
	
	// 로그인 유저 목록 : <User, WebSocketSession>
	private Map<Member, WebSocketSession> sessionMap = new HashMap<Member, WebSocketSession>();
	
	// 채팅방 목록 : <String, WebSocketSession>
		private Map<String, Member> userMap = new HashMap<String, Member>();
		
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			
			Member user = (Member)session.getAttributes().get("loginUser");
			Logger.info("user="+user);
			
			Logger.info("\n아이디 : " + session.getAttributes().get("loginUser") + 
						 "\n웹소켓 세션 : " + session.getId() + 
						 "\n연결 성공");
			
			// 유저 - 세션 목록에 추가
			sessionMap.put(user, session);
			// uuid - 유저 목록에 추가
			userMap.put(user.getEMPNO(), user);
			System.out.println("userMap="+userMap);
			
			Logger.info("총 로그인 유저 : " + sessionMap.size());
		}

		@Override  
		public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
			// 메세지(JSON) 파싱
			JSONParser jParser = new JSONParser();
			JSONObject jObject = (JSONObject) jParser.parse((String)message.getPayload());
			System.out.println("jObject="+jObject);
			
			// 보낸 사람 (나)
			Member sender = (Member)session.getAttributes().get("loginUser");
			String senderName = sender.getNAME();
			String senderUuid = sender.getEMPNO();
					
			if(jObject.get("handle").toString().equals("message")) {
				
				// 채팅 메세지
				message = new TextMessage("message" + "," + sender.getNAME() + "," + jObject.get("content").toString() + "," + sender.getEMPNO());
				System.out.println("message="+message);
				// 메세지 전송
				Logger.info("1");
				System.out.println("sessionMap="+sessionMap);
				sessionMap.get(userMap.get(jObject.get("uuid"))).sendMessage(message);
				
			}else if(jObject.get("handle").toString().equals("login")) {
				
				// [나 → 상대방] 로그인 알림 메세지
				message = new TextMessage("login" + "," + senderUuid);
				// [로그인목록 → 나]
				String loginedUsers = "onLineList";
				
				// 로그인 되어 있는 유저들의 채팅방 화면에 전송하여 로그인 알림
				for (Member users : sessionMap.keySet()) {
					// 자기 자신은 제외
					if(users.getEMPNO().equals(senderUuid)) continue;
					sessionMap.get(users).sendMessage(message); 
					loginedUsers += "," + users.getEMPNO();
				}
				
				message = new TextMessage(loginedUsers);
				sessionMap.get(sender).sendMessage(message);  
				
			}else if(jObject.get("handle").toString().equals("logout")) {
				
				// [나 → 상대방] 로그아웃 알림 메세지
				message = new TextMessage("logout" + "," + senderUuid);                 
				                      
				// 로그인 되어 있는 유저들의 채팅방 화면에 전송하여 로그아웃 알림
				for (Member users : sessionMap.keySet()) {
					// 자기 자신은 제외 (아직 로그인 session 종료 X)
					if(users.getNAME().equals(senderName)) continue;
					sessionMap.get(users).sendMessage(message);
				}
				
			}else if(jObject.get("handle").toString().equals("onLineList")) {	
				
				String loginedUsers = "onLineList";
				// 로그인 되어 있는 유저 불러오기
				for (Member users : sessionMap.keySet()) {
					// 자기 자신은 제외
					if(users.getNAME().equals(senderName)) continue;
					loginedUsers += "," + users.getEMPNO();
				}
				message = new TextMessage(loginedUsers);
				sessionMap.get(sender).sendMessage(message);
			}
		}
		
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		}

		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
			
			Member u = (Member)session.getAttributes().get("loginUser");
			
			sessionMap.remove(u);
			userMap.remove(u.getEMPNO());
			
			Logger.info(u.getEMPNO() + "님의 웹소켓 연결 해제");
			Logger.info((Member)session.getAttributes().get("loginUser") + "님의 웹소켓 연결 해제");
		}
}