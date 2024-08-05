package com.itwillbs.web;

import java.security.Principal;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.service.MainService;


@Controller
@RequestMapping(value="/main/*")

public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private MainService mService;
	
	@GetMapping(value="/home")
	public void testlte(HttpServletRequest request, Principal principal) {
		if (principal != null) {
			logger.info("@@@@@@@@@@@@@@principal.getName()@@@@@@@@@@@ :"+principal.getName());
			try {
				EmployeeVO vo = mService.logInfo(principal.getName());
				HttpSession session = request.getSession();
				session.setAttribute("name", vo.getName());
				session.setAttribute("job", vo.getJob());
				session.setAttribute("user_no", vo.getUser_no());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	@GetMapping(value="/login")
	public void login() {
		
	}
	
}
