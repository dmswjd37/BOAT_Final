package com.boat.Service;

import java.util.List;

import com.boat.domain.Board;



public interface BoardService {

	 public int getListCount();
	   
	   public List<Board> getBoardList(int page, int limit);
	   
	   public Board getDetail(int num);
	   
	   public int boardReply(Board board);
	   
	   public int boardModify(Board modifyboard);
	   
	   public int boardDelete(int num);
	   
	   public int setReadCountUpdate(int num);
	   
	   public boolean isBoardWriter(int num,String pass);
	   
	   public void insertBoard(Board board);

	   public int boardReplyUpdate(Board board);

	
	public void deleteFileList(String filename);
	
	public List<String> getDeleteFileList();

	public void insertFav(int bOARD_NUM, int bOARD_EMPNO, String bOARD_DEPT);

	public int getFavListCount(String dept);

	public List<Board> getFavBoardList(int page, int limit, int empno, String dept, String order);

	public void deleteFav(int bOARD_NUM, int bOARD_EMPNO);

	public int checkFav(int boardNum, int empno);

	public int getSearchListCount(String search1, String option1, String dept);

	public List<Board> getSearchBoardList(int page, int limit, String search1, String option1, String dept, String order);

	public int getOptionListCount(String dept);

	public List<Board> getOptionBoardList(int page, int limit, String dept, String order);

	

	

	
	
}
