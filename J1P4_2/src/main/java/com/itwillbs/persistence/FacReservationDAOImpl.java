package com.itwillbs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.FacilityReservationVO;

@Repository
public class FacReservationDAOImpl implements FacReservationDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.itwillbs.mapper.facReservationMapper.";
	
	//시설예약 등록
	@Override
	public void reservation(FacilityReservationVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"reservation", vo);
	}
	
	//시설예약 캘린더 조회
	@Override
	public List<FacilityReservationVO> rsvSelect() throws Exception {
		List<FacilityReservationVO> calendar = null;
		calendar = sqlSession.selectList(NAMESPACE+"rsvSelect");
		return calendar;
	}

	//시설예약 수정
	@Override
	public void rsvUpdate(FacilityReservationVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"rsvUpdate", vo);
	}
	
	//시설예약 삭제
	@Override
	public void rsvDelete(FacilityReservationVO vo) throws Exception {
		sqlSession.delete(NAMESPACE+"rsvDelete", vo);
	}
	
	//시설예약 회원검색
	@Override
	public List<FacilityReservationVO> memSearch(String keyword) throws Exception {
		return sqlSession.selectList(NAMESPACE+"memSearch",keyword);
	}
	
	
	
	
	
	
	
	
}
