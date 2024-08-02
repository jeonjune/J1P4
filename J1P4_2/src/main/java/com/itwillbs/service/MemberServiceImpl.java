package com.itwillbs.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.RegistrationVO;
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

	@Override
	public void memDelete(Map<String, List> mem_no) throws Exception {
		mDao.memDelete(mem_no);
	}

	@Override
	public List<MemberVO> memPhone(Map<String, List> mem_no) throws Exception {
		return mDao.memPhone(mem_no);
	}

	@Override
	public List<RecipientVO> selectSMS(Criteria cri) throws Exception {
		return mDao.selectSMS(cri);
	}

	@Override
	public int getTotalSMS() throws Exception {
		return mDao.getTotalSMS();
	}

	@Override
	public List<Map<String, Object>> countClass(int mem_no) throws Exception {
		return mDao.countClass(mem_no);
	}

	@Override
	public List<RegistrationVO> detailClass(Map<String, Object> vo) throws Exception {
		return mDao.detailClass(vo);
	}

	@Override
	public int getTotalDetailCount(Map<String, Object> vo) throws Exception {
		return mDao.getTotalDetailCount(vo);
	}

	
	

	
	
}