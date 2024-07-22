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

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.EmployeeService;

@Controller
@RequestMapping(value = "/employee/*")
public class EmployeeController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
	
	@Inject
	private EmployeeService eService;
	
    @Autowired
    private CommonCodeService commonCodeService;
	
	// http://localhost:8088/employee/empList
	@GetMapping(value = "/empList")
	public void empListGET(Model model, EmployeeVO vo) throws Exception {
		logger.info("empListGET() 실행!"); 
		
		List<EmployeeVO> empList = eService.empList();
		model.addAttribute("empList", empList);
		model.addAttribute("job", commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
		logger.info("job : "+commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
	    model.addAttribute("job_rank", commonCodeService.getCommonCodeDetailsByCodeId("JOB_RANK"));
		
		logger.info("@@@@@@@@@@@@@@vo@@@@@@@@@@@ :"+vo);
	}
	
	@ResponseBody
	@PostMapping(value = "/empList")
	public String empListPOST(EmployeeVO vo, AuthVO avo) throws Exception {
		logger.info("모달창으로 직원 등록(컨트롤러)");
		
		logger.info("vo :"+vo);
		// user_pw 암호화
//		String encPW = pwEncoder.encode(vo.getUser_pw());
//		vo.setUser_pw(encPW);
		//DAO에 동작 호출
		eService.empJoin(vo);
		// 직원 권한부여
		avo.setUser_id(vo.getUser_id());
		if(vo.getJob_rank().equals("관리자")) {
			avo.setAuth("ROLE_ADMIN");
		}else if(vo.getJob_rank().equals("팀장")) {
			avo.setAuth("ROLE_MANAGER");			
		}else if(vo.getJob_rank().equals("사원")) {
			avo.setAuth("ROLE_MEMBER");						
		}
		eService.empAuth(avo);
		
		return "/employee/empList";
	}

	//아이디 중복 체크
	//ajax로 처리할때는 @ResponseBody를 써야 응답이 가능.
	@GetMapping(value = "/idcheck")
	public @ResponseBody int idCheck(@RequestParam("user_id") String id) throws Exception {
	
		logger.debug("id :"+id);
	
		int res = eService.idCheck(id);
		
		return res;
		
	}

}
