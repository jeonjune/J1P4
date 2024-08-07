package com.itwillbs.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.HealthMonitorVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.fileVO;
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
	public Map<String, Object> readMem(int mem_no) throws Exception {
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

	@Override
	public RegistrationVO memberClassStatus(Map<String, Object> vo) throws Exception {
		return mDao.memberClassStatus(vo);
	}

	@Override
	public HealthMonitorVO getHealthMonitor(Map<String, Object> vo) throws Exception {
		return mDao.getHealthMonitor(vo);
	}

	@Override
	public List<Map<String, Object>> getChangeBody(int mem_no) throws Exception {
		return mDao.getChangeBody(mem_no);
	}

	@Override
	public void updateInbody(HealthMonitorVO vo) throws Exception {
		mDao.updateInbody(vo);
	}

	@Override
	public void insertInbody(HealthMonitorVO vo) throws Exception {
		mDao.insertInbody(vo);
	}

	@Override
	public int countingMemClass(int mem_no) throws Exception {
		return mDao.countingMemClass(mem_no);
	}

	@Override
	public void fileMemAdd(fileVO vo) throws Exception {
		mDao.fileMemAdd(vo);
	}

	@Override
	public RecipientVO selectPhone(int noti_no) throws Exception {
		return mDao.selectPhone(noti_no);
	}
	
	//이메일 유효성 중복 검사 
	@Override
	public int emailCheck(String mem_email) throws Exception {
		int result = mDao.emailCheck(mem_email);
		return result;
	}
	
	//전화번호 중복 검사 
	@Override
	public int phoneCheck(String mem_phone) throws Exception {
		int result = mDao.phoneCheck(mem_phone);
		return result;
	}
	
	
	
	

	
	
}