package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

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

@Repository
public class SearchDAOImpl implements SearchDAO {

	private static final Logger logger = LoggerFactory.getLogger(SearchDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.itwillbs.mapper.SearchMapper.";
	
	@Override
	public List<MemberVO> searchMem(Criteria cri) throws Exception {
	    return sqlSession.selectList(NAMESPACE + "searchMem", cri);
	    
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		logger.debug(" (⌐■_■) DAO : getTotalCount() 실행 ");
		return sqlSession.selectOne(NAMESPACE+"totalCount",cri);
	}

	@Override
	public List<EmployeeVO> searchEmp(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + "searchEmp", cri);
	}

	@Override
	public int getEmpCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalEmpCount",cri);
	}

	@Override
	public List<EquipManageVO> searchEquip(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + "searchEquip", cri);
	}

	@Override
	public int getEquipCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalEquipCount",cri);
	}

	@Override
	public List<FacilityManagementVO> searchFacility(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + "searchFacility", cri);
	}

	@Override
	public int getFacilityCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalFacilityCount",cri);
	}

	@Override
	public List<RecipientVO> searchMSG(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + "searchMSG", cri);
	}

	@Override
	public int getMSGCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalMSGCount",cri);
	}

	@Override
	public List<ClassVO> searchClass(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + "searchClass", cri);
	}

	@Override
	public int getClassCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalClassCount",cri);
	}

	@Override
	public List<ClassScheduleVO> searchClassDetail(Map<String, Object> search) throws Exception {
		return sqlSession.selectList(NAMESPACE + "searchClassDetail", search);
	}

	@Override
	public int getClassDetailCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalClassDetailCount",cri);
	}

	
	
	
}
