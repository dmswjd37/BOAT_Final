package com.boat.Service.Calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.aop.LogAdvice;
import com.boat.domain.Calendar;
import com.boat.mybatis.mapper.CalendarMapper;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	private CalendarMapper dao;
	
	@Autowired
	public CalendarServiceImpl(CalendarMapper dao) {
		this.dao = dao;
	}

	//캘린더 일정삽입
	@Override
	public Calendar insertcal(Calendar cal) {
		
		String dept = cal.getDEPT();
		if(dept.equals("홍보팀")) {
			cal.setEVENT_NAME("<홍보팀>"+cal.getEVENT_NAME());
		}else if(dept.equals("개발팀")) {
			cal.setEVENT_NAME("<개발팀>"+cal.getEVENT_NAME());
		}else if(dept.equals("기획팀")) {
			cal.setEVENT_NAME("<기획팀>"+cal.getEVENT_NAME());
		}else if(dept.equals("인사팀")) {
			cal.setEVENT_NAME("<인사팀>"+cal.getEVENT_NAME());
		}else if(dept.equals("영업팀")) {
			cal.setEVENT_NAME("<영업팀>"+cal.getEVENT_NAME());
		}		
		
		dao.calInsert(cal);
		return dao.getEvent(cal.getSCHEDULE_CODE());
				
		
	}

	@Override
	public int getListcount() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<Calendar> getEventsByDept(String DEPT) {
		return dao.getEventsByDept(DEPT);
	}

	@Override
	public List<Calendar> getAllEvents() {
		return dao.getAllEvents();
    }

	@Override
	public int checkevent(String EMPNO, String EVENT_NAME) {
		int result =0;
		Map<String,String> map = new HashMap<String,String>();
		map.put("EVENT_NAME", EVENT_NAME);
		map.put("EMPNO", EMPNO);
		Calendar resultcal = dao.getcheckEvent(map);
		
		if(resultcal!=null ) {
			result = 1;
			dao.caldelete(map);
		}
		return result;

	}





	

}
