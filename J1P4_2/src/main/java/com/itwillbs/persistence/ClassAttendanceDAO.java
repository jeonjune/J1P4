package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClassAttendanceVO;

@Repository
public class ClassAttendanceDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ClassAttendanceDAO.class);
	
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

    public ClassAttendanceVO getAttendanceByScheduleAndMember(int classSchedule_no, int mem_no) {
        Map<String, Integer> params = new HashMap<>();
        params.put("scheduleId", classSchedule_no);
        params.put("memNo", mem_no);
        ClassAttendanceVO attendance = sqlSession.selectOne(NAMESPACE + ".getAttendanceByScheduleAndMember", params);
        logger.info(attendance.toString());
        if (attendance == null) {
            throw new RuntimeException("Attendance record not found for scheduleId: " + classSchedule_no + ", memNo: " + mem_no);
        }
        return attendance;
    }

    
}
