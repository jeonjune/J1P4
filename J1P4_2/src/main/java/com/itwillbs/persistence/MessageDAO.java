package com.itwillbs.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NotificationVO;
import com.itwillbs.domain.RecipientVO;

public interface MessageDAO {
	
	// 회원 리스트
	
	public void insertMemSMS(RecipientVO rVO) throws Exception;
	
	public void insertMemReceiver(String receiver) throws Exception;
	

}
