package com.itwillbs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/maintenance/*")
public class Equipment {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	//장비내역 페이지
	//http://localhost:8088/maintenance/equipment
	@GetMapping(value = "/equipment")
	public void equipmentGET() {
		
	}
	
	//장비신청내역 페이지
	//http://localhost:8088/maintenance/request
	@GetMapping(value = "/request")
	public void registGET() {
		
	}
	
	//반려내역 페이지
	//http://localhost:8088/maintenance/reject
	@GetMapping(value = "/reject")
	public void rejectGET() {
		
	}
	
	
	
}
