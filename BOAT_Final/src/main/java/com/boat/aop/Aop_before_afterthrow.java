package com.boat.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service
@Aspect
public class Aop_before_afterthrow {

	
	private static final Logger logger = LoggerFactory.getLogger(Aop_before_afterthrow.class);
	@AfterThrowing(
			pointcut="execution(* com.boat..*Impl.get*(..))",
							throwing="exp")
	public void afterThrowingLog(Throwable exp) {
		logger.info("=============================================================");
		logger.info("[AfterThrowing] obj : 비지니스 로직 수행 중 오류가 발생하면 동작입니다.");
		logger.info("ex : "+exp.toString());
		logger.info("=============================================================");
		
	}


	@Before("execution(* com.boat..*Impl.get*(..))")
	public void beforeLog(JoinPoint proceeding) {
		logger.info("=============================================================");
		logger.info("[BeforeAdvice] : 비즈니스 로직 수행 전 동작입니다.");
		logger.info("[BeforeAdvice] :"
				+proceeding.getTarget().getClass().getName()
				+"의 "+proceeding.getSignature().getName() + "()호출합니다.");
		logger.info("=============================================================");
		
	}
}
