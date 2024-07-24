package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClassScheduleVO;

@Repository
public class ClassScheduleDAO {
    private static final String NAMESPACE = "com.itwillbs.mapper.ClassScheduleMapper";

    @Autowired
    private SqlSession sqlSession;

    public void saveSchedule(ClassScheduleVO scheduleVO) {
        sqlSession.insert(NAMESPACE + ".saveSchedule", scheduleVO);
    }

    public List<ClassScheduleVO> getSchedulesByClassId(int classNo) {
        return sqlSession.selectList(NAMESPACE + ".getSchedulesByClassId", classNo);
    }
}
