package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.EquipManageVO;

public interface EquipManageService {
	
	//장비신청
	public void equipAdd(EquipManageVO vo) throws Exception;
			
	//장비신청내역리스트
	public List<EquipManageVO> equipList() throws Exception;

}
