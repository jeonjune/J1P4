package com.itwillbs.web;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.domain.EmpAttendanceVO;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.FacilityManagementVO;
import com.itwillbs.domain.FacilityReservationVO;
import com.itwillbs.domain.FacilityVO;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.FacReservationService;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.FacilityService;
import com.itwillbs.service.SearchService;

@Controller
@RequestMapping(value="/maintenance/*")
public class FacilityController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@Inject
	private FacilityService fService;
	
	@Inject
	private SearchService sService;
	
   @Inject FacReservationService frService;
   
   @Autowired
   private CommonCodeService commonCodeService;
	
	
	//시설리스트
	//http://localhost:8088/maintenance/facility
	@GetMapping(value = "/facility")
	public void facilityGET(Model model,FacilityVO vo) throws Exception {
		logger.info("facilityGET() 실행 :");
		
		List<FacilityVO> facList = fService.facList();
		model.addAttribute("facList", facList);
		
		logger.info("@@@@@@@@@@@@@@vo@@@@@@@@@@@ :"+vo);
		
	}
	
	
	//시설리스트 등록(모달창에 입력)
	@ResponseBody
	@PostMapping(value = "/facility")
	public String facInsertPOST(FacilityVO vo) throws Exception {
		logger.info("모달창에 시설 등록 - 입력된 데이터 처리");
		
		logger.info("vo :"+vo);
		//DAO에 동작 호출
		fService.facInsert(vo);
		
		
		return "maintenance/facility";
	}
	
	
	//시설상세페이지 리스트
	@GetMapping(value = "/read")
	public void facReadListGET(Criteria cri,HttpServletRequest request,Model model, @RequestParam("facility_no")int fno)throws Exception {
		
		if(cri.getRepair_type() != null) {
			
			List<FacilityManagementVO> facDe = sService.searchFacility(cri);
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getFacilityCount(cri));
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("facDe", facDe);
			model.addAttribute("pageVO",pageVO);
			
		} else {

		logger.info("facReadListGET() 실행 :");
		List<FacilityManagementVO> facDe = fService.facDe(cri);
		logger.info("facDe :"+facDe);
		model.addAttribute("facDe",facDe);
		
		// 페이징 처리
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(fService.getCountFacDe(fno));
		
		model.addAttribute("pageVO",pageVO);
		}
		
		//시설이름 조회
		String name = fService.facName(fno);
		logger.info("name :"+name);
		model.addAttribute("name", fService.facName(fno));
		
		//count 조회
		model.addAttribute("count", fService.count(fno));
		
		//최신날짜 조회
		List<FacilityManagementVO> fac = fService.dateUpdate(fno);
		logger.info("fac :"+fac.size());
		model.addAttribute("fac",fService.dateUpdate(fno));
		
		
		
	}
	
	
	//시설상세내역페이지 등록(모달창)
	@ResponseBody
	@PostMapping(value = "/read")
	public String facReadListPOST(FacilityManagementVO vo, HttpServletRequest request)throws Exception {
		logger.info("모달창에 시설상세내역 등록 - 입력된 데이터 처리");
		
		fService.facDeIn(vo);
		logger.info("#########vo########## :"+vo);
		fService.typeUpdate(vo); //한달기준으로 시설 유지보수유형을 청소->삭제로 업데이트 해준다.
		
		return "maintenance/read";
		
	}
	
	
	
	
	 //------------------------------------------------------------------------캘린더
	   
	   // http://localhost:8088/maintenance/reservation
	   //시설예약 페이지 - 캘린터 조회
	   @GetMapping(value = "/reservation")
	   public ModelAndView getCalendarList(Model model,ModelAndView mv, HttpServletRequest request,FacilityReservationVO fvo) {
	      String viewpage = "/maintenance/reservation";
	      List<FacilityReservationVO> calendar = null;
	      try {
	         calendar = frService.rsvSelect();
	         request.setAttribute("calendarList", calendar);
	         logger.info("@@@@@@@@@@@@@@calendar@@@@@@@@@@@ :"+calendar);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      mv.setViewName(viewpage);
	      
	      model.addAttribute("FacilityReservationVO", fvo);
	      model.addAttribute("FacilityReservationVO", fvo);
	      model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
	      model.addAttribute("times", commonCodeService.getCommonCodeDetailsByCodeId("TIME"));
	       
	      return mv;
	   }
	   
	   //시설예약 등록
	   @ResponseBody
	   @PostMapping(value = "/reservation")
	   public String rsvPOST(FacilityReservationVO vo) throws Exception {
	      logger.info("모달창으로 휴가신청(컨트롤러)");
	      vo.setManager_no(12);
	      frService.reservation(vo);
	      return "maintenance/reservation";
	   }
	   
	   //시설예약 수정
	   @ResponseBody
	   @PostMapping(value = "/rsvUpdate")
	   public void rsvUpdatePOST( FacilityReservationVO vo) throws Exception{
	      logger.info("모달창수정완료)");
	      logger.info("#### vo ##### :"+vo);
	      frService.rsvUpdate(vo);
	      //return"maintenance/reservation";
	   }
	   
	   //시설예약 삭제
	   @ResponseBody
	   @PostMapping(value = "/rsvDelete")
	   public void rsvDeletePOST(FacilityReservationVO vo) throws Exception {
	      logger.info("삭제완료");
	      frService.rsvDelete(vo);
	   }
	   
	   //시설예약 회원검색
	   @ResponseBody
	   @GetMapping(value = "/memSearch")
	   public List<FacilityReservationVO> memSearchGET(@RequestParam("keyword")String keyword) throws Exception{
	      List<FacilityReservationVO> search = frService.memSearch(keyword);
	      return search;
	   }

	
	
	
	
	
	
	
	
}
