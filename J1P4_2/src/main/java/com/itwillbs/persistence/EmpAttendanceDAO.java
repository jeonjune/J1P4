package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmpAttendanceVO;

public interface EmpAttendanceDAO {
	
	// 캘린더 조회
	public List<EmpAttendanceVO> getCalendar() throws Exception;
	
	// 휴가 신청
	public void vacation(EmpAttendanceVO vo) throws Exception;
	
	// 신청한 휴가 리스트
	public List<EmpAttendanceVO> reqVaca() throws Exception;

	// 승인된 휴가 리스트
	public List<EmpAttendanceVO> yVaca(Criteria cri) throws Exception;

	// 반려된 휴가 리스트
	public List<EmpAttendanceVO> nVaca() throws Exception;
	

	// 직무별 신청한 휴가 리스트
	public List<EmpAttendanceVO> reqJob(String job) throws Exception;
	
	// 직무별 승인된 휴가 리스트
	public List<EmpAttendanceVO> yVaJob(Criteria cri) throws Exception;
	
	// 직무별 반려된 휴가 리스트
	public List<EmpAttendanceVO> nVaJob(String job) throws Exception;
	
	
	// 휴가 반려
	public void reVaca(EmpAttendanceVO vo) throws Exception;

	// 휴가 승인
	public void yVa(int empAttend_no) throws Exception;
	
	// user_no 로 name 구하기
	public String getName(int user_no) throws Exception;
	
	// 내 휴가 리스트
	public List<EmpAttendanceVO> myVaca(Map<String, Object> user_no) throws Exception;

	// 내 휴가 리스트2
	public List<EmpAttendanceVO> userYear(int user_no) throws Exception;
	
	// 승인된 휴가 리스트 페이징
	public int getyVacaCount() throws Exception;
	
	// 직무별 승인된 휴가 리스트 페이징
	public int getyVaJobCount() throws Exception;
	
}
