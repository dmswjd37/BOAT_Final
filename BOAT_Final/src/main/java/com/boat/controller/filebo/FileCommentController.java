package com.boat.controller.filebo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boat.Service.FileboService.FileCommentService;
import com.boat.domain.Filecomm;

//@Controller+@ResponseBody
@RestController
@RequestMapping(value="/Filebocom")
public class FileCommentController {
	 
	FileCommentService commentService;
	
	public FileCommentController(FileCommentService commentService) {
		this.commentService = commentService;
	}
	private static final Logger logger=LoggerFactory.getLogger(FileCommentController.class);
	
	
	//@PostMapping(value = "/list")
	@GetMapping(value = "/list")
	public Map<String,Object>CommentList(int FILE_BO_NUM, int state){
		System.out.println("state,,,,,,,,,,,,,,,,"+state);
		
		List<Filecomm> list = commentService.getCommentList(FILE_BO_NUM,state);
		
		System.out.println("list사이즈를 봅시다"+list.size());
		logger.info(list.toString());// [null, null]
		
		
		int listcount = commentService.getListCount(FILE_BO_NUM);
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("listcount",listcount);
		logger.info("listcount= " + listcount);
		return map;
	}
	
	//@ResponseBody
	@RequestMapping(value="/add")
	public int commentAdd(Filecomm co){
		System.out.println(co.toString());
		return  commentService.commentInsert(co);
		
		
	}
	
	@RequestMapping(value="/update")
	public int commentUpdate(Filecomm co){
		
		return  commentService.commentsUpdate(co);
		
		
}
	@RequestMapping(value="/reply")
	public int commentReply(Filecomm co){
		
		return  commentService.commentreply(co);
		
		
	}
	@RequestMapping(value="/delete")
	public int commentUpdate(int num){
		
		return  commentService.commentsDelete(num);}
	

}
