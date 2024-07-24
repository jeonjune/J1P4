package com.itwillbs.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.CommonCodeService;

@Controller
@RequestMapping("/schedules/*")
public class ClassScheduleController {

    @Autowired
    private ClassScheduleService classScheduleService;

    @Autowired
    private CommonCodeService commonCodeService;

    @GetMapping("/list/{classNo}")
    public String listSchedules(@PathVariable("classNo") int classNo, Model model) {
        model.addAttribute("schedules", classScheduleService.getSchedulesByClassId(classNo));
        model.addAttribute("times", commonCodeService.getCommonCodeDetailsByCodeId("TIME"));
        return "schedule/scheduleList"; // JSP 파일 경로
    }

    @PostMapping("/save")
    public String saveSchedule(@ModelAttribute("scheduleVO") ClassScheduleVO scheduleVO) {
        classScheduleService.saveSchedule(scheduleVO);
        return "redirect:/classes/list";
    }
}
