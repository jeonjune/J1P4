package com.itwillbs.service;

import com.itwillbs.domain.DailyAttendanceVO;
import com.itwillbs.persistence.DailyAttendanceDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DailyAttendanceService {

    @Autowired
    private DailyAttendanceDAO dailyAttendanceDAO;

    public void saveDailyAttendance(DailyAttendanceVO dailyAttendance) {
        dailyAttendanceDAO.saveDailyAttendance(dailyAttendance);
    }

    public List<DailyAttendanceVO> getDailyAttendanceBySchedule(int scheduleId) {
        return dailyAttendanceDAO.getDailyAttendanceBySchedule(scheduleId);
    }

    public List<DailyAttendanceVO> getDailyAttendanceByScheduleAndMember(int scheduleId, int memNo) {
        return dailyAttendanceDAO.getDailyAttendanceByScheduleAndMember(scheduleId, memNo);
    }
    
    public void recordAttendance(int studentId, int classScheduleId) {
        DailyAttendanceVO dailyAttendance = new DailyAttendanceVO(classScheduleId, studentId);
        dailyAttendance.setAttendance_date(new java.sql.Date(System.currentTimeMillis()));
        dailyAttendanceDAO.saveDailyAttendance(dailyAttendance);
    }
}
