package com.boat.domain;

public class Todo {
	//private Member member;
		//private List<Member> member;
	
	

	private String EMPNO;
	private String T_CONTENT;
	private String START_DATE;
	private String END_DATE;
	private String REG_DATE;  	
	private String DEPT;
	private int NUM;
	private int state;
	
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		
		this.state = state;
	}
	
	
	
	
	
	
	public String getEMPNO() {
		return EMPNO;
	}
	public void setEMPNO(String eMPNO) {
		EMPNO = eMPNO;
	}
	public String getT_CONTENT() {
		return T_CONTENT;
	}
	public void setT_CONTENT(String t_CONTENT) {
		T_CONTENT = t_CONTENT;
	}
	public String getSTART_DATE() {
		return START_DATE;
	}
	public void setSTART_DATE(String sTART_DATE) {
		START_DATE = sTART_DATE;
	}
	public String getEND_DATE() {
		return END_DATE;
	}
	public void setEND_DATE(String eND_DATE) {
		END_DATE = eND_DATE;
	}
	public String getREG_DATE() {
		return REG_DATE;
	}
	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
	}
	public String getDEPT() {
		return DEPT;
	}
	public void setDEPT(String dEPT) {
		DEPT = dEPT;
	}
	public int getNUM() {
		return NUM;
	}
	public void setNUM(int nUM) {
		NUM = nUM;
	}
	
	
	
}
