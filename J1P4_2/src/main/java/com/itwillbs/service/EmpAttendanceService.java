package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.EmpAttendanceVO;

public interface EmpAttendanceService {
	
	// 캘린더 리스트 조회
	public List<EmpAttendanceVO> getCalendar() throws Exception;
	
	// 휴가 신청
	public void vacation(EmpAttendanceVO vo) throws Exception;
	
	// 신청한 휴가 리스트
	public List<EmpAttendanceVO> reqVaca() throws Exception;


}
