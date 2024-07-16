package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.FacilityVO;
import com.itwillbs.persistence.FacilityDAO;

@Service
public class FacilityServiceImpl implements FacilityService {
	
	@Inject
	private FacilityDAO fdao;
	
	//시설리스트 목록 조회
	@Override
	public List<FacilityVO> facList() throws Exception {
		
		return fdao.facList();
	}

	//시설리스트 등록
	@Override
	public void facInsert(FacilityVO vo) throws Exception {
		fdao.facInsert(vo);
	}
	
	
	
	
	
	
}
