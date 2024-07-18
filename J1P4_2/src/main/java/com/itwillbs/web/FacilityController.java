package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.FacilityManagementVO;
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
	
	
	//시설리스트 등록(모달창에 입력)
	@ResponseBody
	@PostMapping(value = "/facility")
	public String facInsertPOST(FacilityVO vo) throws Exception {
		logger.info("모달창에 시설 등록 - 입력된 데이터 처리");
		
		logger.info("vo :"+vo);
		//DAO에 동작 호출
		fService.facInsert(vo);
		
		
		return "maintenance/facility";
	}
	
	
	//시설상세페이지 리스트
	@GetMapping(value = "/read")
	public void facReadListGET(HttpServletRequest request,Model model)throws Exception {
		logger.info("facReadListGET() 실행 :");
		int no = (Integer.parseInt(request.getParameter("facility_no")));
		logger.info("no :"+no);
		List<FacilityManagementVO> facDe = fService.facDe(no);
		logger.info("facDe :"+facDe);
		
		model.addAttribute("facDe",facDe);
		
	}
	
	
	//시설상세내역페이지 등록(모달창)
	@ResponseBody
	@PostMapping(value = "/read")
	public String facReadListPOST(FacilityManagementVO vo, HttpServletRequest request)throws Exception {
		logger.info("모달창에 시설상세내역 등록 - 입력된 데이터 처리");
		
		fService.facDeIn(vo);
		logger.info("#########vo########## :"+vo);
		
		return "maintenance/read";
		
	}
	
	
	
	
	
	
	
	
	
}
