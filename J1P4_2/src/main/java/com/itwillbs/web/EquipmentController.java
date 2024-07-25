package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.EquipManageService;

@Controller
@RequestMapping(value = "/maintenance/*")
public class EquipmentController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	@Inject
	private EquipManageService eService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	
	//장비내역 페이지
	//http://localhost:8088/maintenance/equipment
	@GetMapping(value = "/equipment")
	public void equipmentGET() {
			
	}
		

	
	
	//장비신청내역 페이지
	//http://localhost:8088/maintenance/list
	@GetMapping(value = "/list")
	public String listGET(Model model) throws Exception {
		List<EquipManageVO> list = eService.equipList();
		
		model.addAttribute("list",list);
		  //logger.info("list :"+ list);

		return "/maintenance/list";
		
	}
	
	
	//장비신청 (글쓰기)
	//http://localhost:8088/maintenance/regist
	@GetMapping(value = "/regist")
	public void registGET(Model model, EquipManageVO vo) {
		vo.setField("분야");
	    model.addAttribute("EquipManageVO", vo);
        model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        logger.info("job : "+commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        logger.info("@@@@@@@vo@@@@ :"+ vo);
		
	}
	
	@ResponseBody
	@PostMapping(value = "/regist")
	public String registPOST(EquipManageVO vo) throws Exception {
		logger.info("22222222 vo 2222222222222 :"+ vo);
		vo.setManager_no(12); //로그인 기능 들고올때까지 임시로 설정(user_no) 나중에 세션에 담아서 사용
		
		eService.equipAdd(vo);
		
		//logger.info();
		
		return"/maintenance/list";
		
	}
	
	
	
	//반려내역
	//http://localhost:8088/maintenance/reject
	@GetMapping(value = "/reject")
	public void rejectGET() {
				
	}
	
	//장비신청 상세페이지
	//http://localhost:8088/maintenance/detail
	@GetMapping(value = "/detail")
	public void detailGET(Model model, @RequestParam("equipment_no") int eno) throws Exception {
		//전달정보 저장 
		logger.info("####eno##### :"+ eno);
		
		//DAO 저장된 정보 가져오기
		EquipManageVO resultVO = eService.equipDetail(eno);
		logger.info("resultVO :"+ resultVO);
		
		//전달할 정보 저장
		model.addAttribute("resultVO", resultVO);
		
	}
	
	
	
	
	
	
	
	
	
}
