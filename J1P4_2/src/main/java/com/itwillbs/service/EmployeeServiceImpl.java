package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.persistence.EmployeeDAO;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Inject
	private EmployeeDAO edao;
	
	@Inject
	private PasswordEncoder pwEncoder;

	@Override
	public List<EmployeeVO> empList() throws Exception {
		
		return edao.empList();
	}

	@Override
	public void empJoin(EmployeeVO vo) throws Exception {
		//encode(pw)
		// setUser_pw();
		edao.empJoin(vo);
	}
	
	

}
