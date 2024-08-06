package com.itwillbs.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.CommonCodeService;

import java.util.List;

@Controller
@RequestMapping("/schedules/*")
public class ClassScheduleController {

    @Autowired
    private ClassScheduleService classScheduleService;

    @Autowired
    private CommonCodeService commonCodeService;

    @GetMapping("/list/{classNo}")
    @ResponseBody
    public List<ClassScheduleVO> listSchedules(@PathVariable("classNo") int classNo) {
        return classScheduleService.getSchedulesByClassId(classNo);
    }

    @PostMapping("/save")
    public String saveSchedule(@ModelAttribute("scheduleVO") ClassScheduleVO scheduleVO) {
        classScheduleService.saveSchedule(scheduleVO);
        return "redirect:/classes/detail/" + scheduleVO.getClassNo();
    }

    @GetMapping("/edit/{id}")
    @ResponseBody
    public ClassScheduleVO getScheduleById(@PathVariable("id") int scheduleId) {
        return classScheduleService.getScheduleById(scheduleId);
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public String deleteSchedule(@PathVariable("id") int scheduleId) {
        ClassScheduleVO schedule = classScheduleService.getScheduleById(scheduleId);
        classScheduleService.deleteSchedule(scheduleId);
        return "redirect:/classes/detail/" + schedule.getClassNo();
    }

    @PostMapping("/delete")
    @ResponseBody
    public String deleteSchedules(@RequestBody List<Integer> scheduleIds) {
        for (int scheduleId : scheduleIds) {
            classScheduleService.deleteSchedule(scheduleId);
        }
        return "Success";
    }
}
