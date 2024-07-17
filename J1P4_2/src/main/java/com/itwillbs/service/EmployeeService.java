package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.EmployeeVO;

public interface EmployeeService {
	
	// 직원 리스트 목록 조회
		public List<EmployeeVO> empList() throws Exception;
	
	// 직원등록
		public void empJoin(EmployeeVO vo) throws Exception;

}
