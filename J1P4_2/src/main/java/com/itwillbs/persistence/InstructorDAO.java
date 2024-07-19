package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.InstructorVO;

@Repository
public class InstructorDAO {

    private static final String NAMESPACE = "com.itwillbs.mapper.InstructorMapper";

    @Autowired
    private SqlSession sqlSession;

    public List<InstructorVO> findInstructorsByName(String query) {
        return sqlSession.selectList(NAMESPACE + ".findInstructorsByName", query);
    }
}
