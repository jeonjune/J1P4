package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.fileVO;

@Repository
public class EquipManageDAOImpl implements EquipManageDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.itwillbs.mapper.equipmentMapper.";

	
	//장비신청페이지
	@Override
	public void equipAdd(EquipManageVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"equipAdd", vo);
		
	}
	


	//장비신청내역 리스트 - 사원
	@Override
	public List<EquipManageVO> equipList(int manager_no) throws Exception {
		return sqlSession.selectList(NAMESPACE+"equipList",manager_no);
		
	}
	
	//장비신청내역 리스트 - 팀장
	@Override
	public List<EquipManageVO> equipList() throws Exception {
		return sqlSession.selectList(NAMESPACE+"equipLeaderList");
	}


	//특정 장비신청 상세페이지 조회
	@Override
	public Map<String, Object> equipDetail(int eno) throws Exception {
		
		Map<String, Object> resrultMap = new HashMap<String, Object>();
		resrultMap.put("EquipManageVO",sqlSession.selectOne(NAMESPACE+"equipDetail", eno));
		resrultMap.put("fileVO",sqlSession.selectOne(NAMESPACE+"selectFile", eno));
		
		return resrultMap;
	}

	//파일등록
	@Override
	public void fileAdd(fileVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+"fileAdd", vo);
	}
	
	//승인 후 - 장비유형 업데이트
	@Override
	public void updateType(EquipManageVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"updateType", vo);
		
	}
	
	//장비내역리스트
	@Override
	public List<EquipManageVO> listEquip(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE+"listEquip",cri);
	}

	//장비내역리스트 페이징
	@Override
	public int equipListCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE+"equipListCount");
	}

	//반려 후 - 장비유형 업데이트
	@Override
	public void updateReject(EquipManageVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"updateReject", vo);
	}
	
	//반려내역리스트 - 사원일때
	@Override
	public List<EquipManageVO> rejectList(Criteria cri) throws Exception {
		
		return sqlSession.selectList(NAMESPACE+"rejectList",cri);
	}
	
	
	//반려내역리스트 - 팀장일때
	@Override
	public List<EquipManageVO> rejectListLeader(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE+"rejectListLeader", cri);
	}



	//반려내역리스트 페이징
	@Override
	public int rejectListCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE+"rejectListCount");
	}
	
	//장비내역 상세페이지
	@Override
	public Map<String, Object> equipDetailGET(int eno) throws Exception {
		Map<String, Object> resrultMap = new HashMap<String, Object>();
		resrultMap.put("EquipManageVO",sqlSession.selectOne(NAMESPACE+"equipDetailGet", eno));
		resrultMap.put("fileVO",sqlSession.selectOne(NAMESPACE+"selectFile", eno));
		
		return resrultMap; 
		
	}

	//장비내역 추가구매/수리/폐기 - 수정하기
	@Override
	public void equipUpdate(EquipManageVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"equipUpdate", vo);
	}

	//수리중-> 정상 수정
	@Override
	public void repairOk(EquipManageVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"repairOk", vo);
	}
	
	//반려사유 가져오기
	@Override
	public EquipManageVO getReject(int eno) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"getReject", eno);
	}
	
	//장비신청 상세페이지 수정 (사원)
	@Override
	public void updateDetail(EquipManageVO vo) throws Exception {
		sqlSession.update(NAMESPACE+"updateDetail", vo);
	}

	//반려내역- 확인 누르면 장비내역으로 복귀
	@Override
	public void rejectBack(EquipManageVO vo) throws Exception {
	sqlSession.update(NAMESPACE+"rejectBack", vo);
		
	}


	//유저번호 가져오기
	@Override
	public int selectManager_no(int eno) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"selectManager_no", eno);
	}
	
	
	
	
	
	
	
	
	
	

}
