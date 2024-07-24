package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface MemberDAO {
	
	// 회원 리스트
	
	public List<MemberVO> listPage(Criteria cri) throws Exception;
	
	public int getTotalCount() throws Exception;
	
	// 회원 기본페이지
	public MemberVO readMem(int mem_no) throws Exception;
	
	// 회원 등록
	public void memJoin(MemberVO vo) throws Exception;

	// 회원 수정
	public void memUpdate(MemberVO vo) throws Exception;
	
	
}
