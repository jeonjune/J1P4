package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.fileVO;
import com.itwillbs.persistence.EquipManageDAO;
import com.itwillbs.web.CommonController;

@Service
public class EquipManageServiceImpl implements EquipManageService {
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@Inject
	private EquipManageDAO edao;
	
	//장비신청
	@Override
	public void equipAdd(EquipManageVO vo) throws Exception {
		edao.equipAdd(vo);
		
	}

	//장비신청내역리스트
	@Override
	public List<EquipManageVO> equipList() throws Exception {
		return edao.equipList();
		
	}

	//특정 장비신청 상세페이지 조회
	@Override
	public Map<String, Object> equipDetail(int eno) throws Exception {
		logger.info("#####"+ edao.equipDetail(eno));
		return edao.equipDetail(eno);
	}
	
	//파일등록
	@Override
	public void fileAdd(fileVO vo) throws Exception {
		edao.fileAdd(vo);
	}
	
	//승인 후 - 장비유형 업데이트
	@Override
	public void updateType(EquipManageVO vo) throws Exception {
		edao.updateType(vo);
		
	}
	
	//장비내역리스트
	@Override
	public List<EquipManageVO> listEquip() throws Exception {
		return edao.listEquip();
	}
	
	//반려 후 - 장비유형 업데이트
	@Override
	public void updateReject(EquipManageVO vo) throws Exception {
		edao.updateReject(vo);
	}
	
	//반려내역리스트
	@Override
	public List<EquipManageVO> rejectList() throws Exception {
		return edao.rejectList();
	}
	
	
	
	
	
}


