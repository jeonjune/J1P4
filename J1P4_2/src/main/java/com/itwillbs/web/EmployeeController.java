package com.itwillbs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/employee/*")
public class EmployeeController {
	
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@GetMapping(value = "/empList")
	public void empListGET() {
		logger.info("empListGET() 실행!"); 
	}
	

}
