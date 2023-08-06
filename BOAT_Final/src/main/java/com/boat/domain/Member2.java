package com.boat.domain;

import java.util.List;


import org.springframework.web.multipart.MultipartFile;


public class Member2 {
	private String EMPNO;
	private String DEPT;
	private String JOB;
	private String PASSWORD;
	private String NAME;
	private String EMAIL;
	private MultipartFile uploadfile;
	
	private String PROFILE_FILE;
	private String PROFILE_IMG;
	private String REGISTER_DATE;
	private String AUTH="ROLE_MEMBER";
	private String NAVERLOGIN;
	
	private List<Todo> Todo;

	private int count;
	public  int getCount() {
		return count;
	}
	public  void setCount(int count) {
		this.count = count;
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
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getPROFILE_FILE() {
		return PROFILE_FILE;
	}
	public void setPROFILE_FILE(String pROFILE_FILE) {
		PROFILE_FILE = pROFILE_FILE;
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
	public String getNAVERLOGIN() {
		return NAVERLOGIN;
	}
	public void setNAVERLOGIN(String nAVERLOGIN) {
		NAVERLOGIN = nAVERLOGIN;
	}
	public List<Todo> getTodo() {
		return Todo;
	}
	public void setTodo(List<Todo> todo) {
		Todo = todo;
	}

	
	
}
