package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.EquipmentVO;
import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;

public interface SearchService {
	
	public List<MemberVO> searchMem(Criteria cri) throws Exception;
	
	public int getTotalCount(Criteria cri) throws Exception;
	
	public List<EmployeeVO> searchEmp(Criteria cri) throws Exception;
	
	public int getEmpCount(Criteria cri) throws Exception;
	
	public List<EquipManageVO> searchEquip(Criteria cri) throws Exception;
	
	public List<EquipManageVO> searchEquipLeader(Criteria cri) throws Exception;
	
	public int getEquipCount(Criteria cri) throws Exception;
	
	public List<FacilityManagementVO> searchFacility(Criteria cri) throws Exception;
	
	public int getFacilityCount(Criteria cri) throws Exception;
	
	public List<RecipientVO> searchMSG(Criteria cri) throws Exception;
	
	public int getMSGCount(Criteria cri) throws Exception;
	
	public List<ClassVO> searchClass(Criteria cri) throws Exception;
	
	public int getClassCount(Criteria cri) throws Exception;
	
	public List<ClassScheduleVO> searchClassDetail(Map<String, Object> search) throws Exception;
	
	public int getClassDetailCount(Criteria cri) throws Exception;
	
}
