package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.AuthVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.persistence.EmployeeDAO;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Inject
	private EmployeeDAO edao;
	
	@Inject
	private PasswordEncoder pwEncoder;

	@Override
	public List<EmployeeVO> empList(Criteria cri) throws Exception {
		
		return edao.empList(cri);
	}
	
	@Override
	public int getTotalEmpCount() throws Exception {
		return edao.getTotalEmpCount();
	}


	@Override
	public void empJoin(EmployeeVO vo) throws Exception {
		//비밀번호 암호화
		if(!vo.getUser_pw().equals(null)) {
			String pw = pwEncoder.encode(vo.getUser_pw());
			vo.setUser_pw(pw);			
		}
		
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

	@Override
	public int user_no(String user_id) throws Exception {
		int user_no = edao.user_no(user_id);
		return user_no;
	}

	@Override
	public void workStart(EmpAttendanceVO vo) throws Exception {
		edao.workStart(vo);
		
	}

	@Override
	public String checkWork(int user_no) throws Exception {
		return edao.checkWork(user_no);
	}

	@Override
	public void endWork(int user_no) throws Exception {
		edao.endWork(user_no);
	}

	@Override
	public void outWork(int user_no) throws Exception {
		edao.outWork(user_no);
		
	}

	@Override
	public void inWork(int user_no) throws Exception {
		edao.inWork(user_no);
		
	}

	@Override
	public Map<String, Object> empDetail(int user_no) throws Exception {
		
		return edao.empDetail(user_no);
	}

	@Override
	public void empUpdate(EmployeeVO vo) throws Exception {
		//비밀번호 암호화
//		String pw = pwEncoder.encode(vo.getUser_pw());
//		vo.setUser_pw(pw);
		edao.empUpdate(vo);
	}

	@Override
	public void myUpdate(EmployeeVO vo) throws Exception {
		//비밀번호 암호화
		String pw = pwEncoder.encode(vo.getUser_pw());
		vo.setUser_pw(pw);
		edao.empUpdate(vo);
	}

	@Override
	public void authUpdate(AuthVO vo) throws Exception {
		edao.authUpdate(vo);
	}

	@Override
	public void reEmp(String user_id) throws Exception {
		edao.reEmp(user_id);
	}

	@Override
	public List<EmpAttendanceVO> monthWork(int user_no) throws Exception {
		return edao.monthWork(user_no);
	}

	@Override
	public Integer countLate(int user_no) throws Exception {
		return edao.countLate(user_no);
	}

	@Override
	public Integer countVa(int user_no) throws Exception {
		return edao.countVa(user_no);
	}

	@Override
	public Integer countHalf(int user_no) throws Exception {
		return edao.countHalf(user_no);
	}

	@Override
	public Integer yearCountVa(int user_no) throws Exception {
		return edao.yearCountVa(user_no);
	}

	@Override
	public Integer yearCountHalf(int user_no) throws Exception {
		return edao.yearCountHalf(user_no);
	}

	@Override
	public Integer countAtt(int user_no) throws Exception {
		return edao.countAtt(user_no);
	}

	@Override
	public Integer appCount(int user_no) throws Exception {
		return edao.appCount(user_no);
	}

	@Override
	public Integer appHCount(int user_no) throws Exception {
		return edao.appHCount(user_no);
	}
	
	
	
	
	
	

}
