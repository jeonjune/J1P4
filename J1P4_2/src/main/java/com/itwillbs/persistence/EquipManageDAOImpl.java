package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EquipManageVO;

@Repository
public class EquipManageDAOImpl implements EquipManageDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.itwillbs.mapper.equipmentMapper.";

	
	//장비신청페이지
	@Override
	public void equipAdd(EquipManageVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"equipAdd", vo);
		
	}
	
	//장비신청내역 리스트
	@Override
	public List<EquipManageVO> equipList() throws Exception {
		return sqlSession.selectList(NAMESPACE+"equipList");
		
	}

	//특정 장비신청 상세페이지 조회
	@Override
	public EquipManageVO equipDetail(int eno) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"equipDetail", eno);
	}
	
	
	
	

}
