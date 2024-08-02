package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.EmpAttendanceVO;

@Repository
public class EmpAttendanceDAOImpl implements EmpAttendanceDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.empAttendanceMapper.";
	
	public List<EmpAttendanceVO> getCalendar() throws Exception {
		List<EmpAttendanceVO> calendar = null;
		calendar = sqlSession.selectList(NAMESPACE+"calendar");
		return calendar;
	}

	@Override
	public void vacation(EmpAttendanceVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"vacation", vo);
		
	}

	@Override
	public List<EmpAttendanceVO> reqVaca() throws Exception {
		
		return sqlSession.selectList(NAMESPACE+"reqVaca");
	}

	@Override
	public List<EmpAttendanceVO> yVaca() throws Exception {

		return sqlSession.selectList(NAMESPACE+"yVaca");
	}

	@Override
	public List<EmpAttendanceVO> nVaca() throws Exception {
		
		return sqlSession.selectList(NAMESPACE+"nVaca");
	}

	@Override
	public void reVaca(EmpAttendanceVO vo) throws Exception {
		sqlSession.update(NAMESPACE + "rejectVa", vo);
		
	}

	@Override
	public void yVa(int empAttend_no) throws Exception {
		sqlSession.update(NAMESPACE+"yVa", empAttend_no);
		
	}

	@Override
	public String getName(int user_no) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"getName", user_no);
	}

	@Override
	public List<EmpAttendanceVO> myVaca(int user_no) throws Exception {
		return sqlSession.selectList(NAMESPACE+"myVaca" , user_no);
	}
	
	

}
