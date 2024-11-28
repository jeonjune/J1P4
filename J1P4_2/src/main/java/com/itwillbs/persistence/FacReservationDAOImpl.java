package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.FacilityReservationVO;
import com.itwillbs.domain.TimeTableVO;

@Repository
public class FacReservationDAOImpl implements FacReservationDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.itwillbs.mapper.facReservationMapper.";
	
	//시설예약 등록
	@Override
	public int reservation(FacilityReservationVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"reservation", vo);
		 return vo.getFaReservation_no();
	}
	
	//시설예약 캘린더 조회
	@Override
	public List<FacilityReservationVO> rsvSelect() throws Exception {
		List<FacilityReservationVO> calendar = null;
		calendar = sqlSession.selectList(NAMESPACE+"rsvSelect");
		return calendar;
	}
	
	
	//시설별 시간대조회 11/11 수정
	@Override
	public List<TimeTableVO> timeSelect(int facNo, String rsvDate) throws Exception {
		System.out.println("실행실행" );
		Map<String, Object> params = new HashMap<>();
		params.put("facility_no", facNo);
		params.put("rsv_date", rsvDate);
		return sqlSession.selectList(NAMESPACE+"timeSelect", params);
	}
	
	//시설번호11/4
	@Override
	public int facNo(int facNo) throws Exception {
		return sqlSession.insert(NAMESPACE+"facNo",facNo);
	}
	
	@Override
	public String facName(int facNo) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE +"facName", facNo) ;
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
