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
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.service.EmployeeService;

@Controller
@RequestMapping(value = "/employee/*")
public class EmployeeController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
	
	@Inject
	private EmployeeService eService;
	
//	@Inject
//	private PasswordEncoder pwEncoder;
	
	// http://localhost:8088/employee/empList
	@GetMapping(value = "/empList")
	public void empListGET(Model model, EmployeeVO vo) throws Exception {
		logger.info("empListGET() 실행!"); 
		
		List<EmployeeVO> empList = eService.empList();
		model.addAttribute("empList", empList);
		
		logger.info("@@@@@@@@@@@@@@vo@@@@@@@@@@@ :"+vo);
	}
	
//	@ResponseBody
//	@PostMapping(value = "/empList")
//	public String empListPOST(EmployeeVO vo) throws Exception {
//		logger.info("모달창으로 직원 등록(컨트롤러)");
//		
//		logger.info("vo :"+vo);
//		// user_pw 암호화
//		String encPW = pwEncoder.encode(vo.getUser_pw());
//		vo.setUser_pw(encPW);
//		//DAO에 동작 호출
//		eService.empJoin(vo);
//		
//		return "/employee/empList";
//	}
	
	@ResponseBody
	@PostMapping(value = "/emp")
	public String empList2POST(EmployeeVO vo) throws Exception {
		logger.info("모달창으로 직원 등록(컨트롤러)");
		
		logger.info("vo :"+vo);
		//DAO에 동작 호출
		//fService.facInsert(vo);
		
		
		return "/employee/empList";
	}
	

}
