package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClassAttendanceVO;

@Repository
public class ClassAttendanceDAO {
    private static final String NAMESPACE = "com.itwillbs.mapper.ClassAttendanceMapper";

    @Autowired
    private SqlSession sqlSession;

    public void saveAttendance(ClassAttendanceVO attendance) {
        sqlSession.insert(NAMESPACE + ".saveAttendance", attendance);
    }

    public List<ClassAttendanceVO> getStudentsBySchedule(int scheduleId) {
        return sqlSession.selectList(NAMESPACE + ".getStudentsBySchedule", scheduleId);
    }

    public void updateAttendance(ClassAttendanceVO attendance) {
        sqlSession.update(NAMESPACE + ".updateAttendance", attendance);
    }

    public ClassAttendanceVO getAttendanceByScheduleAndMember(int classScheduleNo, int memNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("classScheduleNo", classScheduleNo);
        params.put("memNo", memNo);
        return sqlSession.selectOne("com.itwillbs.mapper.ClassAttendanceMapper.getAttendanceByScheduleAndMember", params);
    }

    
}
