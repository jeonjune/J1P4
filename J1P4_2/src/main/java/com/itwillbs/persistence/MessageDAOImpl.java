package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NotificationVO;
import com.itwillbs.domain.RecipientVO;

@Repository
public class MessageDAOImpl implements MessageDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MessageDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.MessageMapper.";

	@Override
	public void insertMemSMS(RecipientVO rVO) throws Exception {
		sqlSession.insert(NAMESPACE+"insertMemSMS",rVO);
	}

	@Override
	public void insertMemReceiver(String receiver) throws Exception {
		sqlSession.insert(NAMESPACE+"insertMemReceiver",receiver);		
	}

	

	
	
	
}
