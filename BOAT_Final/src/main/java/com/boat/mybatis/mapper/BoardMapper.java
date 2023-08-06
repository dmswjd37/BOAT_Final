package com.boat.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Board;

@Mapper
public interface BoardMapper {
	public int getListCount();
	
	public List<Board> getBoardList(HashMap<String, Integer> map);
	
	public Board getDetail(int num);
	
	public int boardReply(Board board);
	
	public int boardModify(Board modifyboard);
	
	public int boardDelete(Board board);
	
	public int setReadCountUpdate(int num);
	
	public Board isBoardWriter(HashMap<String, Object> map);
	
	public void insertBoard(Board board);
	
	public int boardReplyUpdate(Board board);
	
	public List<String> getDeleteFileList();
	
	public void deleteFileList(String filename);

	public void insertFav(int bOARD_NUM, int bOARD_EMPNO, String bOARD_DEPT);

	public int getFavListCount(String dept);

	public List<Board> getFavBoardList(HashMap<String, Object> map);

	public void deleteFav(int bOARD_NUM, int bOARD_EMPNO);

	public int checkFav(int boardnum, int empno);

	public int getSearchListCount(String search1, String option1, String dept);

	public List<Board> getSearchBoardList(HashMap<String, Object> map);

	public int getOptionListCount(String dept);

	public List<Board> getOptionBoardList(HashMap<String, Object> map);
}
