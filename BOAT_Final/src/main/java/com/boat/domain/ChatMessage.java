package com.boat.domain;

public class ChatMessage {
	
	private String SENDER;            // 보낸사람
    private String RECEIVER;        // 받는 사람
    private String CONTENT;            // 메세지 내용
    private String CHAT_TIME;            // 표시 날짜
    private String CHAT_DATE;            // SYSDATE
    
	public String getSENDER() {
		return SENDER;
	}
	public void setSENDER(String sENDER) {
		SENDER = sENDER;
	}
	public String getRECEIVER() {
		return RECEIVER;
	}
	public void setRECEIVER(String rECEIVER) {
		RECEIVER = rECEIVER;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public String getCHAT_TIME() {
		return CHAT_TIME;
	}
	public void setCHAT_TIME(String cHAT_TIME) {
		CHAT_TIME = cHAT_TIME;
	}
	public String getCHAT_DATE() {
		return CHAT_DATE;
		
	}
	public void setCHAT_DATE(String cHAT_DATE) {
		CHAT_DATE = cHAT_DATE;
	}
    
    
    
}
