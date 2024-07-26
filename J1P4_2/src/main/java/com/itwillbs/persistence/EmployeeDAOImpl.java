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
	
	// user_id 로 user_no 구하기
	@Override
	public int user_no(String user_id) throws Exception {
		int user_no = sqlSession.selectOne(NAMESPACE+"getUN", user_id);
		return user_no;
	}

	// 출근
	@Override
	public void workStart(int user_no) throws Exception {
		sqlSession.insert(NAMESPACE+"workStart", user_no);
	}

	@Override
	public String checkWork(int user_no) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"checkWork", user_no);
	}

	@Override
	public void endWork(int user_no) throws Exception {
		sqlSession.update(NAMESPACE+"endWork", user_no);
		
	}

	@Override
	public void outWork(int user_no) throws Exception {
		sqlSession.update(NAMESPACE+"outWork", user_no);
		
	}

	@Override
	public void inWork(int user_no) throws Exception {
		sqlSession.update(NAMESPACE+"inWork", user_no);
		
	}

	@Override
	public EmployeeVO empDetail(int user_no) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"empDetail",user_no);
	}
	
	// 직원 수정
	@Override
	public void empUpdate(EmployeeVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"empUpdate", vo);
	}
	// 직원 권한 수정
	@Override
	public void authUpdate(AuthVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"authUpdate", vo);
		
	}

	@Override
	public void reEmp(String user_id) throws Exception {
		sqlSession.update(NAMESPACE+"reEmp", user_id);
	}
	
	
	

}
