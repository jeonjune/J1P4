package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.domain.EmployeeVO;

public interface EmployeeService {
	
	// 직원 리스트 목록 조회
	public List<EmployeeVO> empList(Criteria cri) throws Exception;
	
	// 직원등록
	public void empJoin(EmployeeVO vo) throws Exception;
		
	// 직원 권한등록
	public void empAuth(AuthVO avo) throws Exception;
	
	//아이디 중복 체크
	public int idCheck(String user_id) throws Exception;
	
	// user_id 로 user_no 구하기
	public int user_no(String user_id) throws Exception;
	
	// 직원 출근
	public void workStart(EmpAttendanceVO vo) throws Exception;
	
	// 출근상태 확인
	public String checkWork(int user_no) throws Exception;
	
	//퇴근하기
	public void endWork(int user_no)throws Exception;
	
	//외출하기
	public void outWork(int user_no)throws Exception;
	
	//복귀하기
	public void inWork(int user_no)throws Exception;
	
	// 직원 상세페이지
	public Map<String, Object> empDetail(int user_no) throws Exception;
	
	// 직원 수정
	public void empUpdate(EmployeeVO vo) throws Exception;
	
	// 내 정보 수정
	public void myUpdate(EmployeeVO vo) throws Exception;
	
	// 직원 권한 수정
	public void authUpdate(AuthVO vo) throws Exception;
	
	// 직원 삭제(퇴사)
	public void reEmp(String user_id) throws Exception;
	
	// 내 출근 확인
	public List<EmpAttendanceVO> monthWork(Map<String, Object> user_no) throws Exception;
	
	// 내 출근 확인2
	public List<EmpAttendanceVO> userMonth(int user_no) throws Exception;
	
	// 직원리스트 개수 (페이징)
	public int getTotalEmpCount() throws Exception;
	
	// 지각 카운트
	public Integer countLate(Map<String, Object> user_no) throws Exception;
	
	// 휴가 카운트
	public Integer countVa(Map<String, Object> user_no) throws Exception;
	
	// 반차 카운트
	public Integer countHalf(Map<String, Object> user_no) throws Exception;
	
	// 올해 휴가 카운트
	public Integer yearCountVa(int user_no) throws Exception;
	
	// 올해 반차 카운트
	public Integer yearCountHalf(int user_no) throws Exception;
	
	// 이번달 출석일
	public Integer countAtt(Map<String, Object> user_no) throws Exception;
	
	// 반려안된 총 휴가수
	public Integer appCount(int user_no) throws Exception;
	
	// 반려안된 총 반차 수
	public Integer appHCount(int user_no) throws Exception;
	
	// 이메일 중복체크
	public int emailCheck(String email) throws Exception;
	
	//전화번호 중복체크
	public int phoneCheck(String phone_no) throws Exception;

	

}
