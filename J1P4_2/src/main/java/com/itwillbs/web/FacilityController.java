package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.FacilityVO;
import com.itwillbs.service.FacilityService;

@Controller
@RequestMapping(value="/maintenance/*")
public class FacilityController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@Inject
	private FacilityService fService;
	
	
	//시설리스트
	//http://localhost:8088/maintenance/facility
	@GetMapping(value = "/facility")
	public void facilityGET(Model model,FacilityVO vo) throws Exception {
		logger.info("facilityGET() 실행 :");
		
		List<FacilityVO> facList = fService.facList();
		model.addAttribute("facList", facList);
		
		logger.info("@@@@@@@@@@@@@@vo@@@@@@@@@@@ :"+vo);
		
	}
	
	
	//시설리스트 등록
	//http://localhost:8088/maintenance/facilityModal
	@GetMapping(value = "/facilityModal")
	public void facInsertGET() throws Exception {
		logger.info("시설등록하는 모달창으로 이동");
	}
	
	@PostMapping(value = "/facilityModal")
	public String facInsertPOST(FacilityVO vo) throws Exception {
		logger.info("모달창에 시설 등록 - 입력된 데이터 처리");
		
		logger.info("vo :"+vo);
		//DAO에 동작 호출
		fService.facInsert(vo);
		
		return"maintenance/facility";
	}
	
	
	
	
	
	
	
	
}
