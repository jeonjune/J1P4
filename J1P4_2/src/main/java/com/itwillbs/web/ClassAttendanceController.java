package com.itwillbs.web;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
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
import com.itwillbs.domain.DailyAttendanceVO;
import com.itwillbs.service.ClassAttendanceService;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.ClassService;
import com.itwillbs.service.DailyAttendanceService;

@Controller
@RequestMapping("/attendance")
public class ClassAttendanceController {

	@Autowired
    private ClassService classService;

    @Autowired
    private ClassScheduleService classScheduleService;

    @Autowired
    private ClassAttendanceService classAttendanceService;
    
    @Autowired
    private DailyAttendanceService dailyAttendanceService;

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
    
    @GetMapping("/daily-check/{scheduleId}")
    @ResponseBody
    public ResponseEntity<List<ClassAttendanceVO>> getDailyAttendance(@PathVariable("scheduleId") int scheduleId) {
        List<ClassAttendanceVO> students = classAttendanceService.getStudentsBySchedule(scheduleId);
        return ResponseEntity.ok(students);
    }


    @PostMapping("/daily-check/update")
    @ResponseBody
    public ResponseEntity<String> updateDailyAttendance(@RequestBody DailyAttendanceVO dailyAttendance) {
        dailyAttendance.setAttendance_date(java.sql.Date.valueOf(LocalDate.now())); // Ensure correct date format
        dailyAttendanceService.saveDailyAttendance(dailyAttendance);
        return ResponseEntity.ok("success");
    }

    @GetMapping("/daily-attendance/{mem_no}/{scheduleId}")
    public String viewDailyAttendance(@PathVariable("mem_no") int memNo, @PathVariable("scheduleId") int scheduleId, Model model) {
        List<DailyAttendanceVO> dailyAttendanceList = dailyAttendanceService.getDailyAttendanceByScheduleAndMember(scheduleId, memNo);
        model.addAttribute("dailyAttendanceList", dailyAttendanceList);
        return "class/daily-attendance";
    }
    

}
