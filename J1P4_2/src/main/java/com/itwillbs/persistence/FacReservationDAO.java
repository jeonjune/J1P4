package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.FacilityReservationVO;

public interface FacReservationDAO {
	
	//시설예약 등록
	public void reservation(FacilityReservationVO vo) throws Exception;
	
	//시설예약 캘린터 조회
	public List<FacilityReservationVO> rsvSelect() throws Exception;
	
	//시설예약 수정
	public void rsvUpdate(FacilityReservationVO vo) throws Exception;
	
	//시설예약 삭제
	public void rsvDelete(FacilityReservationVO vo) throws Exception;
	
	//시설예약 회원검색
	public List<FacilityReservationVO> memSearch(String keyword) throws Exception;
}
