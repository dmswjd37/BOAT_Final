package com.boat.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.domain.Board;
import com.boat.domain.bComment;
import com.boat.mybatis.mapper.BoardMapper;
import com.boat.mybatis.mapper.bCommentMapper;


	@Service
	public class bCommentServiceImpl implements bCommentService{

		private bCommentMapper dao;
		
		@Autowired
		public bCommentServiceImpl(bCommentMapper dao) {
			this.dao = dao;
		}

		
		
		
		@Override
		public int getListCount(int board_num) {
			return dao.getListCount(board_num);
		}

		@Override
		public List<bComment> getCommentList(int board_num, int page) {

			
			
			int startrow = 1;
			int endrow = page * 3;
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			
			map.put("board_num", board_num);
			map.put("start", startrow);
			map.put("end", endrow);
			
			System.out.println(map);
			
			
			return dao.getCommentList(map);
		}

		@Override
		public int commentsInsert(bComment c) {

			return dao.commentsInsert(c);
		}

		@Override
		public int commentsDelete(int num) {

			return dao.commentsDelete(num);
		}

		@Override
		public int commentsUpdate(bComment co) {
			return dao.commentsUpdate(co);
		}

	

		
}

