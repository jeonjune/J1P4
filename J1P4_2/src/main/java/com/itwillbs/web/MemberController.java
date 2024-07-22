package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.SearchService;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;
	@Inject
	private SearchService sService;
	
	
	@GetMapping(value="/list")
	public void listPageGET(Model model,Criteria cri) throws Exception {
		
		if(cri.getFilter() == null && cri.getKeyword() == null && cri.getMemYear() == null) {
			// 서비스 -> DB의 정보를 가져오기 (페이징처리)
			List<MemberVO> memberList = mService.listPage(cri);
			logger.debug(" size : "+memberList.size());
			logger.debug(" pageStart : "+cri.getPageStart());
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(mService.getTotalCount());
			
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("memberList", memberList);
			model.addAttribute("pageVO",pageVO);
			
		} else {
			List<MemberVO> memberList = sService.searchMem(cri);
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getTotalCount(cri));
			
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("memberList", memberList);
			model.addAttribute("pageVO",pageVO);
		}
		
				
	}
	
	@GetMapping(value = "/read")
	public void readGET(Model model,@RequestParam int mem_no) throws Exception{
//		public void readGET(Model model,@PathVariable int mem_no) throws Exception{
		logger.debug(" readGET() 실행 ");
		
		logger.debug(" @@@@@@@@@@@ int mem_no = "+mem_no);
		
		
		model.addAttribute("readMem",mService.readMem(mem_no));
		
	}
	@GetMapping(value = "/details")
	public void detailsGET(Criteria cri,Model model) throws Exception{
		logger.debug(" detailsGET() 실행 ");
		
		
	}
	@GetMapping(value = "/monitoring")
	public void monitoringGET(Criteria cri,Model model) throws Exception{
		logger.debug(" monitoringGET() 실행 ");
		
		
	}
	@GetMapping(value = "/document")
	public void documentGET(Criteria cri,Model model) throws Exception{
		logger.debug(" documentGET() 실행 ");
		
		
	}
	
	@GetMapping
	@ResponseBody
	public void selectPost(Criteria cri,Model model) throws Exception {
		
		// 서비스 -> DB의 정보를 가져오기 (페이징처리)
				List<MemberVO> memberList = mService.listPage(cri);
				logger.debug(" 에이작스 size : "+memberList.size());
				logger.debug(" 에이작스 pageSize : "+cri.getPageSize());
				logger.debug(" 에이작스 pageStart : "+cri.getPageStart());
				
				// 하단 페이징처리 정보
				PageVO pageVO = new PageVO();
				pageVO.setCri(cri);
				pageVO.setTotalCount(mService.getTotalCount());
				
				// 연결된 뷰페이지로 정보 전달
				model.addAttribute("memberList", memberList);
				model.addAttribute("pageVO",pageVO);
		
	}
	
//	// 회원등록버튼 임시페이지
//	@GetMapping(value = "/memJoin")
//	public void memJoinGET() throws Exception{
//		logger.debug(" memJoinGET() 실행 ");
//		
//		
//	}
	
	// 회원등록 후 리스트 이동
	@ResponseBody
	@PostMapping(value = "/memJoin")
	public void memListPOST(MemberVO vo) throws Exception {
		logger.info("모달창으로 회원 등록(컨트롤러)");
		
		logger.info("vo :"+vo);
		if(vo.getSms_opt()==null) {
			vo.setSms_opt(0);
		}
		if(vo.getEmail_opt()==null) {
			vo.setEmail_opt(0);
		}
		mService.memJoin(vo);
		
	}
	
}
