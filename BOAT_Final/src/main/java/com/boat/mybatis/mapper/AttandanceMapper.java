package com.boat.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Attandance;

@Mapper
public interface AttandanceMapper {

	//출근버튼
	public void AttOn(String on, String EMPNO, String DEPT, String NAME);

	//퇴근버튼
	//public void AttOff(String OFF_TIME, String EMPNO);
	
	public void AttOff(Attandance att);
	

	//출퇴근 리스트 가져오기 
	public List<Attandance> getAttList();


	//당일 출근기록
	public Attandance getTodayMyatt(String EMPNO);
	//EMPNO받아서 넣기!!(완)public Attandance TodayMyatt();

	//개인 출퇴근 리스트
	public List<Attandance> getAttList(String eMPNO);

	//오늘인한시간
	public void Todayworktime(String WORK_TIME, String EMPNO);

	public String thisweekwork(Map<String, String> map);

	


}
