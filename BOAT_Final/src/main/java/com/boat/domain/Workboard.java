package com.boat.domain;

public class Workboard {
	private int num;
	private String category;
	private String EMPNO;
	private String DEPT;
	private String NAME;
	private String content;
	private String subject;
	private String PROFILE_FILE;
	private String reg_date; //2020-12-24 16:08:35
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getEMPNO() {
		return EMPNO;
	}
	public void setEMPNO(String eMPNO) {
		EMPNO = eMPNO;
	}
	public String getDEPT() {
		return DEPT;
	}
	public void setDEPT(String dEPT) {
		DEPT = dEPT;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		 // 년, 월, 일, 시, 분 추출
	    String year = reg_date.substring(0, 4);
	    String month = reg_date.substring(5, 7);
	    String day = reg_date.substring(8, 10);
	    String hour = reg_date.substring(11, 13);
	    String minute = reg_date.substring(14, 16);

	    // 추출한 값을 조합하여 원하는 형식으로 설정
	    this.reg_date = year + "년 " + month + "월 " + day + "일 - " + hour + "시 " + minute + "분";
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPROFILE_FILE() {
		return PROFILE_FILE;
	}
	public void setPROFILE_FILE(String pROFILE_FILE) {
		PROFILE_FILE = pROFILE_FILE;
	}

	

	
	
}
