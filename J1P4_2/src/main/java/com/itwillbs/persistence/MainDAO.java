package com.itwillbs.persistence;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.fileVO;

public interface MainDAO {
	
	// 메인페이지 이동시 세션담기
	public EmployeeVO logInfo(String user_id) throws Exception;
	
	// 메인페이지 이동시 사진정보 담기
	public fileVO logPic(String user_id) throws Exception;

}
