package com.itwillbs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmployeeVO;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.employeeMapper.";

	@Override
	public void empJoin(EmployeeVO vo) {
		
	}
	
	
	

}
