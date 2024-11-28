package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.FacilityReservationVO;
import com.itwillbs.domain.TimeTableVO;

public interface FacReservationService {
	
	//시설예약 등록
	public int reservation(FacilityReservationVO vo) throws Exception;
		
	//시설예약 캘린터 조회
	public List<FacilityReservationVO> rsvSelect() throws Exception;
	
	//시설별 시간대조회 11/11
	//public List<TimeTableVO> timeSelect(int facNo) throws Exception; 
	
	//시설별 시간대조회 11/11 수정
	public List<TimeTableVO> timeSelect(int facNo, String rsvDate) throws Exception; 
	
	//시설번호 가져오기11/4
	public int facNo(int facNo)throws Exception; 
	
	//시설예약 수정
	public void rsvUpdate(FacilityReservationVO vo) throws Exception;
	
	//시설예약 삭제
	public void rsvDelete(FacilityReservationVO vo) throws Exception;
	
	//시설예약 회원검색
	public List<FacilityReservationVO> memSearch(String keyword) throws Exception;

	//시설이름 조회
	public String facName(int facNo) throws Exception;
	
}
