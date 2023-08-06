package com.boat.controller.workboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boat.Service.WorkBoard.WorkboardService;
import com.boat.controller.main.HomeController;
import com.boat.domain.Workboard;


@Controller
@RequestMapping(value="/workboard")
public class  WorkboardController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	private  WorkboardService WorkboardService;
	
	@GetMapping("/workboard_list")
	public String hello() {
		return "/WorkBoard/workboard_list";
	}
	

	
	@Autowired
	public  WorkboardController( WorkboardService WorkboardService) {
		this.WorkboardService = WorkboardService;
	}

	@ResponseBody
	@PostMapping(value="/list")
	public Map<String,Object> WorkboardList(int page) {
			List<Workboard> list = WorkboardService.getWorkboardList(page);
			int listcount = WorkboardService.getListCount();
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("listcount", listcount);
			return map;
	}

	
	@ResponseBody
	@PostMapping(value="/add")
	//public int CommentAdd(String EMPNO, String category, String NAME, String DEPT, String content, String reg_date) {
	public int CommentAdd	(Workboard co) {
		/*
		 * Workboard co = new Workboard(); System.out.println(EMPNO);
		 * co.setCategory(category); co.setEMPNO(EMPNO); co.setContent(content);
		 * co.setDEPT(DEPT); co.setNAME(NAME); co.setReg_date(reg_date);
		 */
		return WorkboardService.workboardInsert(co);		
	}
	
	@ResponseBody
	@PostMapping(value="/update")
	public int CommentUpdate(Workboard co) {
		return WorkboardService.workboardUpdate(co);				
	}
	
	
	@ResponseBody
	@PostMapping(value="/delete")
	public int CommentDelete(int num) {
		return WorkboardService.workboardDelete(num);				
	}
	
	
	
	@GetMapping("/detail")
	public ModelAndView Detail(int num, ModelAndView mv) {
		mv.setViewName("/WorkBoard/workboard_list");
		mv.addObject("num", String.valueOf(num));
		
		return mv;
	}
			   
}
