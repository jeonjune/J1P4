package com.itwillbs.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.itwillbs.domain.RegistrationVO;

@Repository
public class RegistrationDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.itwillbs.mapper.RegistrationMapper";

    public void registerStudent(RegistrationVO registration) {
        sqlSession.insert(NAMESPACE + ".registerStudent", registration);
    }
}
