package com.boat.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Workboard;

@Mapper
public interface  WorkboardMapper {

			public int getListCount();
			
			//댓글 목록 가져오기
			public List<Workboard> getWorkboardList(Map<String, Integer> map);
			
			//댓글 등록하기
			public int workboardInsert(Workboard c);
			
			//댓글 삭제
			public int workboardDelete(int num);
			
			//댓글 수정
			public int workboardUpdate(Workboard co);
			
			

}
