package com.boat.Service.WorkBoard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.aop.LogAdvice;
import com.boat.domain.Workboard;
import com.boat.mybatis.mapper.WorkboardMapper;

@Service
public class WorkboardServiceImpl implements WorkboardService{
	
	private  WorkboardMapper dao;
	private LogAdvice log;
	
	@Autowired
	public  WorkboardServiceImpl( WorkboardMapper dao, LogAdvice log) {
		this.dao = dao;
		this.log = log;
	}

	
	
	@Override
	public int getListCount() {
		return dao.getListCount();
	}
	

	@Override
	public List<Workboard> getWorkboardList(int page) {
		int startrow = 1;
		int endrow = page * 5;
		
		Map<String,Integer> map = new HashMap<String,Integer>();

		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getWorkboardList(map);
	}

	
	
	@Override
	public int workboardInsert(Workboard c) {
		return dao.workboardInsert(c);
	}

	
	@Override
	public int workboardDelete(int num) {
		return dao.workboardDelete(num);
	}

	
	@Override
	public int workboardUpdate(Workboard co) {
		return dao.workboardUpdate(co);
	}

}
