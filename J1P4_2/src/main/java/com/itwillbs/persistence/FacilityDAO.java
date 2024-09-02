package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.FacilityVO;

public interface FacilityDAO {

	//시설리스트 목록 조회
	public List<FacilityVO> facList() throws Exception;
	
	//시설리스트 등록
	public void facInsert(FacilityVO vo) throws Exception;
	
	//시설상세내역 등록
	public void facDeIn(FacilityManagementVO vo) throws Exception;
	
	//시설상세내역 조회
	public List<FacilityManagementVO> facDe(Criteria cri) throws Exception;
	
	//시설상세내역 조회 페이징
	public int getCountFacDe(int facNo) throws Exception;
	
	//시설 한달간격 count 조회
	public List<FacilityManagementVO> count(int facNo) throws Exception;
	
	//시설 최신날짜 조회
	public List<FacilityManagementVO> dateUpdate(int facNo) throws Exception;
	
	//시설 이름 조회
	public String facName(int facNo) throws Exception;
	
	//시설 한달 뒤 청소->삭제로 변경
	public void typeUpdate(FacilityManagementVO vo) throws Exception;
}
