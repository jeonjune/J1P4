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
	
	// 승인된 휴가 리스트
	public List<EmpAttendanceVO> yVaca() throws Exception;
	
	// 반려된 휴가 리스트
	public List<EmpAttendanceVO> nVaca() throws Exception;
	
	// 휴가 반려
	public void reVaca(EmpAttendanceVO vo) throws Exception;

	// 휴가 승인
	public void yVa(int empAttend_no) throws Exception;
	
	// user_no 로 name 구하기
	public String getName(int user_no) throws Exception;
	
	// 내 휴가 리스트
	public List<EmpAttendanceVO> myVaca(int user_no) throws Exception;
	
	

}
