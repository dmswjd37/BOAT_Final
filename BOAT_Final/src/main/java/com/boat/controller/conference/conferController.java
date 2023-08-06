package com.boat.controller.conference;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boat.Service.ConferenceReservationService;
import com.boat.domain.ConferenceReservation;


@Controller
@RequestMapping(value="/confer")
public class conferController {
   
   @Autowired
     private ConferenceReservationService co;

   
   @PostMapping("/reservation")
   public String reserveConference(@RequestParam("rental") String rental,
		   						   @RequestParam("start_time") String startTime,
                                   @RequestParam("end_time") String endTime,
                                   @RequestParam("content") String content,
                                   @RequestParam("start") String start,
                                   @RequestParam("end") String end,
                                   @RequestParam("id") String id
		   						) {
    
	 LocalDateTime rTime = LocalDateTime.now();
	
	 
     ConferenceReservation c1 = new ConferenceReservation();
     c1.setSTART_TIME(startTime);
     c1.setEND_TIME(endTime);
     c1.setCONTENT(content);
     c1.setRENTAL(rental);
     c1.setSTART_T(start);
     c1.setEND_T(end);
     c1.setID(id.toString());
     c1.setABC(rTime.toString());
     
     co.insert1(c1);
     
     return "redirect:/confer/view";
   }
   
   
   

   @GetMapping("/view")
   public String mainView(	@RequestParam(value="tab_info",defaultValue="대회의실",required=false) String tab,
		   					Model model) {	
	   String[] st = {"승인대기중","승인완료","거절"};
	   
       List<ConferenceReservation> cs = co.getcal(tab);
       /*메인 캘린더용*/
       String tab2 = tab;
       tab="";
       List<ConferenceReservation> cs2 = co.getcal(tab);
       tab=tab2;
       /*메인 캘린더용*/
       List<Map<String, Object>> cList = new ArrayList<>();
       
       for (ConferenceReservation con : cs) {
    	   Map<String, Object> event = new HashMap<>();
                     
           event.put("id", con.getID());
           event.put("rental",con.getRENTAL());
           event.put("start", con.getSTART_TIME());
           event.put("end", con.getEND_TIME());
           event.put("title", con.getCONTENT());
           event.put("start_t", con.getSTART_T());
           event.put("end_t", con.getEND_T());
           String status = st[Integer.parseInt(con.getSTATUS())];
           event.put("status", status);
           event.put("memo", con.getMEMO());
           event.put("abc",con.getABC());
           
           cList.add(event);
            }
       
       /*메인 캘린더용*/
       List<Map<String, Object>> cList2 = new ArrayList<>();
       
       for (ConferenceReservation con : cs2) {
    	   Map<String, Object> event2 = new HashMap<>();
                     
           event2.put("id", con.getID());
           event2.put("rental",con.getRENTAL());
           event2.put("start", con.getSTART_TIME());
           event2.put("end", con.getEND_TIME());
           event2.put("title", con.getCONTENT());
           event2.put("start_t", con.getSTART_T());
           event2.put("end_t", con.getEND_T());
           String status = st[Integer.parseInt(con.getSTATUS())];
           event2.put("status", status);
           event2.put("memo", con.getMEMO());
           event2.put("abc",con.getABC());
           
           cList2.add(event2);
            }
       /*메인 캘린더용*/
       model.addAttribute("list_main",cList2);
       model.addAttribute("list", cList);

       
       
       
       return "/Conference_Res/conferMain";
   }
   
   
    @ResponseBody
	@RequestMapping(value="/view_ajax")
	public List<Map<String, Object>> ListAjax(@RequestParam(value="tab_info",defaultValue="대회의실",required=false) String tab
			){
		
    	 String[] st = {"승인대기중","승인완료","거절"};
  	   
         List<ConferenceReservation> cs = co.getcal(tab);
         List<Map<String, Object>> cList = new ArrayList<>();
         
         for (ConferenceReservation con : cs) {
        	 if(Integer.parseInt(con.getSTATUS()) ==1) {
      	   	 Map<String, Object> event = new HashMap<>(); 
             event.put("id", con.getID());
             event.put("rental",con.getRENTAL());
             event.put("start", con.getSTART_TIME());
             event.put("end", con.getEND_TIME());
             event.put("title", con.getCONTENT());
             event.put("start_t", con.getSTART_T());
             event.put("end_t", con.getEND_T());
             String status = st[Integer.parseInt(con.getSTATUS())];
             event.put("status", status);
             event.put("memo", con.getMEMO());
             event.put("abc",con.getABC());
             
             cList.add(event);
        	 }
            }
         
		return cList;
	}
   
