package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.EmployeeVO;

public interface EmployeeDAO {
	
	// 직원 리스트 조회
	public List<EmployeeVO> empList() throws Exception;
	
	// 직원등록
	public void empJoin(EmployeeVO vo) throws Exception;
	
	// 직원 권한등록
	public void empAuth(AuthVO avo) throws Exception;
	
	//아이디 중복 체크
	public int idCheck(String user_id) throws Exception;

}
