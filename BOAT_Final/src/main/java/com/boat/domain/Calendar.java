package com.boat.domain;

import lombok.Data;

@Data
public class Calendar {

	private int SCHEDULE_CODE;
	private String EVENT_NAME;
	private String START_DATE;
	private String END_DATE;
	private String ALLDAY;
	private String EMPNO;
	private String COLOR;
	private String DEPT;
	private String STARTT;
	private String ENDD;
	
	
	
	public int getSCHEDULE_CODE() {
		return SCHEDULE_CODE;
	}
	public void setSCHEDULE_CODE(int sCHEDULE_CODE) {
		SCHEDULE_CODE = sCHEDULE_CODE;
	}
	public String getEVENT_NAME() {
		return EVENT_NAME;
	}
	public void setEVENT_NAME(String eVENT_NAME) {
		EVENT_NAME = eVENT_NAME;
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
	public String getALLDAY() {
		return ALLDAY;
	}
	public void setALLDAY(String aLLDAY) {
		ALLDAY = aLLDAY;
	}
	public String getEMPNO() {
		return EMPNO;
	}
	public void setEMPNO(String eMPNO) {
		EMPNO = eMPNO;
	}
	public String getCOLOR() {
		return COLOR;
	}
	public void setCOLOR(String cOLOR) {
		COLOR = cOLOR;
	}
	public String getDEPT() {
		return DEPT;
	}
	public void setDEPT(String dEPT) {
		DEPT = dEPT;
	}


}
