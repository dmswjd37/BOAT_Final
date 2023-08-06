package com.boat.domain;

public class Filecomm {

	public String getFILE_C_NUM() {
		return FILE_C_NUM;
	}
	public void setFILE_C_NUM(String fILE_C_NUM) {
		FILE_C_NUM = fILE_C_NUM;
	}
	public String getFILE_C_ID() {
		return FILE_C_ID;
	}
	public void setFILE_C_ID(String fILE_C_ID) {
		FILE_C_ID = fILE_C_ID;
	}
	public String getFILE_CONTENT() {
		return FILE_CONTENT;
	}
	public void setFILE_CONTENT(String fILE_CONTENT) {
		FILE_CONTENT = fILE_CONTENT;
	}
	public String getFILE_COMMENT_DATE() {
		return FILE_COMMENT_DATE;
	}
	public void setFILE_COMMENT_DATE(String fILE_COMMENT_DATE) {
		FILE_COMMENT_DATE = fILE_COMMENT_DATE;
	}
	public int getFILE_BO_NUM() {
		return FILE_BO_NUM;
	}
	public void setFILE_BO_NUM(int fILE_BO_NUM) {
		FILE_BO_NUM = fILE_BO_NUM;
	}
	public int getFILE_COMMENT_RE_LEV() {
		return FILE_COMMENT_RE_LEV;
	}
	public void setFILE_COMMENT_RE_LEV(int fILE_COMMENT_RE_LEV) {
		FILE_COMMENT_RE_LEV = fILE_COMMENT_RE_LEV;
	}
	public int getFILE_COMMENT_RE_SEQ() {
		return FILE_COMMENT_RE_SEQ;
	}
	public void setFILE_COMMENT_RE_SEQ(int fILE_COMMENT_RE_SEQ) {
		FILE_COMMENT_RE_SEQ = fILE_COMMENT_RE_SEQ;
	}
	public int getFILE_COMMENT_RE_REF() {
		return FILE_COMMENT_RE_REF;
	}
	public void setFILE_COMMENT_RE_REF(int fILE_COMMENT_RE_REF) {
		FILE_COMMENT_RE_REF = fILE_COMMENT_RE_REF;
	}
	public String getPROFILE() {
		return PROFILE;
	}
	public void setPROFILE(String pROFILE) {
		PROFILE = pROFILE;
	}
	public String getFILE_C_NAME() {
		return FILE_C_NAME;
	}
	public void setFILE_C_NAME(String fILE_C_NAME) {
		FILE_C_NAME = fILE_C_NAME;
	}
	public String getFILE_C_DEPT() {
		return FILE_C_DEPT;
	}
	public void setFILE_C_DEPT(String fILE_C_DEPT) {
		FILE_C_DEPT = fILE_C_DEPT;
	}
	private String FILE_C_NUM;//시퀀스
	private String FILE_C_ID;//empno
	private String FILE_CONTENT;
	private String FILE_COMMENT_DATE;//2020-12-24 16:08:35
	private int FILE_BO_NUM;//보드넘
	private int FILE_COMMENT_RE_LEV;
	private int FILE_COMMENT_RE_SEQ;
	private int FILE_COMMENT_RE_REF;
	private String PROFILE;
	private String FILE_C_NAME;
	private String FILE_C_DEPT; 
	
//	FILE_COMMENT
//	 FILE_C_NUM     NOT NULL NUMBER
//FILE_C_ID		VARCHAR2(30)
//FILE_CONTENT	VARCHAR2(200)
//FILE_COMMENT_DATE	DATE
//FILE_COMMENT_NUM		NUMBER
//FILE_COMMENT_RE_LEV	NUMBER
//FILE_COMMENT_RE_SEQ	NUMBER(38)
//FILE_COMMENT_RE_REF	 NUMBER(38)
	/*
	create table FILE_COMMENT (
			num number primary key,
			id varchar2(30) references member(id),
			content varchar2(200),
			reg_date date,
			comment_board_num number references board(board_num) on delete cascade,--comm테이블이 참조하는 보드 글번호가 삭제되면 같이 삭제됩니다. 
			comment_re_lev number(1) check(comment_re_lev in(0,1,2)),
			comment_re_ref number  --원문은 자신 글번호, 답글이면 원문 글번호
			);
	*/


	

}
