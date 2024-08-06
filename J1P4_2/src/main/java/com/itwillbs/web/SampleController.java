package com.itwillbs.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SampleController {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleController.class);
	
	@RequestMapping(value="/all",method = RequestMethod.GET)
	public void doAll() throws Exception {
		logger.debug(" doAll() 실행");
	}
	
	@RequestMapping(value="/member",method = RequestMethod.GET)
	public void doMember() throws Exception {
		logger.debug(" doMember() 실행");
	}
	
	@RequestMapping(value="/admin",method = RequestMethod.GET)
	public void doAdmin() throws Exception {
		logger.debug(" doAdmin() 실행");
	}
	
}
