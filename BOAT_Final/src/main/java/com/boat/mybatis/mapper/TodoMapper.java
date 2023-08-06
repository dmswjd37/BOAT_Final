package com.boat.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.boat.domain.Member2;
import com.boat.domain.Todo;

@Mapper
public interface TodoMapper {

	void Todoinsert(Todo todo);

	List<Todo> myTodolist(String empno);

	String getDept(String empno);

	List<Member2> myDeptTodo(Map<String, String> map);

	void myTodoupdate(Map<String, Object> map);
	
	Todo getTodo(int num);
	
	int todoDone(int num);

	int updateTodo(Todo todo);

	int DeleteTodo(int num);

}
