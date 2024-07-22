package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

@Repository
public class SearchDAOImpl implements SearchDAO {

	private static final Logger logger = LoggerFactory.getLogger(SearchDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.SearchMapper.";
	
	@Override
	public List<MemberVO> searchMem(Criteria cri) throws Exception {
	    return sqlSession.selectList(NAMESPACE + "searchMem", cri);
	    
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		logger.debug(" (⌐■_■) DAO : getTotalCount() 실행 ");
		return sqlSession.selectOne(NAMESPACE+"totalCount",cri);
	}

	
	
}
