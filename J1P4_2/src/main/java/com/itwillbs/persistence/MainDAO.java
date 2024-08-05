package com.itwillbs.persistence;

import com.itwillbs.domain.EmployeeVO;

public interface MainDAO {
	
	// 메인페이지 이동시 세션담기
	public EmployeeVO logInfo(String user_id) throws Exception;

}
