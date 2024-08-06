package com.itwillbs.persistence;

import com.itwillbs.domain.DailyAttendanceVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DailyAttendanceDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.itwillbs.mapper.ClassAttendanceMapper";

    public void saveDailyAttendance(DailyAttendanceVO dailyAttendance) {
        sqlSession.insert(NAMESPACE + ".saveDailyAttendance", dailyAttendance);
    }

    public List<DailyAttendanceVO> getDailyAttendanceByScheduleAndMember(int classSchedule_no, int mem_no) {
        return sqlSession.selectList(NAMESPACE + ".getDailyAttendanceByScheduleAndMember", new DailyAttendanceVO(classSchedule_no, mem_no));
    }

    public List<DailyAttendanceVO> getDailyAttendanceBySchedule(int scheduleId) {
        return sqlSession.selectList(NAMESPACE + ".getDailyAttendanceBySchedule", scheduleId);
    }
}
