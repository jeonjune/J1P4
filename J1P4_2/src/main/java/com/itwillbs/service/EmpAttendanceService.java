package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.EmpAttendanceVO;

public interface EmpAttendanceService {
	
	// 캘린더 리스트 조회
	public List<EmpAttendanceVO> getCalendar() throws Exception;

}
