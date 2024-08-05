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
import com.itwillbs.domain.fileVO;
import com.itwillbs.persistence.FileUploadDAO;
import com.itwillbs.persistence.MemberDAO;
import com.itwillbs.persistence.MessageDAO;

@Service
public class FileUploadServiceImpl implements FileUploadService {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploadServiceImpl.class);
	
	@Inject
	private FileUploadDAO fDao;

	@Override
	public void fileEmpAdd(fileVO vo) throws Exception {
		fDao.fileEmpAdd(vo);
	}



	
}
