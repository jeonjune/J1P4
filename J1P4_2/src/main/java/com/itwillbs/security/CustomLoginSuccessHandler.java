package com.itwillbs.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		logger.info(" onAuthenticationSuccess() 실행 - 로그인 성공! ");
		
		// 로그인한 사용자의 인증정보 확인
		// 사용자의 권한 정보를 저장하는 리스트
		List<String> roleNames = new ArrayList<String>();
		

		authentication.getAuthorities().forEach(
				authority -> roleNames.add(authority.getAuthority())
				);
		
		logger.info(" 사용자 권한 정보 : "+roleNames);
		
		// 사용자 권한에 따른 페이지 이동
		
		// 관리자 - ROLE_ADMIN
		if(roleNames.contains("ROLE_ADMIN")) {
			logger.info(" ROLE_ADMIN 권한 -> main 페이지로 이동 ");
			response.sendRedirect("/main/home");
			return;
		}
		
		// 사용자 - ROLE_MEMBER
		if(roleNames.contains("ROLE_MEMBER")) {
			logger.info(" ROLE_MEMBER 권한 -> main 페이지로 이동 ");
			response.sendRedirect("/main/home");
			return;
		}
		
		
		// 전체   - ALL
		response.sendRedirect("/main/home");
		
	}

	
}
