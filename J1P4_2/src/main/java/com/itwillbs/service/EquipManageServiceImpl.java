package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.persistence.EquipManageDAO;

@Service
public class EquipManageServiceImpl implements EquipManageService {
	
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
	
	
}


