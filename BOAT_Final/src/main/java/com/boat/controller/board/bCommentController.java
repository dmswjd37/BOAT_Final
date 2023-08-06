package com.boat.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.boat.Service.bCommentService;
import com.boat.domain.bComment;


@RestController

@RequestMapping(value="/bcomment")
public class bCommentController {

	
private bCommentService commentService;
	
	@Autowired
	public bCommentController(bCommentService commentService) {
		this.commentService = commentService;
	}
	@PostMapping(value="/list")
	public Map<String,Object> CommentList(int board_num, int page){
		
		List<bComment> list = commentService.getCommentList(board_num, page);
		int listcount = commentService.getListCount(board_num);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("listcount", listcount);
		
		return map;
		
	}
	
	@ResponseBody
	@PostMapping(value="/add")
	public int CommentAdd(bComment c) {
		
		return commentService.commentsInsert(c);
	}
	
	@ResponseBody
	@PostMapping(value="/update")
	public int CommentUpdate(bComment co) {
		
		return commentService.commentsUpdate(co);
	}
	
	@ResponseBody
	@PostMapping(value="/delete")
	public int CommentDelete(int num) {
		
		return commentService.commentsDelete(num);
	}

}
