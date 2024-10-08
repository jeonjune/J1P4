package com.itwillbs.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		logger.info(" @@@@@@@@@@@@@@@@@ 로그인 실패! ");
		response.sendRedirect("/main/login?error=true");
		
	}
	
	


	
}
