package com.itwillbs.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
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
	
	@RequestMapping(value = "/writeReport",method = RequestMethod.GET)
	public void writeReportGET() throws Exception{
		logger.info("writeReportGET() 실행");
	}
}
