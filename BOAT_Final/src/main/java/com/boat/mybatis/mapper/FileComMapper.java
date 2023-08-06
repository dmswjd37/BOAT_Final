package com.boat.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Filecomm;

@Mapper
public interface FileComMapper {

	
	//글의 갯수 구하기
	public int getListCount(int board_num);

	//댓글 목록 가져오기
	public List<Filecomm> getCommentList(Map<String,Integer>map);
	
	//댓글 등록하기
	public int commentInsert(Filecomm c);
	
	//댓글 삭제
	public int commentsDelete(int num);
	
	//댓글 수정
	public int commentsUpdate(Filecomm co);

	public int commentsreply(Filecomm co);

	public int commentreplyUpdate(Filecomm co);
}
