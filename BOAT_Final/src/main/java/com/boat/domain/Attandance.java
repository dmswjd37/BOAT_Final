package com.boat.domain;


public class Attandance {

	private String EMPNO;
	private String DEPT;
	private String CONTENT;
	private String ON_TIME;
	private String OFF_TIME;
	private String REG_DATE;
	private String OUT_TIME;
	private String NAME;
	private String WORK_TIME;
	private String total_work_time;
	private String workper;
	
	
	
	public String getWorkper() {
		return workper;
	}
	public void setWorkper(String workper) {
		this.workper = workper;
	}
	public String getTotal_work_time() {
		return total_work_time;
	}
	public void setTotal_work_time(String total_work_time) {
		this.total_work_time = total_work_time;
	}
	
	
	public String getWORK_TIME() {
		
		return WORK_TIME;
	}
	public void setWORK_TIME(String wORK_TIME) {
		WORK_TIME = wORK_TIME;
	}
	public String getREG_DATE() {
		return REG_DATE;
	}
	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
	}
	public String getOUT_TIME() {
		return OUT_TIME;
	}
	public void setOUT_TIME(String oUT_TIME) {
		OUT_TIME = oUT_TIME;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
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
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public String getON_TIME() {
		return ON_TIME;
	}
	public void setON_TIME(String oN_TIME) {
		ON_TIME = oN_TIME;
	}
	public String getOFF_TIME() {
		return OFF_TIME;
	}
	public void setOFF_TIME(String oFF_TIME) {
		OFF_TIME = oFF_TIME;
	}

}
