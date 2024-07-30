package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.persistence.RegistrationDAO;

@Service
public class RegistrationService {

    @Autowired
    private RegistrationDAO registrationDAO;

    public void registerStudent(RegistrationVO registration) {
        registrationDAO.registerStudent(registration);
    }
}
