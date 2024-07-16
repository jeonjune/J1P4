package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface MemberDAO {
	
	// 회원 리스트(ALL)
	public List<MemberVO> listAll() throws Exception;
	
	public List<MemberVO> listPage(int page) throws Exception;
	
	public List<MemberVO> listPage(Criteria cri) throws Exception;
	
	public int getTotalCount() throws Exception;
	
	
}
