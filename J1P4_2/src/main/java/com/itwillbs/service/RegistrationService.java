package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.persistence.RegistrationDAO;
import com.itwillbs.persistence.ClassDAO;

@Service
public class RegistrationService {

    @Autowired
    private RegistrationDAO registrationDAO;

    @Autowired
    private ClassDAO classDAO;

    public void registerStudent(RegistrationVO registration) {
        // 수강 신청할 클래스 정보를 가져옴
        ClassVO classVO = classDAO.getClassById(registration.getSchedule_no());

        // 현재 수강 인원이 최대 수강 인원 이상인지 확인
        if (classVO.getCurrentEnrollment() >= classVO.getMaxCapacity()) {
            throw new RuntimeException("Maximum capacity reached for this class.");
        }

        // 수강 신청 등록
        registrationDAO.registerStudent(registration);

        // 현재 수강 인원을 1 증가시킴
        classVO.setCurrentEnrollment(classVO.getCurrentEnrollment() + 1);
        classDAO.updateCurrentEnrollment(classVO);
    }
}
