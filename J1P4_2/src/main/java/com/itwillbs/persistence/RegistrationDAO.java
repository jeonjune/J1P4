package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.RegistrationVO;

@Repository
public class RegistrationDAO {
    private static final String NAMESPACE = "com.itwillbs.mapper.RegistrationMapper";

    @Autowired
    private SqlSession sqlSession;

    public void registerStudent(RegistrationVO registration) {
        sqlSession.insert(NAMESPACE + ".registerStudent", registration);
    }

    public List<RegistrationVO> getStudentsBySchedule(int scheduleId) {
        return sqlSession.selectList(NAMESPACE + ".getStudentsBySchedule", scheduleId);
    }
}
