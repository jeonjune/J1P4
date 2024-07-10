package com.itwillbs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
//@Log4j
public class CommonController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	// 접근권한이 없는 페이지 접근 시 처리
	@RequestMapping(value="/accessErr", method = RequestMethod.GET)
	public void accessDenied(Authentication auth, Model model) {
		logger.info(" accessDenied() 실행 - 접근권한이 없는 사용자의 접근 ");
		
		logger.info("auth : "+auth);
		model.addAttribute("auth",auth);
		logger.info(" accessErr.jsp 뷰페이지로 이동 ");
	}
	
	// 커스텀 로그인 페이지
	@GetMapping(value="/customLogin")
	public void customLogin() {
		logger.info("customLogin() 실행! ");
		
	}
	
	// 커스텀 로그아웃 페이지
	@GetMapping(value="/customLogout")
	public void customLogout() {
		logger.info(" customLogout() 실행! ");
	}
}
