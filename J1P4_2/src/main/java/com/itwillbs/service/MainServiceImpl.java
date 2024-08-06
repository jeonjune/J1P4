package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.fileVO;
import com.itwillbs.persistence.MainDAO;

@Service
public class MainServiceImpl implements MainService {
	
	@Inject
	private MainDAO mdao;

	@Override
	public EmployeeVO logInfo(String user_id) throws Exception {
		return mdao.logInfo(user_id);
	}

	@Override
	public fileVO logPic(String user_id) throws Exception {
		return mdao.logPic(user_id);
	}
	
	
	

}
