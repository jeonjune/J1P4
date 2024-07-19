package com.itwillbs.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.InstructorVO;
import com.itwillbs.service.InstructorService;

@Controller
@RequestMapping("/instructors")
public class InstructorController {

    @Autowired
    private InstructorService instructorService;

    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<InstructorVO>> searchInstructors(@RequestParam("query") String query) {
        List<InstructorVO> instructors = instructorService.searchInstructorsByName(query);
        return ResponseEntity.ok(instructors);
    }
}
