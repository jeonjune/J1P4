package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;
import com.itwillbs.persistence.SearchDAO;

@Service
public class SearchServiceImpl implements SearchService {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);
	
	@Inject
	private SearchDAO sDao;

	@Override
	public List<MemberVO> searchMem(Criteria cri) throws Exception {
		logger.debug(" (●'◡'●) Service : searchMem(Criteria cri) 실행 ");
		return sDao.searchMem(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		logger.debug(" (●'◡'●) Service : getTotalCount() 실행 ");
		return sDao.getTotalCount(cri);
	}
	
	

	
}
