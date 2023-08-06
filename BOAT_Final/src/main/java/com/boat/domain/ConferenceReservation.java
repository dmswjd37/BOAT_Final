package com.boat.domain;

public class ConferenceReservation {
    private String ID;
     private String RENTAL;
     private String START_TIME;
     private String END_TIME;
     private String CONTENT;
     private String START_T; //moment처리된 값
     private String END_T;
     private String STATUS;//예약승인 처리여부
     private String MEMO;//예약거절 사유입력
     private String ABC; //예약신청입력된시간
     
     
	  
	
	public String getABC() {
		return ABC;
	}
	public void setABC(String aBC) {
		ABC = aBC;
	}
	public String getMEMO() {
		return MEMO;
	}
	public void setMEMO(String mEMO) {
		MEMO = mEMO;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	public String getSTART_T() {
		return START_T;
	}
	public void setSTART_T(String sTART_T) {
		START_T = sTART_T;
	}
	public String getEND_T() {
		return END_T;
	}
	public void setEND_T(String eND_T) {
		END_T = eND_T;
	}
	public String getEND() {
		return END;
	}
	public void setEND(String eND) {
		END = eND;
	}
	private String END;

   
   public String getID() {
      return ID;
   }
   public void setID(String iD) {
      ID = iD;
   }
   public String getRENTAL() {
      return RENTAL;
   }
   public void setRENTAL(String rENTAL) {
      RENTAL = rENTAL;
   }
   public String getSTART_TIME() {
      return START_TIME;
   }
   public void setSTART_TIME(String sTART_TIME) {
      START_TIME = sTART_TIME;
   }
   public String getEND_TIME() {
      return END_TIME;
   }
   public void setEND_TIME(String eND_TIME) {
      END_TIME = eND_TIME;
   }

   public String getCONTENT() {
      return CONTENT;
   }
   public void setCONTENT(String cONTENT) {
      CONTENT = cONTENT;
   }

  

}