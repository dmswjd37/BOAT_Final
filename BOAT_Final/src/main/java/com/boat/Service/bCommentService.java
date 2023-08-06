package com.boat.Service;

import java.util.List;

import com.boat.domain.Board;
import com.boat.domain.bComment;




public interface bCommentService {

	public int getListCount(int board_num);
	
	public List<bComment> getCommentList(int board_num, int page);
	
	public int commentsInsert(bComment c);
	
	public int commentsDelete(int num);
	
	public int commentsUpdate(bComment co);
	

	

	
	
}
