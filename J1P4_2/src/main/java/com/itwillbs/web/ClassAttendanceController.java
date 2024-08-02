package com.itwillbs.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.domain.ClassAttendanceVO;
import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.service.ClassAttendanceService;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.ClassService;

@Controller
@RequestMapping("/attendance")
public class ClassAttendanceController {

	@Autowired
    private ClassService classService;

    @Autowired
    private ClassScheduleService classScheduleService;

    @Autowired
    private ClassAttendanceService classAttendanceService;

	private static final Logger logger = LoggerFactory.getLogger(ClassAttendanceController.class);
    
    @GetMapping("/list")
    public String attendancePage(Model model) {
        List<ClassVO> classes = classService.getAllClasses();
        model.addAttribute("classes", classes);
        return "class/attendance";
    }

    @GetMapping("/schedules/{classNo}")
    @ResponseBody
    public ResponseEntity<List<ClassScheduleVO>> getSchedulesByClass(@PathVariable("classNo") int classNo) {
        List<ClassScheduleVO> schedules = classScheduleService.getSchedulesByClassId(classNo);
        logger.info(schedules.toString());
        return ResponseEntity.ok(schedules);
    }

    @GetMapping("/students/{scheduleId}")
    @ResponseBody
    public ResponseEntity<List<ClassAttendanceVO>> getStudentsBySchedule(@PathVariable("scheduleId") int scheduleId) {
        List<ClassAttendanceVO> students = classAttendanceService.getStudentsBySchedule(scheduleId);
        logger.info(students.toString());
        return ResponseEntity.ok(students);
    }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateAttendance(@RequestParam("classSchedule_no") int classSchedule_no,
                                                   @RequestParam("mem_no") int memNo,
                                                   @RequestParam("attendedClasses") int attendedClasses,
                                                   @RequestParam("totalClasses") int totalClasses) {
        ClassAttendanceVO attendance = new ClassAttendanceVO();
        attendance.setClassSchedule_no(classSchedule_no);
        attendance.setMem_no(memNo);
        attendance.setAttendedClasses(attendedClasses);
        attendance.setTotalClasses(totalClasses);
        classAttendanceService.updateAttendance(attendance);
        return ResponseEntity.ok("success");
    }
}
