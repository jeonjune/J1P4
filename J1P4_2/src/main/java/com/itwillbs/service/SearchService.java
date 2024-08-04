package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.EquipmentVO;
import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.MemberVO;

public interface SearchService {
	
	public List<MemberVO> searchMem(Criteria cri) throws Exception;
	
	public int getTotalCount(Criteria cri) throws Exception;
	
	public List<EmployeeVO> searchEmp(Criteria cri) throws Exception;
	
	public int getEmpCount(Criteria cri) throws Exception;
	
	public List<EquipManageVO> searchEquip(Criteria cri) throws Exception;
	
	public int getEquipCount(Criteria cri) throws Exception;
	
	public List<FacilityManagementVO> searchFacility(Criteria cri) throws Exception;
	
	public int getFacilityCount(Criteria cri) throws Exception;
}
