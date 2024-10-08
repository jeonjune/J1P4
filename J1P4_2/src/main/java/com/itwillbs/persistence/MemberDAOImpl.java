package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.HealthMonitorVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.fileVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MemberMapper.";

	@Override
	public List<MemberVO> listPage(Criteria cri) throws Exception {
		logger.debug(" listPage(Criteria cri) 실행 ");
		
		return sqlSession.selectList(NAMESPACE+"listPage2",cri);
	}

	@Override
	public int getTotalCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalCount");
	}

	@Override
	public Map<String, Object> readMem(int mem_no) throws Exception {
		logger.debug(" (⌐■_■) DAO : readMem(int mem_no) 실행 ");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("MemberVO",sqlSession.selectOne(NAMESPACE+"readMem", mem_no));
		resultMap.put("fileVO",sqlSession.selectOne(NAMESPACE+"selectMemFile", mem_no));
		
		return resultMap;
		
		
	}

	@Override
	public void memJoin(MemberVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"memJoin", vo);
		
	}

	@Override
	public void memUpdate(MemberVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"memUpdate", vo);
		
	}

	@Override
	public void memDelete(Map<String, List> mem_no) throws Exception {
		sqlSession.update(NAMESPACE+"memDelete", mem_no);
	}

	@Override
	public List<MemberVO> memPhone(Map<String, List> mem_no) throws Exception {
		return sqlSession.selectList(NAMESPACE+"memPhone",mem_no);
	}

	@Override
	public List<RecipientVO> selectSMS(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE+"selectSMS",cri);
	}

	@Override
	public int getTotalSMS() throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalSMS");
	}

	@Override
	public List<Map<String, Object>> countClass(int mem_no) throws Exception {
		return sqlSession.selectList(NAMESPACE+"countClass",mem_no);
	}

	@Override
	public List<RegistrationVO> detailClass(Map<String, Object> vo) throws Exception {
		return sqlSession.selectList(NAMESPACE+"detailClass",vo);
	}

	@Override
	public int getTotalDetailCount(Map<String, Object> vo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalDetailClass",vo);
	}

	@Override
	public RegistrationVO memberClassStatus(Map<String, Object> vo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"detailClass",vo);
	}

	@Override
	public HealthMonitorVO getHealthMonitor(Map<String, Object> vo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"getHealthMonitor",vo);
	}

	@Override
	public List<Map<String, Object>> getChangeBody(int mem_no) throws Exception {
		return sqlSession.selectList(NAMESPACE+"getChangeBody",mem_no);
	}

	@Override
	public void updateInbody(HealthMonitorVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"updateInbody",vo);
	}

	@Override
	public void insertInbody(HealthMonitorVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"insertInbody",vo);
	}

	@Override
	public int countingMemClass(int mem_no) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"countingMemClass",mem_no);
	}

	@Override
	public void fileMemAdd(fileVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"fileMemAdd",vo);
	}

	@Override
	public RecipientVO selectPhone(int noti_no) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"selectPhone",noti_no);
	}
	
	//이메일 유효성 중복 체크
	@Override
	public int emailCheck(String mem_email) throws Exception {
		int result = sqlSession.selectOne(NAMESPACE+"emailCheck", mem_email);
		return result;
	}
	
	//전화번호 중복 체크
	@Override
	public int phoneCheck(String mem_phone) throws Exception {
		int result = sqlSession.selectOne(NAMESPACE+"phoneCheck", mem_phone);
		return result;
	}
	
	
	
	
	
	
	
}