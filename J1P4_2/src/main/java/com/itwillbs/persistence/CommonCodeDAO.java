package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.CommonCodeVO;
import com.itwillbs.domain.CommonCodeDetailVO;

@Repository
public class CommonCodeDAO {
    private static final String NAMESPACE = "com.itwillbs.mapper.CommonCodeMapper";

    @Autowired
    private SqlSession sqlSession;

    public List<CommonCodeVO> getAllCommonCodes() {
        return sqlSession.selectList(NAMESPACE + ".getAllCommonCodes");
    }

    public CommonCodeVO getCommonCodeById(String codeId) {
        return sqlSession.selectOne(NAMESPACE + ".getCommonCodeById", codeId);
    }

    public List<CommonCodeDetailVO> getCommonCodeDetailsByCodeId(String codeId) {
        return sqlSession.selectList(NAMESPACE + ".getCommonCodeDetailsByCodeId", codeId);
    }
}
