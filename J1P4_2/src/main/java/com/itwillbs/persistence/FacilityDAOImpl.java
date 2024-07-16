package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.FacilityVO;

@Repository
public class FacilityDAOImpl implements FacilityDAO {
	
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.itwillbs.mapper.facilityMapper.";
	
	//시설리스트 조회
	@Override
	public List<FacilityVO> facList() throws Exception {
		return sqlSession.selectList(NAMESPACE+"facList");
	}

	//시설리스트등록
	@Override
	public void facInsert(FacilityVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"facInsert", vo);
	}
	
	
	
	
}
