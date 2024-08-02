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
        if (scheduleVO.getScheduleId() == 0) {
            sqlSession.insert(NAMESPACE + ".insertSchedule", scheduleVO);
        } else {
            sqlSession.update(NAMESPACE + ".updateSchedule", scheduleVO);
        }
    }

    public List<ClassScheduleVO> getSchedulesByClassId(int classNo) {
        return sqlSession.selectList(NAMESPACE + ".getSchedulesByClassId", classNo);
    }

    public ClassScheduleVO getScheduleById(int scheduleId) {
        return sqlSession.selectOne(NAMESPACE + ".getScheduleById", scheduleId);
    }

    public void deleteSchedule(int scheduleId) {
        sqlSession.delete(NAMESPACE + ".deleteSchedule", scheduleId);
    }
    
    public void updateCurrentEnrollment(ClassScheduleVO schedule) {
        sqlSession.update(NAMESPACE + ".updateCurrentEnrollment", schedule);
    }
    
    public List<ClassScheduleVO> getAllSchedules() {
        return sqlSession.selectList(NAMESPACE + ".getAllSchedules");
    }

    public void updateScheduleStatus(ClassScheduleVO schedule) {
        sqlSession.update(NAMESPACE + ".updateScheduleStatus", schedule);
    }
    
    // 새로운 메소드 추가
    public List<ClassScheduleVO> getRecruitmentSchedules() {
        return sqlSession.selectList(NAMESPACE + ".getRecruitmentSchedules");
    }
}
