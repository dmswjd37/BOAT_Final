package com.boat.Service.FileboService;

import java.util.List;

import com.boat.domain.Filecomm;

public interface FileCommentService {

	
	//글의 갯수 구하기
	public int getListCount(int board_num);

	//댓글 목록 가져오기
	public List<Filecomm> getCommentList(int board_num,int page);
	
	//댓글 등록하기
	public int commentInsert(Filecomm c);
	
	//댓글 삭제
	public int commentsDelete(int num);
	
	//댓글 수정
	public int commentsUpdate(Filecomm co);

	//댓글 답글
	public int commentreply(Filecomm co);
}
