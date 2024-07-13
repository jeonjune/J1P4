package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.TestVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper.";

	@Override
	public List<MemberVO> listAll() throws Exception {
		return sqlSession.selectList(NAMESPACE+"listAll");
	}

	@Override
	public List<MemberVO> listPage(int page) throws Exception {
		logger.debug(" listPage(int page) 실행");
		
		// 페이징 처리 계산
		// 1p(0~9) , 2p(10~19), 3p(20~29) ...
		if(page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;
		
		return sqlSession.selectList(NAMESPACE+"listPage",page);
	}

	@Override
	public List<MemberVO> listPage(Criteria cri) throws Exception {
		logger.debug(" listPage(Criteria cri) 실행 ");
		
		return sqlSession.selectList(NAMESPACE+"listPage2",cri);
	}

	@Override
	public int getTotalCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalCount");
	}
	
	
	
}
