package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.FacilityVO;

@Repository
public class FacilityDAOImpl implements FacilityDAO {
	private static final Logger logger = LoggerFactory.getLogger(FacilityDAOImpl.class);
	
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
	
	//시설상세내역 등록
	@Override
	public void facDeIn(FacilityManagementVO vo) throws Exception {
		logger.debug(" ################FacilityManagementVO vo) 실행 ");
		sqlSession.insert(NAMESPACE+"facDeIn", vo);
		
	}
	
	//시설상세내역 조회
	@Override
	public List<FacilityManagementVO> facDe(int facNo) throws Exception {
		return sqlSession.selectList(NAMESPACE+"facDe", facNo);
	}

	//시설 한달간격 count 조회
	@Override
	public List<FacilityManagementVO> count(int facNo) throws Exception {
		return sqlSession.selectList(NAMESPACE+"count", facNo);
	}

	//시설 최신날짜 조회
	@Override
	public List<FacilityManagementVO> dateUpdate(int facNo) throws Exception {
		return sqlSession.selectList(NAMESPACE+"dateUpdate",facNo);
	}
	
	//시설 이름 조회
	@Override
	public String facName(int facNo) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+"facName", facNo);
	}
	
	
	
	

	
	
	
	
	
}
