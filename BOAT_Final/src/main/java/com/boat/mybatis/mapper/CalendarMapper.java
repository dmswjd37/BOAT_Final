package com.boat.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Calendar;

@Mapper
public interface CalendarMapper {

	//삭제예정
	List<Calendar> getCalList(String dept);

	int calInsert(Calendar cal);

	List<Calendar> getEventsByDept(String DEPT);

	List<Calendar> getAllEvents();

	Calendar getEvent(int sCHEDULE_CODE);

	Calendar getcheckEvent(Map<String, String> map);

	void caldelete(Map<String, String> map);




}
