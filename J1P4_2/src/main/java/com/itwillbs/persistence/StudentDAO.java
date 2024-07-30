package com.itwillbs.persistence;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.itwillbs.domain.MemberVO;

@Repository
public class StudentDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.itwillbs.mapper.StudentMapper";

    public List<MemberVO> searchStudents(String query) {
        return sqlSession.selectList(NAMESPACE + ".searchStudents", query);
    }

    public MemberVO getStudentById(int mem_no) {
        return sqlSession.selectOne(NAMESPACE + ".getStudentById", mem_no);
    }
}
