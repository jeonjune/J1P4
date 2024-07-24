package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Inject
	private MemberDAO mDao;

	@Override
	public List<MemberVO> listPage(Criteria cri) throws Exception {
		logger.debug(" listPage(Criteria cri) 실행 ");
		return mDao.listPage(cri);
	}

	@Override
	public int getTotalCount() throws Exception {
		return mDao.getTotalCount();
	}

	@Override
	public MemberVO readMem(int mem_no) throws Exception {
		logger.debug(" (●'◡'●) Service : readMem(int mem_no) 실행 ");
		return mDao.readMem(mem_no);
	}

	@Override
	public void memJoin(MemberVO vo) throws Exception {
		mDao.memJoin(vo);
		
	}

	@Override
	public void memUpdate(MemberVO vo) throws Exception {
		mDao.memUpdate(vo);
		
	}

	
	
}
