package com.itwillbs.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ClassAttendanceVO;
import com.itwillbs.persistence.ClassAttendanceDAO;

@Service
public class ClassAttendanceService {
	

	private static final Logger logger = LoggerFactory.getLogger(ClassAttendanceService.class);
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
    
    public void incrementAttendance(int classScheduleId, int memNo) {
        ClassAttendanceVO attendance = classAttendanceDAO.getAttendanceByScheduleAndMember(classScheduleId, memNo);
        if (attendance != null) {
            attendance.setAttendedClasses(attendance.getAttendedClasses() + 1);
            classAttendanceDAO.updateAttendance(attendance);
        }
    }
}
