package com.boat.Service.Calendar;

import java.util.List;

import com.boat.domain.Calendar;


public interface CalendarService { 
	
	//이벤트 갯수 
	public int getListcount();

	//이벤트 삽입후 렌더 이벤트 가져옴
	public Calendar insertcal(Calendar cal);
	

	//dept있을때
	public List<Calendar> getEventsByDept(String DEPT);
	
	//	dept없을때
	public List<Calendar> getAllEvents();


	public int checkevent(String EMPNO, String EVENT_NAME);

	
	
	

}
