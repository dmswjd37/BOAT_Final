package com.boat.aop;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


@Component
public class LogAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(LogAdvice.class);
	
	public void beforeLog() {
		logger.info("[LogAdvice : 공통메서드 입니다.]");
	}
	
	

}
