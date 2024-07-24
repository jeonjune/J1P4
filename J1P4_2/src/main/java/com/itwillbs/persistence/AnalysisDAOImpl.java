package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	// 6개월간 월 별 신규 회원 수
	@Override
	public Map<String, Integer> new6MemCount() throws Exception {
		List<Map<String, Object>> result = sqlSession.selectList(NAMESPACE + "new6MemCount");
		Map<String, Integer> new6MemCount = new HashMap<>(); 
        for (Map<String, Object> row : result) {
            String month = (String) row.get("month");
            Integer newMembers = ((Long) row.get("new_members")).intValue();
            new6MemCount.put(month, newMembers);
        }
        return new6MemCount;
	}
	
}
