package com.boat.Service.Todo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.boat.aop.LogAdvice;
import com.boat.domain.Member2;
import com.boat.domain.Todo;
import com.boat.mybatis.mapper.TodoMapper;

@Service
public class TodoServiceImpl implements TodoService {
	
	private TodoMapper dao;
	private LogAdvice log;
	
	public TodoServiceImpl(TodoMapper dao) {
		this.dao=dao;
	}
	
	@Override
	public void insertTodo(Todo todo) {
		
		dao.Todoinsert(todo);
		
	}

	//내할일보기 할일목록
	@Override
	public List<Todo> mytodolist(String empno) {
		//log.info(todo.toString());
		return dao.myTodolist(empno);
		
	}

	//dept가져오기
	@Override
	public String getDept(String empno) {

		return dao.getDept(empno);
	}

	//내 팀원 리스트 가져오기
	@Override
	public List<Member2> deptList(String dept,String empno ) {
		Map<String,String> map=	new HashMap<String,String>();
		map.put("DEPT", dept);
		map.put("EMPNO", empno);
		
		return dao.myDeptTodo(map);
		
	}

	@Override
	public void Todoupdate(String num, String t_CONTENT, String eND_DATE) {
		Map<String,Object> map=	new HashMap<String,Object>();
		map.put("T_CONTENT", t_CONTENT);
		map.put("END_DATE", eND_DATE);
		map.put("NUM", num);
		dao.myTodoupdate(map);
	}

	@Override
	public Todo getTodo(int num) {
		return 	dao.getTodo(num);
	}

	@Override
	public int todoDone(int num) {
		
		
		return dao.todoDone(num);
	}
	
	@Override
	public int updateTodo(Todo todo) {
		return dao.updateTodo(todo);
	}

	@Override
	public int tododelete(int num) {
		return 	dao.DeleteTodo(num);
	}
	
	


	

}
