package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.persistence.RegistrationDAO;
import com.itwillbs.persistence.ClassDAO;
import com.itwillbs.persistence.ClassScheduleDAO;

@Service
public class RegistrationService {

    @Autowired
    private RegistrationDAO registrationDAO;

    @Autowired
    private ClassDAO classDAO;
    
    @Autowired
    private ClassScheduleDAO classScheduleDAO;
    
    public void registerStudent(RegistrationVO registration) {
        // 수강 신청할 스케줄 정보를 가져옴
        ClassScheduleVO scheduleVO = classScheduleDAO.getScheduleById(registration.getSchedule_no());

        // 해당 스케줄의 클래스를 가져옴
        ClassVO classVO = classDAO.getClassById(scheduleVO.getClassNo());

        // 현재 수강 인원이 최대 수강 인원 이상인지 확인
        if (scheduleVO.getCurrentEnrollment() >= classVO.getMaxCapacity()) {
            throw new RuntimeException("Maximum capacity reached for this class.");
        }

        // 수강 신청 등록
        registrationDAO.registerStudent(registration);

        // 현재 수강 인원을 1 증가시킴
        scheduleVO.setCurrentEnrollment(scheduleVO.getCurrentEnrollment() + 1);
        classScheduleDAO.updateCurrentEnrollment(scheduleVO);
    }
}
