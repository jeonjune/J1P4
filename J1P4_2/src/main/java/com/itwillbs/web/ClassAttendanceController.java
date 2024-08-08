package com.itwillbs.web;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
import com.itwillbs.domain.Criteria;
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
    public String attendancePage(Model model,Criteria cri) {
        List<ClassVO> classes = classService.getAllClasses(cri);
        model.addAttribute("classes", classes);
        return "class/attendance";
    }

    @GetMapping("/schedules/{classNo}")
    @ResponseBody
    public ResponseEntity<List<ClassScheduleVO>> getSchedulesByClass(@PathVariable("classNo") int classNo) {
        List<ClassScheduleVO> schedules = classScheduleService.getNormalSchedulesByClassId(classNo); // '정상' 상태의 스케줄만 가져옴
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
        // 현재 날짜와 요일 확인
        LocalDate today = LocalDate.now();
        String todayDayOfWeek = today.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);

        // 스케줄 상태 확인
        ClassScheduleVO schedule = classScheduleService.getScheduleById(dailyAttendance.getClassSchedule_no());
        if (schedule != null && "정상".equals(schedule.getStatus()) && schedule.getRecurrenceDays().contains(todayDayOfWeek)) {
            // Daily Attendance 저장
            dailyAttendance.setAttendance_date(java.sql.Date.valueOf(today));
            try {
                dailyAttendanceService.saveDailyAttendance(dailyAttendance);
            } catch (Exception e) {
                // 중복 예외 처리
                if (e.getCause() != null && e.getCause().getClass().getSimpleName().equals("SQLIntegrityConstraintViolationException")) {
                    return ResponseEntity.status(409).body("already_checked");
                }
                return ResponseEntity.status(500).body("error");
            }
            
            // 출석 수 증가
            classAttendanceService.incrementAttendance(dailyAttendance.getClassSchedule_no(), dailyAttendance.getMem_no());

            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.status(403).body("출석 체크 조건을 만족하지 않습니다.");
        }
    }

    @GetMapping("/daily-attendance/{mem_no}/{scheduleId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> viewDailyAttendance(@PathVariable("mem_no") int memNo, @PathVariable("scheduleId") int scheduleId) {
        List<DailyAttendanceVO> dailyAttendanceList = dailyAttendanceService.getDailyAttendanceByScheduleAndMember(scheduleId, memNo);
        ClassAttendanceVO classAttendance = classAttendanceService.getAttendanceByScheduleAndMember(scheduleId, memNo);
        
        Map<String, Object> response = new HashMap<>();
        response.put("dailyAttendanceList", dailyAttendanceList);
        response.put("classAttendance", classAttendance);
        
        return ResponseEntity.ok(response);
    }



}
