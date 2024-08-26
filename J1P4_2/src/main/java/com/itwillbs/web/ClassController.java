package com.itwillbs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ClassVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.ClassScheduleVO;
import com.itwillbs.service.ClassService;
import com.itwillbs.service.ClassScheduleService;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.SearchService;

@Controller
@RequestMapping("/classes/*")
public class ClassController {
	

	private static final Logger logger = LoggerFactory.getLogger(ClassController.class);

    @Autowired
    private ClassService classService;

    @Autowired
    private ClassScheduleService classScheduleService;

    @Autowired
    private CommonCodeService commonCodeService;
    
    @Autowired
    private SearchService sService;

    @GetMapping("/list")
    public String listClasses(Model model,Criteria cri) throws Exception {
    	
    	List<ClassVO> classList;
    	PageVO pageVO = new PageVO();
    	
    	if(cri.getKeyword() != null) {
			
    		classList = sService.searchClass(cri);
			// 하단 페이징처리 정보
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getClassCount(cri));

    	} else {
			
    		classList = classService.getAllClasses(cri);
    		// 하단 페이징처리 정보
    		pageVO.setCri(cri);
    		pageVO.setTotalCount(classService.getClassesCount());
		}
    	
     	// 연결된 뷰페이지로 정보 전달
        model.addAttribute("classList", classList);
        model.addAttribute("classVO", new ClassVO());
        model.addAttribute("scheduleVO", new ClassScheduleVO());
        model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        model.addAttribute("divisions", commonCodeService.getCommonCodeDetailsByCodeId("DIVISION"));
        model.addAttribute("levels", commonCodeService.getCommonCodeDetailsByCodeId("LEVEL"));
        model.addAttribute("times", commonCodeService.getCommonCodeDetailsByCodeId("TIME"));
        model.addAttribute("pageVO",pageVO);
        
        return "class/classList";
    }

    @PostMapping("/save")
    public String saveClass(@ModelAttribute("classVO") ClassVO classVO) {
        if (classVO.getClassNo() == 0) {
            classService.addClass(classVO);
        } else {
        	logger.info("edit 값 존재@@@");
        	logger.info(classVO.toString());
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
        return "class/classDetail"; 
    }
    
    @GetMapping("/search")
    @ResponseBody
    public List<ClassScheduleVO> classSearch(@RequestParam("status") String status, @RequestParam("classNo") String classNo) throws Exception {
    	
    	Map<String, Object> search = new HashMap<>();
    	search.put("status", status);
    	search.put("classNo", classNo);
    	List<ClassScheduleVO> result = sService.searchClassDetail(search);
    	
    	return result;
    }
}