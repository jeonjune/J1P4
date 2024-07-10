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
		
		// 익명 클래스를 블럭 잡아서 ctrl + 1 사용하여 람다 표현식 <-> 익명클래스(함수)
//		authentication.getAuthorities().forEach(new Consumer<GrantedAuthority>() {
//			@Override
//			public void accept(GrantedAuthority authority) {
//				roleNames.add(authority.getAuthority());
//			}
//		});
		
		authentication.getAuthorities().forEach(
				authority -> roleNames.add(authority.getAuthority())
				);
		
		logger.info(" 사용자 권한 정보 : "+roleNames);
		
		// 사용자 권한에 따른 페이지 이동
		
		// 관리자 - ROLE_ADMIN
		if(roleNames.contains("ROLE_ADMIN")) {
			logger.info(" ROLE_ADMIN 권한 -> admin 페이지로 이동 ");
			response.sendRedirect("/admin");
			return;
		}
		
		// 사용자 - ROLE_MEMBER
		if(roleNames.contains("ROLE_MEMBER")) {
			logger.info(" ROLE_MEMBER 권한 -> member 페이지로 이동 ");
			response.sendRedirect("/member");
			return;
		}
		
		
		// 전체   - ALL
		response.sendRedirect("/all");
		
	}

	
}
