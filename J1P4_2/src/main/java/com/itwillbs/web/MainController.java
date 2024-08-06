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
import com.itwillbs.domain.fileVO;
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
				HttpSession session = request.getSession();
				EmployeeVO vo = mService.logInfo(principal.getName());
				fileVO fvo = mService.logPic(principal.getName());
				
				session.setAttribute("sess_pic", fvo.getFile_name());
				session.setAttribute("sess_name", vo.getName());
				session.setAttribute("sess_job", vo.getJob());
				session.setAttribute("sess_user_no", vo.getUser_no());
				session.setAttribute("sess_rank", vo.getJob_rank());
				logger.info("@@@@@@@@@@@@@@file_name@@@@@@@@@@@ :"+session.getAttribute("sess_pic"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	@GetMapping(value="/login")
	public void login() {
		
	}
	
}
