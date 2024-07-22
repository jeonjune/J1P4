package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;

public interface SearchDAO {

	public List<MemberVO> searchMem(Criteria cri) throws Exception;
	
	public int getTotalCount(Criteria cri) throws Exception;
	
}
