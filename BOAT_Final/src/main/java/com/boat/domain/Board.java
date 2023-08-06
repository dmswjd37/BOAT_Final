package com.boat.domain;

public class Board {
private int BOARD_NUM;
private String BOARD_NAME;
private String BOARD_PASS;
private String BOARD_SUBJECT;
private String BOARD_CONTENT;
private String BOARD_DEPT;
private String BOARD_JOB;
private int BOARD_NOTICE;
private int BOARD_RE_REF;
private int BOARD_RE_LEV;
private int BOARD_RE_SEQ;
private int BOARD_READCOUNT;
private String BOARD_DATE;
private int BOARD_EMPNO;
private int CNT;
private String abc; //join해서 empno담아옴

public String getAbc() {
	return abc;
}
public void setAbc(String abc) {
	this.abc = abc;
}
public int getCNT() {
	return CNT;
}
public void setCNT(int cNT) {
	CNT = cNT;
}
public int getBOARD_NOTICE() {
	return BOARD_NOTICE;
}
public void setBOARD_NOTICE(int bOARD_NOTICE) {
	BOARD_NOTICE = bOARD_NOTICE;
}
public String getBOARD_JOB() {
	return BOARD_JOB;
}
public void setBOARD_JOB(String bOARD_JOB) {
	BOARD_JOB = bOARD_JOB;
}

public int getBOARD_NUM() {
	return BOARD_NUM;
}
public void setBOARD_NUM(int bOARD_NUM) {
	BOARD_NUM = bOARD_NUM;
}
public String getBOARD_NAME() {
	return BOARD_NAME;
}
public void setBOARD_NAME(String bOARD_NAME) {
	BOARD_NAME = bOARD_NAME;
}
public String getBOARD_PASS() {
	return BOARD_PASS;
}
public void setBOARD_PASS(String bOARD_PASS) {
	BOARD_PASS = bOARD_PASS;
}
public String getBOARD_SUBJECT() {
	return BOARD_SUBJECT;
}
public void setBOARD_SUBJECT(String bOARD_SUBJECT) {
	BOARD_SUBJECT = bOARD_SUBJECT;
}
public String getBOARD_CONTENT() {
	return BOARD_CONTENT;
}
public void setBOARD_CONTENT(String bOARD_CONTENT) {
	BOARD_CONTENT = bOARD_CONTENT;
}
public String getBOARD_DEPT() {
	return BOARD_DEPT;
}
public void setBOARD_DEPT(String bOARD_DEPT) {
	BOARD_DEPT = bOARD_DEPT;
}
public int getBOARD_RE_REF() {
	return BOARD_RE_REF;
}
public void setBOARD_RE_REF(int bOARD_RE_REF) {
	BOARD_RE_REF = bOARD_RE_REF;
}
public int getBOARD_RE_LEV() {
	return BOARD_RE_LEV;
}
public void setBOARD_RE_LEV(int bOARD_RE_LEV) {
	BOARD_RE_LEV = bOARD_RE_LEV;
}
public int getBOARD_RE_SEQ() {
	return BOARD_RE_SEQ;
}
public void setBOARD_RE_SEQ(int bOARD_RE_SEQ) {
	BOARD_RE_SEQ = bOARD_RE_SEQ;
}
public int getBOARD_READCOUNT() {
	return BOARD_READCOUNT;
}
public void setBOARD_READCOUNT(int bOARD_READCOUNT) {
	BOARD_READCOUNT = bOARD_READCOUNT;
}
public String getBOARD_DATE() {
	return BOARD_DATE;
}
public void setBOARD_DATE(String bOARD_DATE) {
	BOARD_DATE = bOARD_DATE;
}
public int getBOARD_EMPNO() {
	return BOARD_EMPNO;
}
public void setBOARD_EMPNO(int bOARD_EMPNO) {
	BOARD_EMPNO = bOARD_EMPNO;
}

}
