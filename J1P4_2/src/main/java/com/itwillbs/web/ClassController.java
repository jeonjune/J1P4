package com.itwillbs.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.service.ClassService;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.CommonCodeService;

@Controller
@RequestMapping("/classes/*")
public class ClassController {

    @Autowired
    private ClassService classService;

    @Autowired
    private ClassScheduleService classScheduleService;

    @Autowired
    private CommonCodeService commonCodeService;

    @GetMapping("/list")
    public String listClasses(Model model) {
        List<ClassVO> classList = classService.getAllClasses();
        model.addAttribute("classList", classList);
        model.addAttribute("classVO", new ClassVO());
        model.addAttribute("scheduleVO", new ClassScheduleVO());
        model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        model.addAttribute("divisions", commonCodeService.getCommonCodeDetailsByCodeId("DIVISION"));
        model.addAttribute("levels", commonCodeService.getCommonCodeDetailsByCodeId("LEVEL"));
        model.addAttribute("times", commonCodeService.getCommonCodeDetailsByCodeId("TIME"));
        return "class/classList";
    }

    @PostMapping("/save")
    public String saveClass(@ModelAttribute("classVO") ClassVO classVO) {
        if (classVO.getClassNo() == 0) {
            classService.addClass(classVO);
        } else {
            classService.editClass(classVO);
        }
        return "redirect:/classes/list";
    }

    @GetMapping("/edit/{id}")
    @ResponseBody
    public ClassVO getClassById(@PathVariable("id") int classNo) {
        return classService.getClassById(classNo);
    }

    @PostMapping("/delete")
    @ResponseBody
    public String deleteClasses(@RequestBody List<Integer> classNos) {
        for (Integer classNo : classNos) {
            classService.deleteClass(classNo);
        }
        return "Success";
    }

    @GetMapping("/detail/{id}")
    public String classDetail(@PathVariable("id") int classNo, Model model) {
        ClassVO classVO = classService.getClassById(classNo);
        List<ClassScheduleVO> schedules = classScheduleService.getSchedulesByClassId(classNo);
        model.addAttribute("classVO", classVO);
        model.addAttribute("scheduleVO", new ClassScheduleVO());
        model.addAttribute("schedules", schedules);
        model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        model.addAttribute("divisions", commonCodeService.getCommonCodeDetailsByCodeId("DIVISION"));
        model.addAttribute("levels", commonCodeService.getCommonCodeDetailsByCodeId("LEVEL"));
        model.addAttribute("times", commonCodeService.getCommonCodeDetailsByCodeId("TIME"));
        return "class/classDetail"; // JSP 파일 경로
    }
}
