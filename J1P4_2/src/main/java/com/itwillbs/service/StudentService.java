package com.itwillbs.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.StudentDAO;

@Service
public class StudentService {

    @Autowired
    private StudentDAO studentDAO;

    public List<MemberVO> searchStudents(String query) {
        return studentDAO.searchStudents(query);
    }

    public MemberVO getStudentById(int mem_no) {
        return studentDAO.getStudentById(mem_no);
    }
}
