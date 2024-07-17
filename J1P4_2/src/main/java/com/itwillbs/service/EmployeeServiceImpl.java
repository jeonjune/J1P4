package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.persistence.EmployeeDAO;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Inject
	private EmployeeDAO edao;

	@Override
	public void empJoin(EmployeeVO vo) {
		
	}
	
	

}
