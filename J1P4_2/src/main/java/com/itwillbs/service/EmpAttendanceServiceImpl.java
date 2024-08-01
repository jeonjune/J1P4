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
	
	

}
