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
import com.itwillbs.domain.fileVO;

@Repository
public class FileUploadDAOImpl implements FileUploadDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploadDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.FileUploadMapper.";

	@Override
	public void fileEmpAdd(fileVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"fileEmpAdd",vo);
	}

	@Override
	public void updateEmpFile(fileVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"updateEmpFile",vo);
	}

	
	

	
	
	
}
