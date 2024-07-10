package com.itwillbs.persistence;

import javax.inject.Inject;

//import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.TestVO;

@Repository
public class TestDAOImpl implements TestDAO {
	
	@Inject
//	private SqlSession sqlSession;
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper.";
	
	@Override
	public void test(TestVO vo) {
//		sqlSession.insert(NAMESPACE+"test",vo);
	}

	
}
