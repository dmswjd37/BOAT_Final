package com.boat.domain;

import org.springframework.web.multipart.MultipartFile;


public class Filebo {
	
	private int FILE_NUM ;
	private String FILE_NAME;  
	private String FILE_PASS; 
	private String FILE_SUBJECT;	
	private String FILE_CONTENT;
	private String FILE_FILE;
	private String FILE_FILE2;
	private int FILE_RE_REF;
	private int FILE_RE_LEV;
	private int FILE_RE_SEQ;
	private int FILE_READCOUNT;
	private String FILE_DATE;
	private int CNT;
	private String DEPT;
	private String FILE_EMPNO;
	
	private MultipartFile uploadfile;
	private MultipartFile uploadfile2;
	
	private String FILE_ORIGINAL;//첨부될파일의이름
	private String FILE_ORIGINAL2;//첨부될파일의이름
	
	
	private String star;
	
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public int getFILE_NUM() {
		return FILE_NUM;
	}
	public void setFILE_NUM(int fILE_NUM) {
		FILE_NUM = fILE_NUM;
	}
	public String getFILE_NAME() {
		return FILE_NAME;
	}
	public void setFILE_NAME(String fILE_NAME) {
		FILE_NAME = fILE_NAME;
	}
	public String getFILE_PASS() {
		return FILE_PASS;
	}
	public void setFILE_PASS(String fILE_PASS) {
		FILE_PASS = fILE_PASS;
	}
	public String getFILE_SUBJECT() {
		return FILE_SUBJECT;
	}
	public void setFILE_SUBJECT(String fILE_SUBJECT) {
		FILE_SUBJECT = fILE_SUBJECT;
	}
	public String getFILE_CONTENT() {
		return FILE_CONTENT;
	}
	public void setFILE_CONTENT(String fILE_CONTENT) {
		FILE_CONTENT = fILE_CONTENT;
	}
	public String getFILE_FILE() {
		return FILE_FILE;
	}
	public void setFILE_FILE(String fILE_FILE) {
		FILE_FILE = fILE_FILE;
	}
	public String getFILE_FILE2() {
		return FILE_FILE2;
	}
	public void setFILE_FILE2(String fILE_FILE2) {
		FILE_FILE2 = fILE_FILE2;
	}
	public int getFILE_RE_REF() {
		return FILE_RE_REF;
	}
	public void setFILE_RE_REF(int fILE_RE_REF) {
		FILE_RE_REF = fILE_RE_REF;
	}
	public int getFILE_RE_LEV() {
		return FILE_RE_LEV;
	}
	public void setFILE_RE_LEV(int fILE_RE_LEV) {
		FILE_RE_LEV = fILE_RE_LEV;
	}
	public int getFILE_RE_SEQ() {
		return FILE_RE_SEQ;
	}
	public void setFILE_RE_SEQ(int fILE_RE_SEQ) {
		FILE_RE_SEQ = fILE_RE_SEQ;
	}
	public int getFILE_READCOUNT() {
		return FILE_READCOUNT;
	}
	public void setFILE_READCOUNT(int fILE_READCOUNT) {
		FILE_READCOUNT = fILE_READCOUNT;
	}
	public String getFILE_DATE() {
		return FILE_DATE;
	}
	public void setFILE_DATE(String fILE_DATE) {
		FILE_DATE = fILE_DATE;
	}
	public int getCNT() {
		return CNT;
	}
	public void setCNT(int cNT) {
		CNT = cNT;
	}
	public String getDEPT() {
		return DEPT;
	}
	public void setDEPT(String dEPT) {
		DEPT = dEPT;
	}
	public String getFILE_EMPNO() {
		return FILE_EMPNO;
	}
	public void setFILE_EMPNO(String fILE_EMPNO) {
		FILE_EMPNO = fILE_EMPNO;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public MultipartFile getUploadfile2() {
		return uploadfile2;
	}
	public void setUploadfile2(MultipartFile uploadfile2) {
		this.uploadfile2 = uploadfile2;
	}
	public String getFILE_ORIGINAL() {
		return FILE_ORIGINAL;
	}
	public void setFILE_ORIGINAL(String fILE_ORIGINAL) {
		FILE_ORIGINAL = fILE_ORIGINAL;
	}
	public String getFILE_ORIGINAL2() {
		return FILE_ORIGINAL2;
	}
	public void setFILE_ORIGINAL2(String fILE_ORIGINAL2) {
		FILE_ORIGINAL2 = fILE_ORIGINAL2;
	}

	

	
}