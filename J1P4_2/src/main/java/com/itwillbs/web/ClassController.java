package com.itwillbs.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.domain.ClassVO;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.ClassService;
import com.itwillbs.service.CommonCodeService;

@Controller
@RequestMapping("/classes/*")
public class ClassController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClassController.class);

    @Autowired
    private ClassService classService;

    @Autowired
    private CommonCodeService commonCodeService;
    
    @Autowired
    private ClassScheduleService classScheduleService;

    @GetMapping("/list")
    public String listClasses(Model model) {
        List<ClassVO> classList = classService.getAllClasses();
        model.addAttribute("classList", classList);
        model.addAttribute("classVO", new ClassVO());
        model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        model.addAttribute("divisions", commonCodeService.getCommonCodeDetailsByCodeId("DIVISION"));
        model.addAttribute("levels", commonCodeService.getCommonCodeDetailsByCodeId("LEVEL"));
        return "class/classList"; // JSP 파일 경로
    }

    @PostMapping("/save")
    public String saveClass(@ModelAttribute("classVO") ClassVO classVO, Model model) {
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
    	
    	ClassVO vo = classService.getClassById(classNo);
    	
    	logger.info(vo.toString());
        return vo;
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public String deleteClass(@PathVariable("id") int classNo) {
        classService.deleteClass(classNo);
        return "redirect:/classes/list";
    }
    
    @PostMapping("/schedule/save")
    @ResponseBody
    public ResponseEntity<String> saveSchedule(@ModelAttribute ClassScheduleVO scheduleVO) {
        classScheduleService.saveSchedule(scheduleVO);
        return ResponseEntity.ok("Success");
    }
}
