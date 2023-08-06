package com.boat.domain;

public class MailVO {

	//mail.properties���� �ۼ��� ���̵� �ش��ϴ� �̸��� �ּ� �ۼ��մϴ�.
	private String from="dmswjddid37@naver.com";
	private String to;
	private String subject="BOAT 회원 가입을 축하드립니다.";
	private String content="BOAT 회원 가입을 축하드립니다.";
	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
