package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.FacilityVO;

public interface FacilityService {
	
	//시설리스트 목록 조회
	public List<FacilityVO> facList() throws Exception;
	
	//시설리스트 등록
	public void facInsert(FacilityVO vo) throws Exception;
	
}