    @RequestMapping(value="/admit") //admit 최초 접속시 뷰페이지 처리
    public ModelAndView confer_admit(@RequestParam(value="page", defaultValue="1", required=false) int page,
                               @RequestParam(value="tab",defaultValue="전체",  required=false) String tab,
                               ModelAndView model) {
    	if(tab.equals("전체")){
    		tab="";
    		} 
    	
    	int limit = 8;
    	int listcount = co.listcount(tab);
    	int maxpage = (listcount + limit - 1) / limit;
    	
    	
    	    	    	
        int startpage = ((page-1) /limit) *limit +1;
        int endpage = startpage +limit -1;
        int startrow = (page -1) * limit +1; 
		int endrow = startrow + limit -1;	
		if(endpage>maxpage)
            endpage=maxpage;
    	
        List<ConferenceReservation> reservation = co.admit(startrow,endrow,tab);
        
        
        model.setViewName("/Conference_Res/conferAdmit");
        model.addObject("page", page);
        model.addObject("startpage", startpage);
        model.addObject("endpage", endpage);
        model.addObject("maxpage", maxpage);
        model.addObject("tab",tab);
        model.addObject("reservation", reservation);
        return model;
    }

     /*   
    @ResponseBody
   	@RequestMapping(value="/admit_ajax")
   	public Map<String, Object> admitAjax(@RequestParam(value="page", defaultValue="1", required=false) String r_page,
   												  @RequestParam(value="tab",required=false) String tab){
    	if(tab.equals("전체")){
    		tab="";
    		} 
    	int page = 1;
    	int limit = 8;
    	int listcount = co.listcount(tab);
    	int maxpage = (listcount + limit - 1) / limit;
    	
    	if(r_page.equals("이전") && page >1){
    		page--;
    		}
    	if(r_page.equals("다음") && page+1< maxpage){
    		page++;
    		}
    	if(!r_page.equals("이전") && r_page.equals("다음")){
    		page =Integer.parseInt(r_page);
    		}
    	    	    	
        int startpage = ((page-1) /limit) *limit +1;
        int endpage = startpage +limit -1;
        int startrow = (page -1) * limit +1; 
		int endrow = startrow + limit -1;	
		if(endpage>maxpage)
            endpage=maxpage;
    	

    	List<ConferenceReservation> reservation = co.admit(startrow,endrow,tab);
     	Map<String, Object> cMap = new HashMap<String, Object>();
        
       cMap.put("reservation", reservation);
       cMap.put("page", page);
       cMap.put("startpage", startpage);
       cMap.put("endpage", endpage);
       cMap.put("maxpage", maxpage);
       cMap.put("tab",tab);
    
	        return cMap;
   	}
   */
    
    
    @ResponseBody
	@RequestMapping(value="/permit_ajax") //승인누를때 status 칼럼 update
	public String permit_Ajax(@RequestParam("rental") String rental,
												@RequestParam("start_time") String startTime,
												@RequestParam("end_time") String endTime,
												@RequestParam("id") String id,
												@RequestParam("abc") String abc
												){
		
    	ConferenceReservation c2 = new ConferenceReservation();
        c2.setSTART_TIME(startTime);
        c2.setEND_TIME(endTime);
        c2.setRENTAL(rental);
        c2.setID(id.toString());
        c2.setABC(abc);
                
        
        if(co.check_pro(c2) >0) {
        	
        	return "overlap";	
        }else {
        	
        	co.admit_pro(c2);
        	return "redirect:/confer/admit";
        } 
        	
    	
	}
    
    @ResponseBody
  	@RequestMapping(value="/reject_ajax") //거절누를때 status 칼럼 update
  	public String reject_Ajax(@RequestParam("rental") String rental,
  												@RequestParam("start_time") String startTime,
  												@RequestParam("end_time") String endTime,
  												@RequestParam("id") String id,
  												@RequestParam("reason") int reason,
  												@RequestParam("abc") String abc
  												){
    	String[] reject_reason = {"먼저 승인된 일정이 있습니다.","수리,보수등으로 인한 사용불가 상태입니다.","일정관리자에게 유선문의 부탁드립니다."};
    	
  		ConferenceReservation c2 = new ConferenceReservation();
          c2.setSTART_TIME(startTime);
          c2.setEND_TIME(endTime);
          c2.setRENTAL(rental);
          c2.setID(id.toString());
          c2.setMEMO(reject_reason[reason]);
          c2.setABC(abc.toString());
                 
          co.reject_pro(c2);
                    
          return "redirect:/confer/admit";	
      	
  	}
    
    
    
}