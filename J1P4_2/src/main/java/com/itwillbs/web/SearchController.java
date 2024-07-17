package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.SearchService;

@Controller
@RequestMapping(value = "/member/*")
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Inject
	private SearchService sService;
	
	@GetMapping(value="/listSearch")
	public void listSearchGET(Criteria cri,Model model) throws Exception {
		logger.debug(" ヾ(•ω•`)o Controller : listSearchGET(Criteria cri,Model model) 실행 ");
		// 서비스 -> DB의 정보를 가져오기 (페이징처리)
		List<MemberVO> memberList = sService.searchMem(cri);
		logger.debug(" size : "+memberList.size());
		logger.debug(" ヾ(•ω•`)o memberList = "+memberList);
		logger.debug(" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + cri);
		logger.debug(" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + sService.getTotalCount(cri));
		// 하단 페이징처리 정보
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(sService.getTotalCount(cri));
		
		// 연결된 뷰페이지로 정보 전달
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageVO",pageVO);
		
		
	}
	
}
