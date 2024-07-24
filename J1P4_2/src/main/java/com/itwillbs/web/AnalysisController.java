package com.itwillbs.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.service.AnalysisService;

@Controller
@RequestMapping(value = "/analysis/*")
public class AnalysisController {

	private static final Logger logger = LoggerFactory.getLogger(AnalysisController.class);
	
	@Inject
	private AnalysisService anService;
	
	@RequestMapping(value = "/totalMemAnalysis",method = RequestMethod.GET)
	public void totalMemAnalysisGET(Model model) throws Exception{
		logger.info("totalMemAnalysisGET() 실행");
		int tmc = anService.totalMemCount();
		int nmc = anService.newMemCount();
		int rmc = anService.regMemCount();
		double rmcTmc = anService.rmcTmc();
		
		model.addAttribute("tmc", tmc);		
		model.addAttribute("nmc", nmc);		
		model.addAttribute("rmc", rmc);		
		model.addAttribute("rmcTmc", rmcTmc);		
	}
	
	@RequestMapping(value = "/writeReport",method = RequestMethod.GET)
	public void writeReportGET() throws Exception{
		logger.info("writeReportGET() 실행");
	}
}
