package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.AuthVO;
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
		//비밀번호 암호화
		String pw = pwEncoder.encode(vo.getUser_pw());
		vo.setUser_pw(pw);
		
		edao.empJoin(vo);
	}

	@Override
	public void empAuth(AuthVO avo) throws Exception {
		edao.empAuth(avo);
	}
	
	//아이디 중복 체크
	@Override
	public int idCheck(String user_id) throws Exception {
		
		int res = edao.idCheck(user_id);

		return res;
		
	}

}
