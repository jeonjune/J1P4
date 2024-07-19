package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.EmployeeVO;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.employeeMapper.";

	@Override
	public List<EmployeeVO> empList() throws Exception {
		return sqlSession.selectList(NAMESPACE+"empList");
	}

	@Override
	public void empJoin(EmployeeVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"empJoin", vo);
	}

	@Override
	public void empAuth(AuthVO avo) throws Exception {
		sqlSession.insert(NAMESPACE+"empAuth", avo);
	}
	
	//아이디 중복체크
	@Override
	public int idCheck(String user_id) throws Exception {
		int res = sqlSession.selectOne(NAMESPACE+"selectId", user_id);
		logger.debug("res :"+res);

		return res;
	}
	

}
