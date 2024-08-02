package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.persistence.EmpAttendanceDAO;

@Service
public class EmpAttendanceServiceImpl implements EmpAttendanceService {
	
	@Inject
	private EmpAttendanceDAO edao;

	@Override
	public List<EmpAttendanceVO> getCalendar() throws Exception {
		return edao.getCalendar();
	}

	@Override
	public void vacation(EmpAttendanceVO vo) throws Exception {
		edao.vacation(vo);
		
	}

	@Override
	public List<EmpAttendanceVO> reqVaca() throws Exception {
		return edao.reqVaca();
	}

	@Override
	public List<EmpAttendanceVO> yVaca() throws Exception {
		return edao.yVaca();
	}

	@Override
	public List<EmpAttendanceVO> nVaca() throws Exception {
		return edao.nVaca();
	}

	@Override
	public void reVaca(EmpAttendanceVO vo) throws Exception {
		edao.reVaca(vo);
		
	}

	@Override
	public void yVa(int empAttend_no) throws Exception {
		edao.yVa(empAttend_no);
	}

	@Override
	public String getName(int user_no) throws Exception {
		return edao.getName(user_no);
	}

	@Override
	public List<EmpAttendanceVO> myVaca(int user_no) throws Exception {
		return edao.myVaca(user_no);
	}
	
	
	
	

}
