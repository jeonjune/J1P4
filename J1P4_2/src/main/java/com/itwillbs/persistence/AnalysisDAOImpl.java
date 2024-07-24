package com.itwillbs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class AnalysisDAOImpl implements AnalysisDAO {

	private static final Logger logger = LoggerFactory.getLogger(AnalysisDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.analysisMapper.";

	// 총 회원 수
	@Override
	public int totalMemCount() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+"totalMemCount");
	}

	// 이번 달 신규 회원 수
	@Override
	public int newMemCount() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+"newMemCount");
	}

	// 이번 달 등록 회원 수
	@Override
	public int regMemCount() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+"regMemCount");
	}

	// 이번 달 등록 회원 수 / 총 회원 수
	@Override
	public double rmcTmc() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+"rmcTmc");
	}
	
}
