package com.itwillbs.web;

import java.util.List;
import java.util.Date;
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
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.service.StudentService;
import com.itwillbs.service.RegistrationService;
import com.itwillbs.service.PaymentService;
import com.itwillbs.domain.RegistrationPaymentRequest;

@Controller
@RequestMapping("/students/*")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private PaymentService paymentService;

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
    public String registerStudent(@RequestBody RegistrationPaymentRequest request) {
        System.out.println("Received request: " + request);

        RegistrationVO registration = request.getRegistration();
        if (registration == null) {
            throw new NullPointerException("Registration data is null");
        }

        registration.setRegistration_date(new java.sql.Date(System.currentTimeMillis()));
        registrationService.registerStudent(registration);
        
        System.out.println("Registration No: " + registration.getRegistration_no());
        if (registration.getRegistration_no() == null) {
            throw new NullPointerException("Registration number is null after registration");
        }

        PaymentVO payment = request.getPaymentInfo();
        if (payment == null) {
            throw new NullPointerException("Payment data is null");
        }

        payment.setRegistrationNo(registration.getRegistration_no()); // 적절한 값 설정
        payment.setPaymentDate(new java.sql.Date(System.currentTimeMillis()));
        paymentService.savePayment(payment);

        return "Success";
    }
}
