package com.itwillbs.web;

import java.security.Principal;
import java.sql.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.service.EmpAttendanceService;
import com.itwillbs.service.EmployeeService;

@Controller
@RequestMapping(value = "/vacation/*")
public class VacationController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);
	
	@Inject
	private EmpAttendanceService eService;
	
	@Inject
	private EmployeeService empService;
	
	//일정보기
	@RequestMapping(value = "/vacation", method = RequestMethod.GET)
	public ModelAndView getCalendarList(ModelAndView mv, HttpServletRequest request) {
		String viewpage = "/vacation/vacation";
		List<EmpAttendanceVO> calendar = null;
		try {
			calendar = eService.getCalendar();
			request.setAttribute("calendarList", calendar);
			logger.info("@@@@@@@@@@@@@@calendar@@@@@@@@@@@ :"+calendar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName(viewpage);
		return mv;
	}
	
	// 휴가 신청
	@ResponseBody
	@PostMapping(value = "/vacation")
	public String vacationPOST(EmpAttendanceVO vo, Principal principal) throws Exception {
		logger.info("모달창으로 휴가신청(컨트롤러)");
		if (principal != null) {
			logger.info("@@@@@@@@@@@@@@principal.getName()@@@@@@@@@@@ :"+principal.getName());
			int user_no = empService.user_no(principal.getName());
			logger.info("vo :"+vo);
			Integer countVa = empService.yearCountVa(user_no);
			Integer countHalf = empService.yearCountHalf(user_no);
			if(countVa != null) {
				if(countHalf != null) {
					double leftVa = 12 - countVa - (countHalf / 2.0);
					if(leftVa <= 0) {
						return "endVa";
					}
				}else {
					double leftVa = 12 - countVa;
					if(leftVa <= 0) {
						return "endVa";
					}
				}
				
			}else if(countHalf != null) {
				double leftVa = 12 - (countHalf / 2.0);
				if(leftVa <= 0) {
					return "endVa";
				}
			}
			
			// 반려 안된 휴가 신청수가 12개 넘을시 신청 못하게
			Integer appCount = empService.appCount(user_no);
			Integer appHCount = empService.appHCount(user_no);
			logger.info("@@@@@@@@@@@@@@appCount@@@@@@@@@@@ :"+appCount);
			logger.info("@@@@@@@@@@@@@@appHCount@@@@@@@@@@@ :"+appHCount);

			Integer appCVa = (appCount*2) +appHCount;
			
			// 시작 날짜와 종료 날짜 가져오기
	        Date vacationStart = vo.getVacation_start();
	        Date vacationEnd = vo.getVacation_end();

	        // 두 날짜의 차이를 밀리초 단위로 계산
	        long diffInMillies = vacationEnd.getTime() - vacationStart.getTime();

	        // 밀리초를 일 단위로 변환
	        long diffInDays = diffInMillies / (1000 * 60 * 60 * 24);
	        logger.info("@@@@@@@@@@@@@@diffInDayst@@@@@@@@@@@ :"+diffInDays);
			
	        if(appCVa+(diffInDays*2) > 24) {
				return "endVa";
			}
			
			String v_name = eService.getName(user_no);
			vo.setUser_no(user_no);
			vo.setV_name(v_name);

			eService.vacation(vo);
			}
		
		return "/vacation/vacation";
	}
	
	// 신청한 휴가 목록
	@RequestMapping(value = "/vacList", method = RequestMethod.GET)
	public void vacList(HttpSession session, Model model) throws Exception {
		logger.info("신청중인 휴가목록@@@@");
		String sess_job = (String) session.getAttribute("sess_job");
		logger.info("sess_job@@@@"+sess_job);
		if(!sess_job.equals("관리자")) {
			// 직무별로 보는 쿼리 만들기
			List<EmpAttendanceVO> reqList = eService.reqJob(sess_job);
			model.addAttribute("reqList", reqList);			
			
		}else {
			List<EmpAttendanceVO> reqList = eService.reqVaca();
			model.addAttribute("reqList", reqList);			
		}
		
		
	}
	
	// 승인된 휴가 목록
	@RequestMapping(value = "/yVacList", method = RequestMethod.GET)
	public void yVacList(Model model) throws Exception{
		logger.info("승인된 휴가목록@@@@");
		List<EmpAttendanceVO> yList = eService.yVaca();
		model.addAttribute("yList", yList);
		
		
	}
	
	// 휴가 반려
	@RequestMapping(value = "/vacList", method = RequestMethod.POST)
	public void nVac(@RequestParam("empAttend_no") int empAttend_no, @RequestParam("reject_reason") String reject_reason, EmpAttendanceVO vo) throws Exception{
		logger.info("휴가 반려@@@@" + empAttend_no + reject_reason);
		eService.reVaca(vo);
		
	}
	
	// 반려된 휴가 목록
	@RequestMapping(value = "/nVacList", method = RequestMethod.GET)
	public void nVacList(Model model) throws Exception {
		logger.info("반려된 휴가목록@@@@");
		List<EmpAttendanceVO> nList = eService.nVaca();
		model.addAttribute("nList", nList);
		 
	}
	
	// 휴가 승인
	@RequestMapping(value = "yVac",method = RequestMethod.POST)
	public String yVac(@RequestParam("empAttend_no") int empAttend_no,@RequestParam("user_no") int user_no) throws Exception {
		logger.info("휴가 승인@@@@"+ empAttend_no);
		logger.info("휴가 승인@@@@"+ user_no);
		eService.yVa(empAttend_no);
		
		return "redirect:/vacation/vacList";
	}
	
	

}
