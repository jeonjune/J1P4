package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.EmpAttendanceVO;

public interface EmpAttendanceDAO {
	
	// 캘린더 조회
	public List<EmpAttendanceVO> getCalendar() throws Exception;
	
	// 휴가 신청
	public void vacation(EmpAttendanceVO vo) throws Exception;
	
	// 신청한 휴가 리스트
	public List<EmpAttendanceVO> reqVaca() throws Exception;

}
