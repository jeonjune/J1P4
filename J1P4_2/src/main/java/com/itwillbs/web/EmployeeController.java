package com.itwillbs.web;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.fileVO;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.EmpAttendanceService;
import com.itwillbs.service.EmployeeService;
import com.itwillbs.service.FileUploadService;
import com.itwillbs.service.SearchService;

@Controller
@RequestMapping(value = "/employee/*")
public class EmployeeController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
	private final String FAKE_PATH = "/upload";
	
	@Inject
	private EmployeeService eService;
	
    @Autowired
    private CommonCodeService commonCodeService;
    
    @Inject
    private EmpAttendanceService vaService;
    
    @Inject
	private SearchService sService;
    
    @Inject
    private FileUploadService fService;
	
	// http://localhost:8088/employee/empList
    @GetMapping(value = "/empList")
	public void empListGET(Model model, EmployeeVO vo, Principal principal, Criteria cri) throws Exception {
		logger.info("empListGET() 실행!"); 
		if (principal != null) {
			logger.info("@@@@@@@@@@@@@@principal.getName()@@@@@@@@@@@ :"+principal.getName());
			int user_no = eService.user_no(principal.getName());
			String checkW = eService.checkWork(user_no);
			model.addAttribute("checkW", checkW);
			logger.info("@@@@@@@@@@@@@@checkW@@@@@@@@@@@ :"+checkW);
		}
		
		if(cri.getKeyword() != null) {
			
			List<EmployeeVO> empList = sService.searchEmp(cri);
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getEmpCount(cri));
			logger.debug(" @@@@@@@@@@@@@@@@@ 글 개수 : "+sService.getTotalCount(cri));
			// 연결된 뷰페이지로 정보 전달
			EmployeeVO employee = new EmployeeVO(); // 폼 객체
			model.addAttribute("employee", employee);
			model.addAttribute("empList", empList);
			model.addAttribute("pageVO",pageVO);
			
			model.addAttribute("job", commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
			logger.info("job : "+commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
			model.addAttribute("job_rank", commonCodeService.getCommonCodeDetailsByCodeId("JOB_RANK"));
			
			return;
		}
		
		List<EmployeeVO> empList = eService.empList(cri);
		model.addAttribute("empList", empList);
		EmployeeVO employee = new EmployeeVO(); // 폼 객체
        model.addAttribute("employee", employee);

		model.addAttribute("job", commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
		logger.info("job : "+commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
	    model.addAttribute("job_rank", commonCodeService.getCommonCodeDetailsByCodeId("JOB_RANK"));
	    
		logger.info("@@@@@@@@@@@@@@vo@@@@@@@@@@@ :"+vo);
		
		// 하단 페이징처리 정보
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(sService.getEmpCount(cri));
		logger.debug(" @@@@@@@@@@@@@@@@@ 글 개수 : "+sService.getTotalCount(cri));
		model.addAttribute("pageVO",pageVO);
	}
	
	@ResponseBody
	@PostMapping(value = "/empList")
	public String empListPOST(EmployeeVO vo, AuthVO avo,MultipartHttpServletRequest multiRequest,fileVO fvo) throws Exception {
		logger.info("모달창으로 직원 등록(컨트롤러)");
		
		logger.info("vo :"+vo);
		if(vo.getJob().equals("관리자")) {
			vo.setJob_rank("관리자");
		}

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
		
		// 파일업로드
		multiRequest.setCharacterEncoding("UTF-8");
        Map<String, String> paramMap = new HashMap();
        Enumeration<String> enu = multiRequest.getParameterNames();
        
        while (enu.hasMoreElements()) {
            String name = enu.nextElement();
            String value = multiRequest.getParameter(name);
            paramMap.put(name, value);
        }
        
        logger.debug("paramMap :{} ", paramMap);

        List<String> fileNameList = fileProcess(multiRequest);
        paramMap.put("fileNameList", String.join(",", fileNameList));
        logger.debug("paramMap :{} ", paramMap);
        
        logger.debug("@@@@@@ 난 이제 지쳤어요 땡벌땡벌 "+ paramMap.get("fileNameList"));
        fvo.setFile_name(paramMap.get("fileNameList"));
        logger.debug("@@@@@@ 난 이제 지쳤어요 땡벌땡벌 "+ fvo.getFile_name());
        
        eService.empAuth(avo);
        if(fvo.getFile_name().equals(null)) {
        	fService.fileEmpAdd(fvo);        	
        }
		
		// insert로 회원 등록 실행 (return 값 없음)
	
		
		return "/employee/empList";
	}

//파일업로드 메서드
public List<String> fileProcess(MultipartHttpServletRequest multiRequest) throws Exception {
    logger.debug("fileProcess : 파일 업로드 처리 시작!");

    List<String> fileNameList = new ArrayList();
    Iterator<String> fileNames = multiRequest.getFileNames();
    while (fileNames.hasNext()) {
        String fileName = fileNames.next();
        MultipartFile mFile = multiRequest.getFile(fileName);
        String oFileName = mFile.getOriginalFilename();
        fileNameList.add(oFileName);

        File file = new File(multiRequest.getRealPath(FAKE_PATH) + "\\" + oFileName);
        if (mFile.getSize() != 0) {
            if (!file.exists()) {
                if (file.getParentFile().mkdirs()) {
                    file.createNewFile();
                }
            }
            mFile.transferTo(file);
        }
    }
    logger.debug("fileNameList : {}", fileNameList);
    logger.debug("파일 업로드 완료!!, 파일 이름 저장 완료!");

    return fileNameList;
}

	//아이디 중복 체크
	//ajax로 처리할때는 @ResponseBody를 써야 응답이 가능.
	@GetMapping(value = "/idcheck")
	public @ResponseBody int idCheck(@RequestParam("user_id") String id) throws Exception {
	
		logger.debug("id :"+id);
	
		int res = eService.idCheck(id);
		
		return res;
		
	}

//	@GetMapping(value = "/test")
//	public void testGET(Model model, EmployeeVO vo, Authentication authentication) throws Exception {
//		logger.info("testGET() 실행!"); 
//		
//		
//	}
	
	// 출근 메소드
	@ResponseBody
	@RequestMapping(value="/workStart", method = RequestMethod.POST)
	public int commuteStart(@RequestParam("user_id") String user_id, EmpAttendanceVO vo) {

		logger.info("@@@@@@@@@@@@@@startuser_id@@@@@@@@@@@ :"+user_id);
		// user_id로 user_no 구하기
		int user_no = 0;
		try {
			user_no = eService.user_no(user_id);
			logger.info("@@@@@@@@@@@@@start@user_no@@@@@@@@@@@ :"+user_no);
			vo.setUser_no(user_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 Date date = new Date();
	        SimpleDateFormat sim = new SimpleDateFormat("HH시mm분ss초");
	        String str = sim.format(date);
	        int hour = Integer.parseInt(str.substring(0, 2));
	        int minute = Integer.parseInt(str.substring(3, 5));
	        // 출석, 지각, 결석 여부 : 기본값은 결석, 날짜 출력 포멧의 일부분을 가져와 int 자료형으로 형변환 한 뒤
	        // 값을 비교하여 지각, 출석 여부를 판별한다.
	        
	        if (hour >= 9 ) { 
	            vo.setCheck_status("지각");
	        	logger.info("현재 시각 : "+str);
	        	logger.info("지각입니다.");
	            try {
	    			eService.workStart(vo);
	    			logger.info("@@@@@@@@@@@@@@start출근성공@@@@@@@@@@@ :");
	    		} catch (Exception e) {
	    			e.printStackTrace();
	    		}
	        } else {
	        	vo.setCheck_status("출근");
	        	try {
	        		eService.workStart(vo);
	        		logger.info("@@@@@@@@@@@@@@start출근성공@@@@@@@@@@@ :");
	        	} catch (Exception e) {
	        		e.printStackTrace();
	        	}
	           
	        }
		
		
		return 1;
	}
	
	// 출근했는지 확인하는 메소드
	@ResponseBody
	@RequestMapping(value="/checkWork", method = RequestMethod.GET)
	public int checkCommute(@RequestParam("user_id") String user_id, Principal principal) {
		// 리턴 string
		//boolean isExist = false;
		
		// user_id로 user_no 구하기
		Integer user_no = 0;
		String check = null;
		int checkW = 0;
		if (principal != null) {
			try {
				user_no = eService.user_no(user_id);
				logger.info("@@@@@@@@@@@@@checkuser_no@@@@@@@@@@@ :"+user_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			try {
				check = eService.checkWork(user_no);
				logger.info("@@@@@@@@@@@@@@check출근상태11111@@@@@@@@@@@ :"+check);
				//String check = eService.checkWork(user_no);
				if(check != null) {
					logger.info("@@@@@@@@@@@@@@check출근상태222222@@@@@@@@@@@ :"+check);
					
					if(check.equals("출근")){
						//isExist = true;
						checkW = 1;
					}else if(check.equals("퇴근")) {
						checkW = 2;
					}else if(check.equals("외출")){
						checkW = 3;
					}
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		logger.info("@@@@@@@@@@@@@@check출근상태@@@@@@@@@@@ :"+check);
		
		//return isExist;
		return checkW;
	}
		
	// 퇴근하기
	@ResponseBody
	@RequestMapping(value = "/endWork",method = RequestMethod.POST)
	public int endWork(@RequestParam("user_id") String user_id) {
		logger.info("@@@@@@@@@@@@@@enduser_id@@@@@@@@@@@ :"+user_id);
		// user_id로 user_no 구하기
		int user_no = 0;
		try {
			user_no = eService.user_no(user_id);
			logger.info("@@@@@@@@@@@@@@enduser_no@@@@@@@@@@@ :"+user_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			eService.endWork(user_no);
			logger.info("@@@@@@@@@@@@@@end퇴근성공@@@@@@@@@@@ :");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 1;
		
	}
	// 외출하기
	@ResponseBody
	@RequestMapping(value = "/outWork",method = RequestMethod.POST)
	public int outWork(@RequestParam("user_id") String user_id) {
		logger.info("@@@@@@@@@@@@@@outuser_id@@@@@@@@@@@ :"+user_id);
		// user_id로 user_no 구하기
		int user_no = 0;
		try {
			user_no = eService.user_no(user_id);
			logger.info("@@@@@@@@@@@@@@outuser_no@@@@@@@@@@@ :"+user_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			eService.outWork(user_no);
			logger.info("@@@@@@@@@@@@@@out외출성공@@@@@@@@@@@ :");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 1;
		
	}
	// 복귀하기
	@ResponseBody
	@RequestMapping(value = "/inWork",method = RequestMethod.POST)
	public int inWork(@RequestParam("user_id") String user_id) {
		logger.info("@@@@@@@@@@@@@@inuser_id@@@@@@@@@@@ :"+user_id);
		// user_id로 user_no 구하기
		int user_no = 0;
		try {
			user_no = eService.user_no(user_id);
			logger.info("@@@@@@@@@@@@@@inuser_no@@@@@@@@@@@ :"+user_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			eService.inWork(user_no);
			logger.info("@@@@@@@@@@@@@@복귀성공@@@@@@@@@@@ :");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 1;
		
	}
	
	// 직원 상세페이지
	@GetMapping(value = "/empDetail")
	public void empDetailGET(Model model,@RequestParam int user_no,Criteria cri) throws Exception{
		logger.debug(" empDetailGET() 실행 ");
		
		Map<String, Object> resultVO = eService.empDetail(user_no);
		logger.info("resultVO :"+ resultVO);
		logger.info("resultVO :"+ resultVO.get("fileVO"));
		
		//전달할 정보 저장
		model.addAttribute("empDt", resultVO.get("EmployeeVO"));
		model.addAttribute("fileList", resultVO.get("fileVO"));
		
		logger.debug(" @@@@@@@@@@@ int user_no = "+user_no);
		model.addAttribute("job", commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
	    model.addAttribute("job_rank", commonCodeService.getCommonCodeDetailsByCodeId("JOB_RANK"));
		
		//model.addAttribute("pageInfo",cri);
		
	}
	
	// 직원수정
	@ResponseBody
	@PostMapping(value = "/empUpdate")
	public void empUpdatePOST(EmployeeVO vo, AuthVO avo) throws Exception {
		logger.info("@@@@@@@@@@@@@@모달창으로 직원 수정(컨트롤러)");
		
		logger.info("vo :"+vo);
		
		// 직원 권한부여
		avo.setUser_id(vo.getUser_id());
		if(vo.getJob_rank().equals("관리자")) {
			avo.setAuth("ROLE_ADMIN");
		}else if(vo.getJob_rank().equals("팀장")) {
			avo.setAuth("ROLE_MANAGER");			
		}else if(vo.getJob_rank().equals("사원")) {
			avo.setAuth("ROLE_MEMBER");						
		}
		eService.authUpdate(avo);
		logger.info("avo :"+avo);
		
		eService.empUpdate(vo);
		
	}

	// 직원수정
	@ResponseBody
	@PostMapping(value = "/myUpdate")
	public void myUpdatePOST(EmployeeVO vo, AuthVO avo) throws Exception {
		logger.info("@@@@@@@@@@@@@@모달창으로 직원 수정(컨트롤러)");
		
		logger.info("vo :"+vo);
		if(vo.getJob().equals("관리자")) {
			vo.setJob_rank("관리자");
		}
		
		// 직원 권한부여
		avo.setUser_id(vo.getUser_id());
		if(vo.getJob_rank().equals("관리자")) {
			avo.setAuth("ROLE_ADMIN");
		}else if(vo.getJob_rank().equals("팀장")) {
			avo.setAuth("ROLE_MANAGER");			
		}else if(vo.getJob_rank().equals("사원")) {
			avo.setAuth("ROLE_MEMBER");						
		}
		eService.authUpdate(avo);
		logger.info("avo :"+avo);
		
		eService.myUpdate(vo);
		
	}
	
	// 직원 삭제(퇴사)
	@GetMapping(value = "/reEmp")
	public String reEmp(@RequestParam("user_id") String user_id) throws Exception{
		
		logger.info("직원삭제@@@@@@@ :"+user_id);
		eService.reEmp(user_id);
		return "redirect:/employee/empList";
	}
	
	// 직원 마이페이지
	@GetMapping(value = "/myPage")
	public void myPageGET(Model model,Principal principal) throws Exception{
		logger.debug(" myPageGET() 실행 ");
		// user_id로 user_no 구하기
		int user_no = 0;

		if (principal != null) {
			logger.info("@@@@@@@@@@@@@@principal.getName()@@@@@@@@@@@ :"+principal.getName());
			user_no = eService.user_no(principal.getName());
			List<EmpAttendanceVO> dateResult =  eService.userMonth(user_no);
			model.addAttribute("date",dateResult);
			List<EmpAttendanceVO> yearResult =  vaService.userYear(user_no);
			model.addAttribute("year",yearResult);	
			logger.info("@@@@@@@@@@@@@@date@@@@@@@@@@@ :"+dateResult);
		}

		
		Map<String, Object> resultVO = eService.empDetail(user_no);
		model.addAttribute("myP", resultVO.get("EmployeeVO"));
		model.addAttribute("fileList", resultVO.get("fileVO"));
		
		model.addAttribute("job", commonCodeService.getCommonCodeDetailsByCodeId("JOB"));
	    model.addAttribute("job_rank", commonCodeService.getCommonCodeDetailsByCodeId("JOB_RANK"));
		
		
	}
	
	// 출결확인 페이지
	@GetMapping(value = "/attend")
	public void attend(Model model,Principal principal,@RequestParam("date") String date) throws Exception{
		// user_id로 user_no 구하기
				int user_no = 0;

				if (principal != null) {
					logger.info("@@@@@@@@@@@@@@principal.getName()@@@@@@@@@@@ :"+principal.getName());
					user_no = eService.user_no(principal.getName());
					Map<String, Object> attendMap = new HashMap<String, Object>();
					attendMap.put("user_no", user_no);
					attendMap.put("date", date);
					List<EmpAttendanceVO> result =  eService.monthWork(attendMap);
					List<EmpAttendanceVO> dateResult =  eService.userMonth(user_no);
					List<EmpAttendanceVO> yearResult =  vaService.userYear(user_no);
					model.addAttribute("year",yearResult);	
					Integer countVa = eService.countVa(attendMap);
					logger.info("@@@@@@@@@@@@@@countVa()@@@@@@@@@@@ :");
					
					// countVa가 null인 경우 0으로 설정
			        if(countVa == null) {
			            countVa = 0;
			        }
			        
			        
			        
			        
			        model.addAttribute("date",dateResult);		        
			        logger.info("@@@@@@@@@@@@@@date@@@@@@@@@@@ :"+dateResult);
			        
					model.addAttribute("monthWork", result);
					model.addAttribute("countLate", eService.countLate(attendMap));
					model.addAttribute("countVa", countVa);
					model.addAttribute("countHalf", eService.countHalf(attendMap));
					
					Integer countAtt = eService.countAtt(attendMap)+countVa;
					model.addAttribute("countAtt", countAtt);
					
					logger.info("@@@@@@@@@@@@@@출결확인ㅇㅇㅇㅇ@@@@@@@@@@@ :"+result);
				}

				Map<String, Object> resultVO = eService.empDetail(user_no);
				model.addAttribute("myP", resultVO.get("EmployeeVO"));
	}

	// 휴가관리 페이지
	@GetMapping(value = "/myVacation")
	public void myVacation(Model model,Principal principal,@RequestParam("date") String date) throws Exception{
		// user_id로 user_no 구하기
		int user_no = 0;
		
		if (principal != null) {
			logger.info("@@@@@@@@@@@@@@principal.getName()@@@@@@@@@@@ :"+principal.getName());
			user_no = eService.user_no(principal.getName());
			
			Map<String, Object> vaMap = new HashMap<String, Object>();
			vaMap.put("user_no", user_no);
			vaMap.put("date", date);
			List<EmpAttendanceVO> myVaca = vaService.myVaca(vaMap);
			
			List<EmpAttendanceVO> yearResult =  vaService.userYear(user_no);
			model.addAttribute("year",yearResult);		   
			
			List<EmpAttendanceVO> dateResult =  eService.userMonth(user_no);
			model.addAttribute("date",dateResult);	
			
			logger.info("@@@@@@@@@@@@@@date@@@@@@@@@@@ :"+dateResult);
			Integer countVa = eService.yearCountVa(user_no);
			Integer countHalf = eService.yearCountHalf(user_no);
			if(countVa != null) {
				if(countHalf != null) {
					double leftVa = 12 - countVa - (countHalf / 2.0);
					model.addAttribute("leftVa",leftVa);					
				}else {
					double leftVa = 12 - countVa;
					model.addAttribute("leftVa",leftVa);										
				}
				
			}else if(countHalf != null) {
				double leftVa = 12 - (countHalf / 2.0);
				model.addAttribute("leftVa",leftVa);					
			}
			
			// countVa가 null인 경우 0으로 설정
	        if(countVa == null) {
	            countVa = 0;
	        }
			model.addAttribute("countVa", countVa);
			model.addAttribute("countHalf",countHalf);
			model.addAttribute("myVaca", myVaca);
		}
		
		
		Map<String, Object> resultVO = eService.empDetail(user_no);
		model.addAttribute("myP", resultVO.get("EmployeeVO"));
	}
	

	//이메일 중복 체크
	@ResponseBody
	@GetMapping(value = "/emailCheck")
	public int emailCheckGET(@RequestParam("email")String email) throws Exception{
		int result = eService.emailCheck(email);
		logger.info("이메일 중복체크 :"+result);
		return result;
	}
	
	//전화번호 중복 체크
	@ResponseBody
	@GetMapping(value = "/phoneCheck")
	public int phoneCheckGET(@RequestParam("phone_no")String phone_no) throws Exception {
		int result = eService.phoneCheck(phone_no);
		logger.info("전화번호 중복체크 :"+result);
		return result; 
	}
	
	
}
