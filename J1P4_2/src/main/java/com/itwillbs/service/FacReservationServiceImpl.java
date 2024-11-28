package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.FacilityReservationVO;
import com.itwillbs.domain.TimeTableVO;
import com.itwillbs.persistence.FacReservationDAO;

@Service
public class FacReservationServiceImpl implements FacReservationService {

	@Inject
	private FacReservationDAO fdao;
	
	//시설예약등록
	@Override
	public int reservation(FacilityReservationVO vo) throws Exception {
		return fdao.reservation(vo);
	}

	//시설예약 캘린더 조회
	@Override
	public List<FacilityReservationVO> rsvSelect() throws Exception {
		return fdao.rsvSelect();
	}
	
	//시설별 시간대조회 11/11
//	@Override
//	public List<TimeTableVO> timeSelect(int facNo) throws Exception {
//		System.out.println("실행실행" );
//		return fdao.timeSelect(facNo);
//	}
	
	//시설별 시간대조회 11/11 수정
	@Override
	public List<TimeTableVO> timeSelect(int facNo, String rsvDate) throws Exception {
		System.out.println("실행실행" );
		return fdao.timeSelect(facNo,rsvDate);
	}
		
	//시설번호11/4
	@Override
	public int facNo(int facNo) throws Exception {
		
		return fdao.facNo(facNo);
	}
	

	@Override
	public String facName(int facNo) throws Exception {
		
		return fdao.facName(facNo);
	}

	//시설예약 수정
	@Override
	public void rsvUpdate(FacilityReservationVO vo) throws Exception {
		fdao.rsvUpdate(vo);
		
	}
	

	//시설예약 삭제
	@Override
	public void rsvDelete(FacilityReservationVO vo) throws Exception {
		fdao.rsvDelete(vo);
	}
	
	//시설예약 회원검색
	@Override
	public List<FacilityReservationVO> memSearch(String keyword) throws Exception {
		return fdao.memSearch(keyword);
	}
	
	
}
