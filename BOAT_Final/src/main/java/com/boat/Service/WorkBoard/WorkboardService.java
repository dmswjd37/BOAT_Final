package com.boat.Service.WorkBoard;

import java.util.List;

import com.boat.domain.Workboard;

public interface WorkboardService{
	
	public int getListCount();
		
		//댓글 목록 가져오기
		public List<Workboard> getWorkboardList(int page);
		
		//댓글 등록하기
		public int workboardInsert(Workboard c);
		
		//댓글 삭제
		public int workboardDelete(int num);
		
		//댓글 수정
		public int workboardUpdate(Workboard co);

}
