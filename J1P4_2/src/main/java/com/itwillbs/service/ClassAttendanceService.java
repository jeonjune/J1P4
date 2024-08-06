package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ClassAttendanceVO;
import com.itwillbs.persistence.ClassAttendanceDAO;

@Service
public class ClassAttendanceService {

    @Autowired
    private ClassAttendanceDAO classAttendanceDAO;

    public List<ClassAttendanceVO> getStudentsBySchedule(int scheduleId) {
        return classAttendanceDAO.getStudentsBySchedule(scheduleId);
    }

    public ClassAttendanceVO getAttendanceByScheduleAndMember(int scheduleId, int memNo) {
        return classAttendanceDAO.getAttendanceByScheduleAndMember(scheduleId, memNo);
    }

    public void updateAttendance(ClassAttendanceVO attendance) {
        classAttendanceDAO.updateAttendance(attendance);
    }
    
}
