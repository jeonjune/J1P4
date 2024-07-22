package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface SearchService {
	
	public List<MemberVO> searchMem(Criteria cri) throws Exception;
	
	public int getTotalCount(Criteria cri) throws Exception;
}
