package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.FacilityReservationVO;
import com.itwillbs.persistence.FacReservationDAO;

@Service
public class FacReservationServiceImpl implements FacReservationService {

	@Inject
	private FacReservationDAO fdao;
	
	//시설예약등록
	@Override
	public void reservation(FacilityReservationVO vo) throws Exception {
		fdao.reservation(vo);
	}
	
	//시설예약 캘린더 조회
	@Override
	public List<FacilityReservationVO> rsvSelect() throws Exception {
		return fdao.rsvSelect();
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
