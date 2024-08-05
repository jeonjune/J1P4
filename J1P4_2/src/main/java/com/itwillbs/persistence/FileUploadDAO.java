package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NotificationVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.fileVO;

public interface FileUploadDAO {
	
	// 직원 파일등록
	public void fileEmpAdd(fileVO vo) throws Exception;
	
	// 직원 사진수정
	public void updateEmpFile(fileVO vo) throws Exception;

}
