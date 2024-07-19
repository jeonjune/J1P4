package com.itwillbs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.persistence.InstructorDAO;
import com.itwillbs.domain.InstructorVO;

@Service
public class InstructorService {

    @Autowired
    private InstructorDAO instructorDAO;

    public List<InstructorVO> searchInstructorsByName(String query) {
        return instructorDAO.findInstructorsByName(query);
    }
}
