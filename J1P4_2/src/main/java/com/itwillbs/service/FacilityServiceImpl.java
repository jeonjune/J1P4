package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.FacilityVO;
import com.itwillbs.persistence.FacilityDAO;

@Service
public class FacilityServiceImpl implements FacilityService {
	private static final Logger logger = LoggerFactory.getLogger(FacilityServiceImpl.class);
	
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
	
	//시설내역등록
	@Override
	public void facDeIn(FacilityManagementVO vo) throws Exception {
		logger.debug(" ################facDeIn(FacilityManagementVO vo) 실행 ");
		fdao.facDeIn(vo);
		
	}
	
	//시설내역조회
	@Override
	public List<FacilityManagementVO> facDe(int facNo) throws Exception {
		
		return fdao.facDe(facNo);
	}
	
	
	
	
	
	
}
