package com.boat.Service.FileboService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.domain.Filebo;
import com.boat.mybatis.mapper.FileboMapper;

@Service
public class FileBoServiceImpl implements FileBoService {

	private FileboMapper dao;
	public FileBoServiceImpl() {
	}
		 
		 @Autowired 
		 public FileBoServiceImpl(FileboMapper dao) { 
			 this.dao = dao; 
			 }
		
	
	
	@Override
	public int getListCount() {
		System.out.println("dao getlistcount 전");
		return dao.getListCount();     
	}

	@Override
	public List<Filebo> getBoardList(int page, int limit) {
		
		HashMap<String,Integer>map = new HashMap<String,Integer>();
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		map.put("start",startrow);
		map.put("end", endrow);
		
		return dao.getBoardList(map);
	}


	@Override
	public void insertBoard(Filebo board) {
		dao.insertBoard(board);
	}
	
	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public boolean isBoardWriter(int num, String pass) {
		HashMap<String, Object>map = new HashMap<String,Object>();
		map.put("num", num);
		map.put("pass", pass);
		Filebo result = dao.isBoardWriter(map);
		if(result==null)
			return false;
		else
			return true;
		
	}
	
	@Override
	public int boardModify(Filebo modifyboard) {
		return dao.boardModify(modifyboard);
	}
	@Override
	public Filebo getDetail(int num) {
		
		return dao.getDetail(num); 
	}

	@Override
	public int boardReply(Filebo board) {
		boardReplyUpdate(board);
		board.setFILE_RE_LEV(board.getFILE_RE_LEV()+1);
		board.setFILE_RE_SEQ(board.getFILE_RE_SEQ()+1);
		return dao.boardReply(board);
	}

	

	public int boardReplyUpdate(Filebo board) {

		return dao.boardReplyUpdate(board);		
	}


	@Override
	public int boardDelete(int num) {
		int result = 0;
		Filebo board = dao.getDetail(num);
		if(board !=null) {
			result = dao.boardDelete(board);
		}
		
		return result;
	}


	@Override
	public List<String> getDeleteFileList() {
		return dao.getDeleteFileList();
	}


	@Override
	public void deleteFileList(String filename) {
		dao.deleteFileList(filename);
	}

	@Override
	public List<Filebo> getSearchList(String dept, String searchsel, String searchinput, String order, int page,
			int limit) {
		
		
		HashMap<String, Object>map = new HashMap<String,Object>();
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		System.out.println("................................searchsel"+searchsel);
		map.put("dept", dept);
		map.put("searchsel", searchsel);
		map.put("searchinput",'%'+searchinput+'%');
		map.put("order", order);
		
		map.put("start",startrow);
		map.put("end", endrow);
		
		
		return dao.getSearchList(map);
	}

	@Override
	public int getSearchListCount(String dept, String searchsel, String searchinput, String order, int page,
			int limit) {
		HashMap<String, Object>map = new HashMap<String,Object>();
		map.put("dept", dept);
		map.put("searchsel", searchsel);
		map.put("searchinput",'%'+searchinput+'%');
		map.put("order", order);
		map.put("page", page);
		map.put("limit", limit);
		
		
		return dao.getSearchListCount(map);
	}

	@Override
	public int myFavListCount(String EMPNO) {
		//HashMap<String, Object>map = new HashMap<String,Object>();
		//map.put("EMPNO", map);
		//map.put("page", page);
		//map.put("limit", limit);
		int a =1;
		System.out.println(a++);
		return dao.myFavListCount(EMPNO);
	}

	@Override
	public List<Filebo> myFavList(String eMPNO, int page, int limit) {
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object>map = new HashMap<String,Object>();
		
		map.put("EMPNO", eMPNO);
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.myFavList(map);
	}

	@Override
	public int insertfav(String fILE_EMPNO, String fILE_NUM) {
HashMap<String, Object>map = new HashMap<String,Object>();
//System.out.println(fILE_EMPNO+fILE_NUM+"+++++++++++nnnnnnnnnn++++++++++++");
		map.put("FILE_EMPNO", fILE_EMPNO);
		map.put("FILE_NUM", fILE_NUM);
		return dao.InsertFav(map);
		
	}

	@Override
	public int deletefav(String fILE_EMPNO, String fILE_NUM) {
HashMap<String, Object>map = new HashMap<String,Object>();
System.out.println(fILE_EMPNO+fILE_NUM+"+++++++++++nnnnnnnnnn++++++++++++");
		map.put("FILE_EMPNO", fILE_EMPNO);
		map.put("FILE_NUM", fILE_NUM);
		return dao.deleteFav(map);
	}

	@Override
	public Filebo getstar(String eMPNO) {
		return dao.getstar(eMPNO);
		
	}



}
