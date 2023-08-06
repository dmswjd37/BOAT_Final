package com.boat.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Board;
import com.boat.domain.bComment;


@Mapper
public interface bCommentMapper {
	public int getListCount(int board_num);
	
	public List<bComment> getCommentList(Map<String, Integer> map);
	
	public int commentsInsert(bComment c);
	
	public int commentsDelete(int num);
	
	public int commentsUpdate(bComment co);
}
