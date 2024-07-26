package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.fileVO;

public interface EquipManageService {
	
	//장비신청
	public void equipAdd(EquipManageVO vo) throws Exception;
			
	//장비신청내역리스트
	public List<EquipManageVO> equipList() throws Exception;
	
	//특정 장비신청 상세페이지 조회
	public Map<String, Object> equipDetail(int eno) throws Exception;
	
	//파일등록
	public void fileAdd(fileVO vo) throws Exception;

}
