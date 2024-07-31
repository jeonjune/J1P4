package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.EmpAttendanceVO;

public interface EmpAttendanceDAO {
	
	// 캘린더 조회
	public List<EmpAttendanceVO> getCalendar() throws Exception;

}
