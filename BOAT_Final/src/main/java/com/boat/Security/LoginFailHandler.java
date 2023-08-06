package com.boat.Security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;


//AuthenticationFailureHandler : 로그인 실패 후 처리할 작업을 해야할 때 사용하는 인터페이스입니다.
//@Service
public class LoginFailHandler implements AuthenticationFailureHandler {
	private static final Logger Logger = LoggerFactory.getLogger(LoginFailHandler.class);
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		Logger.info(exception.getMessage());
		Logger.info("로그인 실패");
		session.setAttribute("loginfail", "loginFailMsg");
		String url = request.getContextPath() + "/member/sign_in";
		response.sendRedirect(url);
	}

}
