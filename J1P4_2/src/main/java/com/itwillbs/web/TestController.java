package com.itwillbs.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.TestVO;
import com.itwillbs.service.TestService;

@Controller
@RequestMapping(value="/test/*")

public class TestController {
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@Inject
	private TestService tService;
	
	@GetMapping(value="/test")
	public void test() {
		
	}
	
	@PostMapping(value="/test")
	public String testPOST(TestVO vo) {
		logger.info("@@@@@@@@@@@@@@@@@@@@"+vo);
		tService.test(vo);
		return "redirect:/success";
	}
}
