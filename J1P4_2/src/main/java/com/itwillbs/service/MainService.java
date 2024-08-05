package com.itwillbs.service;

import com.itwillbs.domain.EmployeeVO;

public interface MainService {
	
	// 메인페이지 이동시 세션담기
	public EmployeeVO logInfo(String user_id) throws Exception;

}
