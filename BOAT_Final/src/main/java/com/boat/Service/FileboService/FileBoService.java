package com.boat.Service.FileboService;

import java.util.List;

import com.boat.domain.Filebo;

public interface FileBoService { 

	//글의 갯수 구하기 
	public int getListCount();
	
	//글 목록 보기
	public List<Filebo> getBoardList(int page,int limit);
	
	//글 내용 보기   
	public Filebo getDetail(int num);
	
	//글 답변
	public int boardReply(Filebo board);
	
	//글 수정
	public int boardModify(Filebo modifyboard);
	
	//글 삭제
	public int boardDelete(int num);
	
	//조회수 업데이트
	public int setReadCountUpdate(int num);
	
	//글쓴이인지 확인
	public boolean isBoardWriter(int num, String pass);
	
	//글등록하기
	public void insertBoard(Filebo board);
	
	//BOARD_RE_SEQ값 수정
	public int boardReplyUpdate(Filebo board);

	public List<String> getDeleteFileList();

	public void deleteFileList(String filename);

	public List<Filebo> getSearchList(String dept, String searchsel, String searchinput, String order, int page,
			int limit);

	public int getSearchListCount(String dept, String searchsel, String searchinput, String order, int page, int limit);

//	public int myFavListCount(String eMPNO, int page, int limit);

	public List<Filebo> myFavList(String eMPNO, int page, int limit);

	int myFavListCount(String EMPNO);

	public int insertfav(String fILE_EMPNO, String fILE_NUM);

	public int deletefav(String fILE_EMPNO, String fILE_NUM);

	public Filebo getstar(String eMPNO);
}
