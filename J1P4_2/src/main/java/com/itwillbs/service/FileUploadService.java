package com.itwillbs.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NotificationVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.fileVO;

public interface FileUploadService {
		
	public void fileEmpAdd(fileVO vo) throws Exception;
	
	// 직원 사진수정
	public int updateEmpFile(fileVO vo) throws Exception;
	
	// 마이프로필 파일등록
	public void fileProfAdd(fileVO vo) throws Exception;
}
