package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@GetMapping(value = "/test")
	public void testGET(Model model, EmployeeVO vo, Authentication authentication) throws Exception {
		logger.info("testGET() 실행!"); 
		
		
	}
	
	// 출근 메소드
	@ResponseBody
	@RequestMapping(value="/workStart", method = {RequestMethod.POST})
	public int commuteStart(@RequestParam("user_id") String user_id,HttpServletRequest request) {

		logger.info("@@@@@@@@@@@@@@user_id@@@@@@@@@@@ :"+user_id);
		// user_id로 user_no 구하기
		int user_no = 0;
		try {
			user_no = eService.user_no(user_id);
			logger.info("@@@@@@@@@@@@@@user_no@@@@@@@@@@@ :"+user_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			eService.workStart(user_no);
			logger.info("@@@@@@@@@@@@@@출근성공@@@@@@@@@@@ :");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 1;
	}
	
	// 출근했는지 확인하는 메소드
		@ResponseBody
		@RequestMapping(value="/", method = RequestMethod.GET)
		public void checkCommute(HttpServletRequest request) {
			// 리턴 string
			boolean isExist = false;
			
			//JSONObject jsonObj = new JSONObject();
			
			String user_id = request.getParameter("user_id");
			//user id로 user_no 구하기
			
			//EmpAttendanceVO evo = service.checkCommute(user_no);
			
//			if(evo != null) {
//				isExist = true;
//				
//				jsonObj.put("commuteno", evo.getCommuteno());
//				jsonObj.put("user_no", evo.getUserno());
//				jsonObj.put("start_work_time", evo.getStart_work_time());
//				jsonObj.put("end_work_time", evo.getEnd_work_time());
//				jsonObj.put("overtime", evo.getOvertime());
//				jsonObj.put("worktime", commutevo.getWorktime());
//			}
			
			//jsonObj.put("isExist", isExist);
			
			
			//return jsonObj.toString();
		}

}
