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

}
