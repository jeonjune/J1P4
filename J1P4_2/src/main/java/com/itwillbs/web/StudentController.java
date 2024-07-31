package com.itwillbs.web;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.service.StudentService;
import com.itwillbs.service.RegistrationService;

@Controller
@RequestMapping("/students/*")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private RegistrationService registrationService;

    @GetMapping("/search")
    @ResponseBody
    public List<MemberVO> searchStudents(@RequestParam("query") String query) {
        return studentService.searchStudents(query);
    }

    @GetMapping("/detail/{id}")
    public String getStudentById(@PathVariable("id") int mem_no, Model model) {
        MemberVO student = studentService.getStudentById(mem_no);
        model.addAttribute("student", student);
        return "student/studentDetail"; // JSP 파일 경로
    }

    @PostMapping("/register")
    @ResponseBody
    public String registerStudent(@RequestBody List<RegistrationVO> registrations) {
        for (RegistrationVO registration : registrations) {
            registration.setRegistration_date(new java.sql.Date(System.currentTimeMillis()));
            registrationService.registerStudent(registration);
        }
        return "Success";
    }
}
