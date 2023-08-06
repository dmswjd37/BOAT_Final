package com.boat.controller.address;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boat.Service.MemberService;
import com.boat.domain.Member;

@Controller
@RequestMapping(value="/address")
public class addressController {

	private MemberService memberservice;
	
	@Autowired
	public addressController(MemberService memberservice) {
		
		this.memberservice = memberservice;
		
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public ModelAndView boardList(@RequestParam(value="page",defaultValue="1",required=false) int page,
								@RequestParam(value="dept",defaultValue="전체부서", required=false) String dept,
			ModelAndView mv	) {
		int num = 0;
		if(dept.equals("전체부서")) {
			dept = "";
			num = 0;
		}else if(dept.equals("홍보팀")) {
			num = 1;
		}else if(dept.equals("개발팀")) {
			num = 2;
		}else if(dept.equals("인사팀")) {
			num = 3;
		}else if(dept.equals("기획팀")) {
			num = 4;
		}else if(dept.equals("영업팀")) {
			num = 5;
		}
		
		
		String[] st1 = {"BOAT crew","BOAT의 커뮤니케이션 전문가","BOAT의 변화를 두려워하지않는","BOAT의 신뢰를 이어주는","BOAT의 새로운 표준을 제시하는","BOAT의 게임체인저"};
		String[] st2 = {"전체부서입니다","홍보팀입니다","개발팀입니다","인사팀입니다","기획팀입니다","영업팀입니다"};
		int limit = 6; 
		int listcount = memberservice.getOptionListCount(dept);
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page-1) /10) *10 +1;
		int endpage = startpage +10 -1;
		
		if(endpage>maxpage)
			endpage=maxpage;
		
		
		
		List<Member> boardlist = memberservice.getOptionAddressList(page, limit,dept);
		
		mv.setViewName("Address/newaddress3");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("boardlist",boardlist);
		mv.addObject("limit",limit);
		mv.addObject("title1",st1[num]);
		mv.addObject("title2",st2[num]);
		if(dept.equals("")) {
		    dept = "전체부서";
		}
		mv.addObject("dept",dept);
		
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value="/list_ajax")
	public Map<String, Object> listAjax(@RequestParam(value="page", defaultValue="1", required=false) int page, 
									   @RequestParam(value="limit", defaultValue="6", required=false) int limit,
									   @RequestParam(value="dept") String dept
									   
									   
			){
		String[] st1 = {"BOAT crew","BOAT의 커뮤니케이션 전문가","BOAT의 변화를 두려워하지않는","BOAT의 신뢰를 이어주는","BOAT의 새로운 표준을 제시하는","BOAT의 게임체인저"};
		String[] st2 = {"전체부서입니다","홍보팀입니다","개발팀입니다","인사팀입니다","기획팀입니다","영업팀입니다"};
		int num = 0;
		if(dept.equals("전체부서")) {
			dept = "";
			num = 0;
		}else if(dept.equals("홍보팀")) {
			num = 1;
		}else if(dept.equals("개발팀")) {
			num = 2;
		}else if(dept.equals("인사팀")) {
			num = 3;
		}else if(dept.equals("기획팀")) {
			num = 4;
		}else if(dept.equals("영업팀")) {
			num = 5;
		}
		System.out.println("dept = " + dept);
		int listcount = memberservice.getOptionListCount(dept);
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page-1) /6) *6 +1;
		int endpage = startpage +6 -1;
		if(endpage > maxpage)
			endpage = maxpage;
		
		
		
		List<Member> memberlist = memberservice.getOptionAddressList(page, limit,dept);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("page",page);
		map.put("maxpage",maxpage);
		map.put("startpage",startpage);
		map.put("endpage",endpage); 
		map.put("listcount",listcount);
		map.put("memberlist",memberlist);
		map.put("limit",limit);
		map.put("title1",st1[num]);
		map.put("title2",st2[num]);
		
		if(dept.equals("")) {
		    dept = "전체부서";
		}
		map.put("dept", dept);
		
		
		return map;
	}
}
