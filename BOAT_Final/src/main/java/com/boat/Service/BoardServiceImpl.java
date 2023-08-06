package com.boat.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.domain.Board;
import com.boat.mybatis.mapper.BoardMapper;

	@Service
	public class BoardServiceImpl implements BoardService{
		
		private BoardMapper dao;
		
		@Autowired
		public BoardServiceImpl(BoardMapper dao) {
			this.dao = dao;
		}

		@Override
		public int getListCount() {
			return dao.getListCount();
		}

		@Override
		public List<Board> getBoardList(int page, int limit) {
			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			
			int startrow = (page-1) * limit + 1;
			int endrow = startrow + limit - 1;
			
			map.put("start", startrow);
			map.put("end", endrow);
			
			
			return dao.getBoardList(map);
		}

		@Override
		public Board getDetail(int num) {
			return dao.getDetail(num);
		}
		
		@Override
		public int boardReplyUpdate(Board board) {
			return dao.boardReplyUpdate(board);
		}
		
		@Override
		public int boardReply(Board board) {
			boardReplyUpdate(board);
			
			board.setBOARD_RE_LEV(board.getBOARD_RE_LEV()+1);
			board.setBOARD_RE_SEQ(board.getBOARD_RE_SEQ()+1);
			return dao.boardReply(board);
		}

		@Override
		public int boardModify(Board modifyboard) {
			return dao.boardModify(modifyboard);
		}

		@Override
		public int boardDelete(int num) {
			int result = 0;
			Board board = dao.getDetail(num);
			
			if(board != null) {
				result = dao.boardDelete(board);
			}
			return result;
		}

		@Override
		public int setReadCountUpdate(int num) {
			return dao.setReadCountUpdate(num);
		}
		
		

		@Override
		public boolean isBoardWriter(int num, String pass) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("num", num);
			map.put("pass", pass);
			
			Board result = dao.isBoardWriter(map);
			if(result == null) 
				return false;
			else
				return true;
		}

		@Override
		public void insertBoard(Board board) {
			dao.insertBoard(board);
			
		}

		@Override
		public List<String> getDeleteFileList(){
			return dao.getDeleteFileList();
		} 
		
		@Override
		public void deleteFileList(String filename){
			dao.deleteFileList(filename);
		}

		@Override
		public void insertFav(int bOARD_NUM, int bOARD_EMPNO,String bOARD_DEPT) {
			dao.insertFav(bOARD_NUM,bOARD_EMPNO,bOARD_DEPT);
		}

		
		@Override
		public void deleteFav(int bOARD_NUM, int bOARD_EMPNO) {
			dao.deleteFav(bOARD_NUM,bOARD_EMPNO);
			
		}

		@Override
		public int getFavListCount(String dept) {
			return dao.getFavListCount(dept);
		}

		
		
		@Override
		public int checkFav(int boardNum, int empno) {
			
			return dao.checkFav(boardNum,empno);
		}

		@Override
		public List<Board> getFavBoardList(int page, int limit, int empno, String dept, String order) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int startrow = (page-1) * limit + 1;
			int endrow = startrow + limit - 1;
			
			map.put("start", startrow);
			map.put("end", endrow);
			map.put("BOARD_EMPNO",empno);
			map.put("dept", dept);
			map.put("order", order);
			
			
			return dao.getFavBoardList(map);
		}

		@Override
		public int getSearchListCount(String search1, String option1, String dept) {
			return dao.getSearchListCount(search1,option1,dept);
		}

		@Override
		public List<Board> getSearchBoardList(int page, int limit, String search1, String option1,String dept, String order) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int startrow = (page-1) * limit + 1;
			int endrow = startrow + limit - 1;
			
			map.put("start", startrow);
			map.put("end", endrow);
			map.put("option1", option1);
			map.put("search1", search1);
			map.put("dept", dept);
			map.put("order", order);
			
			return dao.getSearchBoardList(map);
		}

		@Override
		public int getOptionListCount(String dept) {
			return dao.getOptionListCount(dept);
		}

		@Override
		public List<Board> getOptionBoardList(int page, int limit, String dept, String order) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int startrow = (page-1) * limit + 1;
			int endrow = startrow + limit - 1;
			
			map.put("start", startrow);
			map.put("end", endrow);
			map.put("dept", dept);
			map.put("order", order);
			
			return dao.getOptionBoardList(map);
		}

		
}

