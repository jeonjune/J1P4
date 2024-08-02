package com.itwillbs.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.RegistrationVO;

public interface MemberService {
		
	// 글 목록 조회(페이징처리)
	public List<MemberVO> listPage(Criteria cri) throws Exception;
	
	public int getTotalCount() throws Exception;
	
	// 회원 기본페이지
	public MemberVO readMem(int mem_no) throws Exception;
	
	// 회원등록
	public void memJoin(MemberVO vo) throws Exception;
	
	// 회원 수정
	public void memUpdate(MemberVO vo) throws Exception;
	
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
}