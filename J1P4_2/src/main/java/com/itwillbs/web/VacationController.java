package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	

}
