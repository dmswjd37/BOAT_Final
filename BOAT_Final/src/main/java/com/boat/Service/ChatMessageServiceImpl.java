package com.boat.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.domain.ChatMessage;
import com.boat.mybatis.mapper.ChatMessageMapper;

@Service
public class ChatMessageServiceImpl implements ChatMessageService {

	private ChatMessageMapper dao;

	@Autowired
	public ChatMessageServiceImpl(ChatMessageMapper dao) {
		this.dao = dao;
	}
	
	//메세지 전송 저장
	@Override
	public void messageinsert(String content, String uuid, String id, String formattedDate) {
		dao.messageinsert(content, uuid, id, formattedDate);
	}

	//메세지 로드
	@Override
	public List<ChatMessage> getChatHistory(String id, String uuid) {
		return dao.getChatHistory(id, uuid);
	}

	
}
