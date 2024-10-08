package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EmployeeVO;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.EquipmentVO;
import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.Filter;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.persistence.MemberDAO;
import com.itwillbs.persistence.SearchDAO;

@Service
public class SearchServiceImpl implements SearchService {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);
	
	@Inject
	private SearchDAO sDao;

	@Override
	public List<MemberVO> searchMem(Criteria cri) throws Exception {
		logger.debug(" (●'◡'●) Service : searchMem(Criteria cri) 실행 ");
		return sDao.searchMem(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		logger.debug(" (●'◡'●) Service : getTotalCount() 실행 ");
//		if(ObjectUtils.isEmpty( cri.getFilter())) {
//			for(Filter f:cri.getFilter()) {
//				f.getKey().equals("memYear");
//			}
//		}
		return sDao.getTotalCount(cri);
	}

	@Override
	public List<EmployeeVO> searchEmp(Criteria cri) throws Exception {
		return sDao.searchEmp(cri);
	}

	@Override
	public int getEmpCount(Criteria cri) throws Exception {
		return sDao.getEmpCount(cri);
	}

	@Override
	public List<EquipManageVO> searchEquip(Criteria cri) throws Exception {
		return sDao.searchEquip(cri);
	}

	@Override
	public List<EquipManageVO> searchEquipLeader(Criteria cri) throws Exception {
		return sDao.searchEquipLeader(cri);
	}

	@Override
	public int getEquipCount(Criteria cri) throws Exception {
		return sDao.getEquipCount(cri);
	}

	@Override
	public List<FacilityManagementVO> searchFacility(Criteria cri) throws Exception {
		return sDao.searchFacility(cri);
	}

	@Override
	public int getFacilityCount(Criteria cri) throws Exception {
		return sDao.getFacilityCount(cri);
	}

	@Override
	public List<RecipientVO> searchMSG(Criteria cri) throws Exception {
		return sDao.searchMSG(cri);
	}

	@Override
	public int getMSGCount(Criteria cri) throws Exception {
		return sDao.getMSGCount(cri);
	}

	@Override
	public List<ClassVO> searchClass(Criteria cri) throws Exception {
		return sDao.searchClass(cri);
	}

	@Override
	public int getClassCount(Criteria cri) throws Exception {
		return sDao.getClassCount(cri);
	}

	@Override
	public List<ClassScheduleVO> searchClassDetail(Map<String, Object> search) throws Exception {
		return sDao.searchClassDetail(search);
	}

	@Override
	public int getClassDetailCount(Criteria cri) throws Exception {
		return sDao.getClassDetailCount(cri);
	}
	
	
	

	
}
