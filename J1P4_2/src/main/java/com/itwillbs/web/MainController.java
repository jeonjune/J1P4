package com.itwillbs.web;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.fileVO;
import com.itwillbs.service.AnalysisService;
import com.itwillbs.service.MainService;


@Controller
@RequestMapping(value="/main/*")

public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private MainService mService;
	
	@Inject
	private AnalysisService anService;
	
	@GetMapping(value="/home")
	public void testlte(HttpServletRequest request, Principal principal, Model model) throws Exception {
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
				logger.info("@@@@@@@@@@@@@@user_no@@@@@@@@@@@ :"+session.getAttribute("sess_user_no"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		logger.info("totalMemAnalysisGET() 실행");
		int tmc = anService.totalMemCount();
		int nmc = anService.newMemCount();
		int rmc = anService.regMemCount();
		double rmcTmc = anService.rmcTmc();
		
		List<Map<String, Integer>> new6MemCount = anService.new6MemCount();
		
		// ObjectMapper를 사용하여 new6MemCount List를 JSON 문자열으로 변환
        ObjectMapper mapper = new ObjectMapper();
        String new6MemCountJson = "";
        try {
        	new6MemCountJson = mapper.writeValueAsString(new6MemCount);
        } catch (Exception e) {
            logger.error("new6MemCount을 JSON으로 변환하는데 실패하였습니다.", e);
        }
        
		model.addAttribute("tmc", tmc);		
		model.addAttribute("nmc", nmc);		
		model.addAttribute("rmc", rmc);		
		model.addAttribute("rmcTmc", rmcTmc);
		model.addAttribute("new6MemCount", new6MemCountJson);
		
	}
	
	@GetMapping(value="/login")
	public void login() {
		
	}
	
	
}
