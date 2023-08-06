package com.boat.domain;

import java.util.Objects;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private String EMPNO;
	private String DEPT;
	private String JOB="사원";
	private String PASSWORD;
	private String PASSWORD_OG;
	private String NAME;
	private String EMAIL;
	
	//joinForm.jsp에서 name 속성 확인하세요.
	//<input type="file" name="uploadfile" id="upfile" accept="image/.jpg, .jpeg, .png, .gif" hidden=""> 확인
	private MultipartFile uploadfile;
	
	private String PROFILE_FILE;
	private String PROFILE_IMG;
	private String REGISTER_DATE;
	private String AUTH="ROLE_MEMBER";
	private String NAVERLOGIN;
	private String GOOGLELOGIN;
	
	
	@Override
	public int hashCode() {
		return Objects.hash(AUTH, DEPT, EMAIL, EMPNO, GOOGLELOGIN, JOB, NAME, NAVERLOGIN, PASSWORD, PASSWORD_OG,
				PROFILE_FILE, PROFILE_IMG, REGISTER_DATE, uploadfile);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Member other = (Member) obj;
		return Objects.equals(AUTH, other.AUTH) && Objects.equals(DEPT, other.DEPT)
				&& Objects.equals(EMAIL, other.EMAIL) && Objects.equals(EMPNO, other.EMPNO)
				&& Objects.equals(GOOGLELOGIN, other.GOOGLELOGIN) && Objects.equals(JOB, other.JOB)
				&& Objects.equals(NAME, other.NAME) && Objects.equals(NAVERLOGIN, other.NAVERLOGIN)
				&& Objects.equals(PASSWORD, other.PASSWORD) && Objects.equals(PASSWORD_OG, other.PASSWORD_OG)
				&& Objects.equals(PROFILE_FILE, other.PROFILE_FILE) && Objects.equals(PROFILE_IMG, other.PROFILE_IMG)
				&& Objects.equals(REGISTER_DATE, other.REGISTER_DATE) && Objects.equals(uploadfile, other.uploadfile);
	}
	public String getGOOGLELOGIN() {
		return GOOGLELOGIN;
	}
	public void setGOOGLELOGIN(String gOOGLELOGIN) {
		GOOGLELOGIN = gOOGLELOGIN;
	}
	public String getPASSWORD_OG() {
		return PASSWORD_OG;
	}
	public void setPASSWORD_OG(String pASSWORD_OG) {
		PASSWORD_OG = pASSWORD_OG;
	}
	public String getPROFILE_FILE() {
		return PROFILE_FILE;
	}
	public void setPROFILE_FILE(String pROFILE_FILE) {
		PROFILE_FILE = pROFILE_FILE;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getNAVERLOGIN() {
		return NAVERLOGIN;
	}
	public void setNAVERLOGIN(String nAVERLOGIN) {
		NAVERLOGIN = nAVERLOGIN;
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
	public String getJOB() {
		return JOB;
	}
	public void setJOB(String jOB) {
		JOB = jOB;
	}
	public String getPASSWORD() {
		return PASSWORD;
	}
	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public String getPROFILE_IMG() {
		return PROFILE_IMG;
	}
	public void setPROFILE_IMG(String pROFILE_IMG) {
		PROFILE_IMG = pROFILE_IMG;
	}
	public String getREGISTER_DATE() {
		return REGISTER_DATE;
	}
	public void setREGISTER_DATE(String rEGISTER_DATE) {
		REGISTER_DATE = rEGISTER_DATE;
	}
	public String getAUTH() {
		return AUTH;
	}
	public void setAUTH(String aUTH) {
		AUTH = aUTH;
	}
	
	
	
}
