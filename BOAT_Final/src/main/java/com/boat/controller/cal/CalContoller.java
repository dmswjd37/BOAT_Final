package com.boat.controller.cal;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boat.Service.Calendar.CalendarService;
import com.boat.domain.Calendar;

@Controller
@RequestMapping(value = "/cal")
public class CalContoller {
	
	private static final Logger logger = LoggerFactory.getLogger(CalContoller.class);
	
	private CalendarService calendarService;
	
	public CalContoller(CalendarService calendarService) {
		this.calendarService = calendarService;
	}
	
	
	@ResponseBody
	@PostMapping("/delete")
	public int deleteCal(@RequestParam String EMPNO,	
			@RequestParam String  EVENT_NAME) {
		logger.info("delete empno ///"+EMPNO);
		logger.info("delete EVENT_NAME ///"+EVENT_NAME);
		int result = calendarService.checkevent(EMPNO,EVENT_NAME);
			
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public Map<String,Object> CalAdd(
			Calendar cal,
			HttpServletRequest request) throws Exception{
		
		logger.info("...."+cal.toString());
		calendarService.insertcal(cal);
		//이하 사실상 필요없는코드...(새로고침으로 해결)
		Map<String,Object> map =new  HashMap<String,Object>();
		
		map.put("title", cal.getEVENT_NAME());
		map.put("start", cal.getSTART_DATE());
		map.put("end", cal.getEND_DATE());
		map.put("title", cal.getEVENT_NAME());
		map.put("color",cal.getCOLOR());
		map.put("allDay", cal.getALLDAY());
		return map;
		
		
	}
	
	@RequestMapping("/getEvents")
	    @ResponseBody
	    public  List<Map <String,Object>> getEvents(
	    		@RequestParam(value = "DEPT", required = false)String DEPT) throws ParseException {
		 
	        
		  List<Calendar> events;
	        if (DEPT != null && !DEPT.isEmpty()) {
	            events = calendarService.getEventsByDept(DEPT);
	        } else {
	            events = calendarService.getAllEvents();
	        }
	        List<Map <String,Object>> result = new ArrayList<Map <String,Object>>();
	        int a=1;
	        int b = 0;
	        for(Calendar cal: events) {
	        	Map <String,Object> event = new HashMap<String,Object>();
	        	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mmz");++
	    	    if(cal.getALLDAY().equals("false")) {
	    	    	a = 0;
	    	    	event.put("end", cal.getEND_DATE());
	    	    	b++;
	    	    	logger.info(b+"번째 이벤트"+a);
	    	    	}else {
	    	    		a=1;    	    		
	    	    	}
	    	    
	        	 event.put("id",cal.getSCHEDULE_CODE());
	             event.put("start", cal.getSTART_DATE());
	             event.put("title", cal.getEVENT_NAME());
	             event.put("color",cal.getCOLOR());
	             event.put("allDay",a);
	             
	             event.put("DEPT", cal.getDEPT());
	             result.add(event);
	        }
	        logger.info("얍"+result.toString());
	        return result;
		 
	    }
		
	
	@RequestMapping(value="/map",method=RequestMethod.GET)
	public String mapPage() {
		
		
	return "Calendar/map";
	}

	
	@RequestMapping(value="/cal",method=RequestMethod.GET)
	public String fullcalPage() {
		
		
		return "Calendar/fullcalendar";
	}
}//클래스 end
