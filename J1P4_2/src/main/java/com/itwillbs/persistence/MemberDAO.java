package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.HealthMonitorVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.fileVO;

public interface MemberDAO {
	
	// 회원 리스트
	
	public List<MemberVO> listPage(Criteria cri) throws Exception;
	
	public int getTotalCount() throws Exception;
	
	// 회원 기본페이지
	public Map<String, Object> readMem(int mem_no) throws Exception;
		
	// 회원 등록
	public void memJoin(MemberVO vo) throws Exception;

	// 회원 수정
	public void memUpdate(MemberVO vo) throws Exception;
	
	// 회원 삭제
	public void memDelete(Map<String, List> mem_no) throws Exception;
	
	// 회원 번호 조회
	public List<MemberVO> memPhone(Map<String, List> mem_no) throws Exception;
	
	// 메시지 조회
	public List<RecipientVO> selectSMS(Criteria cri) throws Exception;
	
	public int getTotalSMS() throws Exception;
	
	// 회원별 신청과목 개수 조회
	public List<Map<String, Object>> countClass(int mem_no) throws Exception;
	
	// 선택한 과목에 대한 상세내용 출력
	public List<RegistrationVO> detailClass(Map<String, Object> vo) throws Exception;
	
	// 상태별 과목 상세내용 개수
	public int getTotalDetailCount(Map<String, Object> vo) throws Exception;
	
	// 회원별 현재 수강중 강의와 수강신청 목록 출력
	public RegistrationVO memberClassStatus(Map<String, Object> vo) throws Exception;
	
	// 회원 건강 모니터링 출력
	public HealthMonitorVO getHealthMonitor(Map<String, Object> vo) throws Exception;
	
	//회원 신체변화 출력
	public List<Map<String, Object>> getChangeBody(int mem_no) throws Exception;
	
	// 회원 인바디 수정
	public void updateInbody(HealthMonitorVO vo) throws Exception;
	
	// 회원 인바디 등록
	public void insertInbody(HealthMonitorVO vo) throws Exception;
	
	// 회원 강의 누적 기간 출력
	public int countingMemClass(int mem_no) throws Exception;
	
	// 파일등록
	public void fileMemAdd(fileVO vo) throws Exception;
	
	//수신번호 가져오기
	public RecipientVO selectPhone(int noti_no) throws Exception;
		

}