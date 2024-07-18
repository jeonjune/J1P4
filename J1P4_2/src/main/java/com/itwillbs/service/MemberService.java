package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface MemberService {
		
	// 글 목록 조회(페이징처리)
	public List<MemberVO> listPage(Criteria cri) throws Exception;
	
	public int getTotalCount() throws Exception;
	
	// 회원 기본페이지
	public MemberVO readMem(int mem_no) throws Exception;
	
}
