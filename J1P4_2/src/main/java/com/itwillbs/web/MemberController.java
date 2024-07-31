package com.itwillbs.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.model.StorageType;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService mService;
	@Inject
	private SearchService sService;
	
	
	@GetMapping(value="/list")
	public void listPageGET(Model model,Criteria cri,MemberVO vo) throws Exception {
		logger.debug(" @@@@@@@@@@@@@@@@@@@@@@@ : "+cri);
		
		
		if(cri.getFilter() == null && cri.getKeyword() == null && cri.getMemYear() == null) {
			// 서비스 -> DB의 정보를 가져오기 (페이징처리)
			List<MemberVO> memberList = mService.listPage(cri);
			logger.debug(" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "+memberList);
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
			logger.debug(" @@@@@@@@@@@@@@@@@ 글 개수 : "+sService.getTotalCount(cri));
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("memberList", memberList);
			model.addAttribute("pageVO",pageVO);
		}
		
				
	}
	
	@GetMapping(value = "/read")
	public void readGET(Model model,@RequestParam int mem_no,Criteria cri) throws Exception{
		logger.debug(" readGET() 실행 ");
		
		logger.debug(" @@@@@@@@@@@ int mem_no = "+mem_no);
		
		
		model.addAttribute("readMem",mService.readMem(mem_no));
		model.addAttribute("pageInfo",cri);
		
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
	
	// 회원수정
	@ResponseBody
	@PostMapping(value = "/memUpdate")
	public void memUpdatePOST(MemberVO vo) throws Exception {
		logger.info("@@@@@@@@@@@@@@모달창으로 회원 수정(컨트롤러)");
		
		logger.info("vo :"+vo);
		if(vo.getSms_opt()==null) {
			vo.setSms_opt(0);
		}
		if(vo.getEmail_opt()==null) {
			vo.setEmail_opt(0);
		}
		mService.memUpdate(vo);
		
	}
	
	// 회원삭제
	@ResponseBody
	@PostMapping(value = "/memDelete")
	public void memDeletePOST(@RequestBody Map<String, List> mem_no) throws Exception {
		logger.info("@@@@@@@@@@@@@@모달창으로 회원 삭제(컨트롤러)");
		logger.info("@@@@@@@@@@@@@@ mem_no"+mem_no);
		
		
		mService.memDelete(mem_no);
		
	}
	
	// 회원번호
	@ResponseBody
	@PostMapping(value = "/memPhone")
	public List<MemberVO> memPhoneGET(@RequestBody Map<String, List> mem_no) throws Exception {
		logger.info("@@@@@@@@@@@@@@회원 전화번호 조회");
		logger.info("@@@@@@@@@@@@@@ mem_no"+mem_no);
		
		List<MemberVO> vo = mService.memPhone(mem_no);
		
		logger.info("@@@@@@@@@@@@@@ vo : "+vo);
		return vo;
		
		
	}
	
	// 전송 메시지 조회
	@GetMapping(value="/message")
	public void messageGET(Model model) throws Exception {
		model.addAttribute("SMS",mService.selectSMS());
	}
	

	
}
