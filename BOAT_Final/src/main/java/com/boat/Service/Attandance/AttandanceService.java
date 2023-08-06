package com.boat.Service.Attandance;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.boat.domain.Attandance;

public interface AttandanceService {

	// 출근 시간 저장
	public void AttOn(String on, String empno, String dept, String name);

	// 출퇴근 리스트 불러오기
	public List<Attandance> getAttList();

	// 개인출퇴근 리스트 불러오기
	public List<Attandance> getAttList(String eMPNO);

	public void AttOff(String OFF_TIME, String EMPNO) throws ParseException;

	// 오늘 출근기록_EMPNO받아서 넣기!!
	public Attandance getTodayMyatt(String empno);

	public void getExceldata(Attandance att, HttpServletRequest request, HttpServletResponse response) throws Exception;

	public String[] thisweekwork(String firstWeekDay, String lastWeekDay, String EMPNO) throws ParseException;

}
