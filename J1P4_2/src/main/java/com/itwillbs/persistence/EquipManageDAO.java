package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.fileVO;

public interface EquipManageDAO {

	//장비신청
	public void equipAdd(EquipManageVO vo) throws Exception;
		
	//장비신청내역리스트 - 사원일때
	public List<EquipManageVO> equipList(int manager_no) throws Exception;
	
	//장비신청내역리스트 - 팀장일때
	public List<EquipManageVO> equipList() throws Exception;
	
	//특정 장비신청 상세페이지 조회
	public Map<String, Object> equipDetail(int eno) throws Exception;
	
	//파일등록
	public void fileAdd(fileVO vo) throws Exception;
	
	//승인 후 - 장비유형 업데이트
	public void updateType(EquipManageVO vo) throws Exception;
	
	//장비내역리스트
	public List<EquipManageVO> listEquip(Criteria cri) throws Exception;
	
	//장비내역리스트 페이징
	public int equipListCount() throws Exception;
	
	//반려 후 - 장비유형 업데이트
	public void updateReject(EquipManageVO vo) throws Exception;
	
	//반려내역리스트 - 사원일때
	public List<EquipManageVO> rejectList(Criteria cri) throws Exception;
	
	//반려내역리스트 - 팀장일때
	public List<EquipManageVO> rejectListLeader(Criteria cri) throws Exception;
	
	//반려내역리스트 페이징
	public int rejectListCount() throws Exception;
	
	//장비내역 상세페이지
	public Map<String, Object> equipDetailGET(int eno) throws Exception;
	
	//장비내역 추가구매/수리/폐기 - 수정하기
	public void equipUpdate(EquipManageVO vo) throws Exception;
	
	//수리중-> 정상 수정
	public void repairOk(EquipManageVO vo) throws Exception;
	
	//반려사유 가져오기
	public EquipManageVO getReject(int eno) throws Exception;
	
	//장비신청 상세페이지 수정 (사원)
	public void updateDetail(EquipManageVO vo) throws Exception;
	
	//반려내역- 확인 누르면 장비내역으로 복귀
	public void rejectBack(EquipManageVO vo) throws Exception;
	
	//유저번호 가져오기
	public int selectManager_no(int eno) throws Exception;
}
