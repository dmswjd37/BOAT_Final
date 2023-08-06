package com.boat.controller.board;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boat.Service.BoardService;
import com.boat.domain.Board;


@Controller
@RequestMapping(value="/board")
public class boardController {
	
	private BoardService boardService;
	
	@Autowired
	public boardController(BoardService boardservice) {
		
		this.boardService = boardservice;
		
	}
	

	@RequestMapping(value="/List", method=RequestMethod.GET)
	public ModelAndView boardList(@RequestParam(value="page",defaultValue="1",required=false) int page,
									ModelAndView mv	) {
		int limit = 10; 
		int listcount = boardService.getListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page-1) /10) *10 +1;
		int endpage = startpage +10 -1;
		
		if(endpage>maxpage)
			endpage=maxpage;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    String today = format.format(cal.getTime());
	    cal.add(Calendar.DAY_OF_MONTH, -3); //3일간 보이도록 하기위해서.
	    String nowday = format.format(cal.getTime());
		
		
	  List<Board> boardlist = boardService.getBoardList(page,limit);
		
		mv.setViewName("Board/boardList");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("boardlist",boardlist);
		mv.addObject("limit",limit);
		mv.addObject("nowday",nowday);
		mv.addObject("today",today);
		
		return mv;
	}
	  @GetMapping("/Fav_check")
	    public boolean fav_check(@RequestParam("boardNum") int boardNum,
	                                  @RequestParam("empno") int empno) {
	        int count = boardService.checkFav(boardNum, empno);
	        return count == 1;
	    }
	
	@GetMapping(value="/Write")
	public String board_write() {
		return "Board/board_write";
	}
	
	@PostMapping("/add")
	public String add(Board board, HttpServletRequest request) throws Exception{
				//뷰페이지에 empno를 구해오는 쿼리문도 넣어야함
		boardService.insertBoard(board);
		
		
		return"redirect:List";

	}
	
	@GetMapping("/detail")
	   public ModelAndView Detail (
	            int num,ModelAndView mv, HttpServletRequest request,
	            @RequestHeader(value="referer", required=false) String beforeURL){

		
		if(beforeURL!=null && beforeURL.contains("List")) {
			boardService.setReadCountUpdate(num);
		}
		
		Board board = boardService.getDetail(num);
		
		if(board==null) {
		
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message","상세보기 실패입니다.");
		}
		else {
			
			//int count = commentService.getListCount(num);
			mv.setViewName("Board/board_view2");
			//mv.addObject("count", count);
			mv.addObject("boarddata", board);
		}
		return mv;
	}
	
	@PostMapping("/Fav_add")
	public String fav_add(@RequestParam(value="BOARD_NUM") int bOARD_NUM,
						  @RequestParam(value="BOARD_EMPNO") int bOARD_EMPNO,
						  @RequestParam(value="BOARD_DEPT") String bOARD_DEPT){
				//뷰페이지에 empno를 구해오는 쿼리문도 넣어야함
		boardService.insertFav(bOARD_NUM,bOARD_EMPNO,bOARD_DEPT);
		
		
		return"redirect:List";

	}
	
	@PostMapping("/Fav_delete")
	public String fav_delete(@RequestParam(value="BOARD_NUM") int bOARD_NUM,
						  @RequestParam(value="BOARD_EMPNO") int bOARD_EMPNO){
				//뷰페이지에 empno를 구해오는 쿼리문도 넣어야함
		boardService.deleteFav(bOARD_NUM,bOARD_EMPNO);
		
		
		return"redirect:List";

	}
	
	
	@ResponseBody
	@RequestMapping(value="/Fav_List")
	public Map<String, Object> FavAjax(@RequestParam(value="page", defaultValue="1", required=false) int page, 
									   @RequestParam(value="limit", defaultValue="10", required=false) int limit,
									   @RequestParam(value="BOARD_EMPNO") String empno,
									   @RequestParam(value="dept", required=false) String dept,
									   @RequestParam(value="order", required=false) String order
									   
			){
		if(dept.equals("부서별보기")) {
			dept = "";
		}
		if(order.equals("정렬옵션")) {
			order = "";
		} else if (order.equals("최신순")) {
			order = "board_date";
		} else if( order.equals("조회순")) {
			order = "board_readcount";
		} else if (order.equals("댓글순")) {
			order = "cnt";
		}
	
		int listcount = boardService.getFavListCount(dept);
		
		int maxpage = (listcount + limit - 1) / limit;
		
		
		int startpage = ((page-1) /10) *10 +1;
		
		int endpage = startpage +10 -1;
			
		if(endpage > maxpage)
			endpage = maxpage;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    String today = format.format(cal.getTime());
	    cal.add(Calendar.DAY_OF_MONTH, -3); //3일간 보이도록 하기위해서.
	    String nowday = format.format(cal.getTime());
		
	    int empno2 = Integer.parseInt(empno);
	    
	    
		List<Board> boardlist = boardService.getFavBoardList(page, limit,empno2,dept,order);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("page",page);
		map.put("maxpage",maxpage);
		map.put("startpage",startpage);
		map.put("endpage",endpage); 
		map.put("listcount",listcount);
		map.put("boardlist",boardlist);
		map.put("limit",limit);
		map.put("nowday",nowday);
		map.put("today",today);
		
		return map;
	}
	
	@GetMapping("/modifyView")
	
	   public ModelAndView BoardModifyView (
	            int num,ModelAndView mv, HttpServletRequest request){

				
		Board boarddata = boardService.getDetail(num);
		
		
		
		if(boarddata == null) {
			
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message","수정보기 실패입니다.");
			return mv;
		}
	
		mv.addObject("boarddata", boarddata);
		mv.setViewName("Board/board_modify");
			
		
		return mv;
	}
	
	@PostMapping("/modifyAction")
	   public String BoardModifyAction (
	            Board boarddata, String check, Model mv, HttpServletRequest request, RedirectAttributes rattr)
	throws Exception{
		
		boolean usercheck = boardService.isBoardWriter(boarddata.getBOARD_NUM(), boarddata.getBOARD_PASS());
		
		String url="";
		
		if(usercheck == false) {
			rattr.addFlashAttribute("result","passFail");
			rattr.addAttribute("num", boarddata.getBOARD_NUM());
			return "redirect:modifyView";
			
		}
		
		//dao
		int result = boardService.boardModify(boarddata);
		
		if(result ==0) {
				
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message","게시판 수정실패입니다.");
			url="error/error";
		} else {
			
			url="redirect:detail";
			
			rattr.addAttribute("num", boarddata.getBOARD_NUM());
			
		}
		return url; 
				
		
	}

	
	@GetMapping("/replyView")
	
	   public ModelAndView BoardReplyView (
	            int num,ModelAndView mv, HttpServletRequest request){

				
		Board board = boardService.getDetail(num);
				
		if(board == null) {

			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message","게시판 답글 가져오기 실패입니다.");
			
		}else {
	
			mv.addObject("message","답글 가져오기 성공.");
			mv.addObject("boarddata", board);
			mv.setViewName("Board/board_reply");
			
		}
	
		return mv;
	}
	
	@PostMapping("/replyAction")
	   public ModelAndView BoardReplyAction (
	            Board board, ModelAndView mv, HttpServletRequest request, RedirectAttributes rattr)
	{
		
	
		int result = boardService.boardReply(board);
		
		if(result ==0) {
			
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message","게시판 답변 처리 실패");
		} else {
			
			
			mv.addObject("message","답글 생성 성공.");
			rattr.addAttribute("num", board.getBOARD_NUM());
			mv.setViewName("redirect:detail");

		}
		return mv; 

	}
	

	
	@PostMapping("/delete")
	   public String BoardDeleteAction (
	            String BOARD_PASS, int num, Model mv, HttpServletRequest request, RedirectAttributes rattr)
	{
		
		boolean usercheck = boardService.isBoardWriter(num, BOARD_PASS);
		
		String url="";
			
		if(usercheck == false) {
			rattr.addFlashAttribute("result","passFail");
			rattr.addAttribute("num", num);
			return "redirect:detail";
			
		}
		
		int result = boardService.boardDelete(num);
		
		if(result == 0) {
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message","삭제 실패");
			return "error/error";
			
		}
		
		rattr.addFlashAttribute("result", "deleteSuccess");
		
		return "redirect:List";
	}
	
	@ResponseBody
	@PostMapping(value="/search")
	public Map<String, Object> SearchAjax(@RequestParam(value="page", defaultValue="1", required=false) int page, 
									   @RequestParam(value="limit", defaultValue="10", required=false) int limit,
									   @RequestParam(value="search1") String search1,
									   @RequestParam(value="option1") String option1,
									   @RequestParam(value="dept", required=false) String dept,
									   @RequestParam(value="order", required=false) String order
									   
			){
		if(dept.equals("부서별보기")) {
			dept = "";
		}
		if(order.equals("정렬옵션")) {
			order = "";
		} else if (order.equals("최신순")) {
			order = "board_date";
		} else if( order.equals("조회순")) {
			order = "board_readcount";
		} else if (order.equals("댓글순")) {
			order = "cnt";
		}
		if(option1.equals("제목")){
			option1 = "board.board_subject";
		}
		if(option1.equals("작성자")){
			option1 = "board.board_name";
		}
		String search2 = "%"+ search1 +"%";
		search1 = search2;
		
	
		int listcount = boardService.getSearchListCount(search1,option1,dept);
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page-1) /10) *10 +1;
		int endpage = startpage +10 -1;
		if(endpage > maxpage)
			endpage = maxpage;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    String today = format.format(cal.getTime());
	    cal.add(Calendar.DAY_OF_MONTH, -3); //3일간 보이도록 하기위해서.
	    String nowday = format.format(cal.getTime());
		
		List<Board> boardlist = boardService.getSearchBoardList(page, limit,search1,option1,dept,order);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("page",page);
		map.put("maxpage",maxpage);
		map.put("startpage",startpage);
		map.put("endpage",endpage); 
		map.put("listcount",listcount);
		map.put("boardlist",boardlist);
		map.put("limit",limit);
		map.put("nowday",nowday);
		map.put("today",today);
		
		return map;
	}

	@ResponseBody
	@PostMapping(value="/list_ajax")
	public Map<String, Object> listAjax(@RequestParam(value="page", defaultValue="1", required=false) int page, 
									   @RequestParam(value="limit", defaultValue="10", required=false) int limit,
									   @RequestParam(value="dept") String dept,
									   @RequestParam(value="order") String order
									   
			){
		if(dept.equals("부서별보기")) {
			dept = "";
		}
		if(order.equals("정렬옵션")) {
			order = "";
		} else if (order.equals("최신순")) {
			order = "board_date";
		} else if( order.equals("조회순")) {
			order = "board_readcount";
		} else if (order.equals("댓글순")) {
			order = "cnt";
		}
		int listcount = boardService.getOptionListCount(dept);
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page-1) /10) *10 +1;
		int endpage = startpage +10 -1;
		if(endpage > maxpage)
			endpage = maxpage;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    String today = format.format(cal.getTime());
	    cal.add(Calendar.DAY_OF_MONTH, -3); //3일간 보이도록 하기위해서.
	    String nowday = format.format(cal.getTime());
		
		List<Board> boardlist = boardService.getOptionBoardList(page, limit,dept,order);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("page",page);
		map.put("maxpage",maxpage);
		map.put("startpage",startpage);
		map.put("endpage",endpage); 
		map.put("listcount",listcount);
		map.put("boardlist",boardlist);
		map.put("limit",limit);
		map.put("nowday",nowday);
		map.put("today",today);
		
		return map;
	}
	
	
	
	
	
	
	
	
	
	
}