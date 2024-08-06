package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.persistence.ClassScheduleDAO;
import com.itwillbs.domain.ClassScheduleVO;

@Service
public class ClassScheduleService {

    @Autowired
    private ClassScheduleDAO classScheduleDAO;

    public void saveSchedule(ClassScheduleVO scheduleVO) {
        classScheduleDAO.saveSchedule(scheduleVO);
    }

    public List<ClassScheduleVO> getSchedulesByClassId(int classNo) {
        return classScheduleDAO.getSchedulesByClassId(classNo);
    }

    public ClassScheduleVO getScheduleById(int scheduleId) {
        return classScheduleDAO.getScheduleById(scheduleId);
    }

    public void deleteSchedule(int scheduleId) {
        classScheduleDAO.deleteSchedule(scheduleId);
    }
}
