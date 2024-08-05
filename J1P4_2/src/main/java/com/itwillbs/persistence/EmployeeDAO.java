package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.domain.EmployeeVO;

public interface EmployeeDAO {
	
	// 직원 리스트 조회
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

	//외출하기
	public void inWork(int user_no)throws Exception;
	
	// 직원 상세페이지
	public Map<String, Object> empDetail(int user_no) throws Exception;
	
	// 직원 수정
	public void empUpdate(EmployeeVO vo) throws Exception;
	
	// 직원 권한 수정
	public void authUpdate(AuthVO vo) throws Exception;
	
	// 직원 삭제(퇴사)
	public void reEmp(String user_id) throws Exception;
	
	// 내 출근 확인
	public List<EmpAttendanceVO> monthWork(int user_no) throws Exception;
	
	// 직원리스트 개수 (페이징)
	public int getTotalEmpCount() throws Exception;

	// 지각 카운트
	public Integer countLate(int user_no) throws Exception;
	
	// 휴가 카운트
	public Integer countVa(int user_no) throws Exception;
	
	// 반차 카운트
	public Integer countHalf(int user_no) throws Exception;

	// 올해 휴가 카운트
	public Integer yearCountVa(int user_no) throws Exception;
	
	// 올해 반차 카운트
	public Integer yearCountHalf(int user_no) throws Exception;
	
	// 이번달 출석일
	public Integer countAtt(int user_no) throws Exception;
	
	// 반려안된 총 휴가수
	public Integer appCount(int user_no) throws Exception;
	
	// 반려안된 총 반차 수
	public Integer appHCount(int user_no) throws Exception;
	
	

}
