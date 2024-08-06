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
import com.itwillbs.domain.NotificationVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.persistence.MemberDAO;
import com.itwillbs.persistence.MessageDAO;

@Service
public class MessageServiceImpl implements MessageService {
	
	private static final Logger logger = LoggerFactory.getLogger(MessageServiceImpl.class);
	
	@Inject
	private MessageDAO smsDao;

	@Override
	public void insertMemSMS(RecipientVO rVO) throws Exception {
		smsDao.insertMemSMS(rVO);
	}

	@Override
	public void insertMemReceiver(String receiver) throws Exception {
		smsDao.insertMemReceiver(receiver);
	}


	
}
