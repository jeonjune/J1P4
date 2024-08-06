package com.itwillbs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.fileVO;

@Repository
public class MainDAOImpl implements MainDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.mainMapper.";

	@Override
	public EmployeeVO logInfo(String user_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"logInfo", user_id);
	}

	@Override
	public fileVO logPic(String user_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"logPic",user_id);
	}
	
	

}
