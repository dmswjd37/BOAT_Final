package com.boat.Security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.boat.domain.Attandance;
import com.boat.domain.Member;
import com.boat.mybatis.mapper.AttandanceMapper;
import com.boat.mybatis.mapper.MemberMapper;

//AuthenticationSuccessHandler : 사용자 인증이 성공 후 처리할 작업을 직접 작성할 때 사용하는 인터페이스입니다.
//@Service
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	private static final Logger Logger = LoggerFactory.getLogger(LoginSuccessHandler.class);
	
	@Autowired
	private MemberMapper dao;

	@Autowired
	private AttandanceMapper attdao;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String EMPNO = request.getParameter("id");
		
		HttpSession session = request.getSession();
		
		Attandance attendance = attdao.getTodayMyatt(EMPNO);
		if(attendance != null) {
			String attoff=attendance.getOFF_TIME();
			if(attoff==null)
			session.setAttribute("TodayOntime",attendance.getON_TIME());
			//출근안한사람은 로그인안됨 
		}
		Member member = dao.isId(EMPNO);
		session.setAttribute("EMPNO", EMPNO);
		session.setAttribute("NAME", member.getNAME());
		session.setAttribute("DEPT", member.getDEPT());
		session.setAttribute("JOB", member.getJOB());
		session.setAttribute("PROFILE_FILE", member.getPROFILE_FILE());
		session.setAttribute("AUTH", member.getAUTH());
		
		session.setAttribute("loginUser", member);
		
		Logger.info("로그인 성공 : LoginSuccessHandler"); 
		String url = request.getContextPath() + "/index";
		response.sendRedirect(url);
	}

}
