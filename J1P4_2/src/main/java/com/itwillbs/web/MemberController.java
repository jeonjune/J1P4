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
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;
	
	
	@GetMapping(value="/list")
	public void listPageGET(Criteria cri,Model model) throws Exception {
		
		// 서비스 -> DB의 정보를 가져오기 (페이징처리)
		List<MemberVO> memberList = mService.listPage(cri);
		logger.debug(" size : "+memberList.size());
		
		// 하단 페이징처리 정보
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(mService.getTotalCount());
		
		// 연결된 뷰페이지로 정보 전달
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageVO",pageVO);
		
		logger.debug(" @@@@@@ 매핑 완료 @@@@@@@@@@@@ ");
		
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
}
