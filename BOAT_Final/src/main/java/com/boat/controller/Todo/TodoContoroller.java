package com.boat.controller.Todo;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boat.Service.Todo.TodoService;
import com.boat.domain.Member2;
import com.boat.domain.Todo;

@Controller
@RequestMapping(value="/Todo")//http://localhost:8088/myhome4/board/로 시작하는 주소 매핑
public class TodoContoroller {

	private static final Logger logger =
			  LoggerFactory.getLogger(TodoContoroller.class);

	
	private TodoService todoService;
	
	public TodoContoroller(TodoService todoService) {
		this.todoService = todoService;
	}
	
	@ResponseBody
	@RequestMapping(value="/getTodo")
	public Todo getTodo(@RequestParam(value="num",required=false)int num) {
		return todoService.getTodo(num);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/delete")
	public int delete(@RequestParam(value="num",required=false)int num) {
		return todoService.tododelete(num);
		
	}
	@ResponseBody
	@RequestMapping(value="/done")
	public int done(@RequestParam(value="num",required=false)int num) {
		return todoService.todoDone(num);
		
	}
	@PostMapping(value="/updateTodo")
	public String done(Todo todo) {
		todoService.updateTodo(todo);
		
		return "redirect:list";
		
	}
	
	
	
	
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public ModelAndView Todomain(Principal principal,
							ModelAndView mv) {
		String empno = principal.getName();
		//String empno = "2310001";
		
		String dept = todoService.getDept(empno);
		logger.info("로그인한 empno : "+empno);
		logger.info("로그인한 dept : "+dept);
		Todo todo = new Todo();
		
		//select * from todolist where empno= '로그인한사람;
		List<Todo> Mytodolist = todoService.mytodolist(empno);
		int mytotolistcount = Mytodolist.size();
		
		int done = 0;
		for(Todo a:Mytodolist) {
			if(a.getState()==1) {
				done++;
			}
		}
		System.out.println(done+"done,,,,,,,,,,,,,,,,,");
		System.out.println(mytotolistcount+"mytotolistcount,,,,,,,,,,,,,,,,,");

		float doneper =(float)done/mytotolistcount*100;
		int mydoneper = Math.round(doneper);
		System.out.println(doneper+"doneper,,,,,,,,,,,,,,,,,");
		System.out.println(mydoneper+"mydoneper,,,,,,,,,,,,,,,,,");
		
		
		logger.info("todo :	"+ Mytodolist );
		
		
		//select * from TODOLIST where dept = #{dept}
		// order by empno
		
		
		List<Member2> mydeptTodolist = todoService.deptList(dept,empno);
		
		int number =mydeptTodolist.size();
		System.out.println(number+"numberddddddddddddddddd");
		
		for(Member2 a :mydeptTodolist) {
			int deptdone = 0;
			for(Todo b :a.getTodo()) {
				if(b.getState()==1)
				deptdone++;
				System.out.println(deptdone+"확인");
			}
			int deptall = a.getTodo().size();
			float ck = (float)deptdone/deptall*100;
			int result = Math.round(ck);
			a.setCount(result);
		}

		
		
		
		
		mv.setViewName("Todo/Todonew");
		
		//Mytodolist
		mv.addObject("MyTodo",Mytodolist);
		//mydoneper
		mv.addObject("mydoneper",mydoneper);
		//deptList
		mv.addObject("MydeptList",mydeptTodolist);
		
		mv.addObject("mytotolistcount",mytotolistcount);
		
	return mv;

	}
	
	@PostMapping(value="/add") 
	  public String add( Todo todo,
			  HttpServletRequest request) throws Exception {
				
		
		
		todoService.insertTodo(todo);
		
		//저장 성공하면 Todo/list
		  return  "redirect:list"; 
		
	}
	
	@GetMapping(value="/update")
	public Todo todoupdate(String num,String T_CONTENT,String END_DATE) {
		todoService.Todoupdate(num,T_CONTENT,END_DATE);
		
		
		return null;
		
	}
	
}//클래스 end
