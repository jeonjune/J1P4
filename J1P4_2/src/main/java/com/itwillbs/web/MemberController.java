package com.itwillbs.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.HealthMonitorVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RegistrationVO;
import com.itwillbs.domain.fileVO;
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
	private final String FAKE_PATH = "/upload";
	
	@Inject
	private MemberService mService;
	@Inject
	private SearchService sService;
	
	// 회원 리스트 페이지 연결
	@GetMapping(value="/list")
	public void listPageGET(Model model,Criteria cri,MemberVO vo) throws Exception {
		logger.debug(" @@@@@@@@@@@@@@@@@@@@@@@ : "+cri);

		if(cri.getKeyword() != null) {
			
			List<MemberVO> memberList = sService.searchMem(cri);
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getTotalCount(cri));
			logger.debug(" @@@@@@@@@@@@@@@@@ 글 개수 : "+sService.getTotalCount(cri));
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("memberList", memberList);
			model.addAttribute("pageVO",pageVO);
			
			return;
		}
		
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
				
	}
	
	// 회원 기본 페이지 연결
	@GetMapping(value = "/read")
	public void readGET(Model model,@RequestParam int mem_no,Criteria cri) throws Exception{
		logger.debug(" readGET() 실행 ");
		
		Map<String, Object> resultVO = mService.readMem(mem_no);
		logger.info("resultVO :"+ resultVO);
		logger.info("resultVO :"+ resultVO.get("fileVO"));
		
		//전달할 정보 저장
		model.addAttribute("readMem", resultVO.get("MemberVO"));
		model.addAttribute("fileList", resultVO.get("fileVO"));
		model.addAttribute("counting",mService.countingMemClass(mem_no));
		model.addAttribute("pageInfo",cri);
		
	}
	
	// 회원 상세 페이지 연결
	@GetMapping(value = "/details")
	public void detailsGET(Criteria cri,@RequestParam("mem_no") int mem_no, Model model) throws Exception{
		logger.debug(" detailsGET() 실행 ");
		
		List<Map<String, Object>> countClassResult = mService.countClass(mem_no);
		
		ObjectMapper mapper = new ObjectMapper();
        String countClassJSON = "";
        try {
        	countClassJSON = mapper.writeValueAsString(countClassResult);
        } catch (Exception e) {
            logger.error("new6MemCount을 JSON으로 변환하는데 실패하였습니다.", e);
        }
        
        Map<String, Object> statusNormal = new HashMap<String, Object>();
        Map<String, Object> statusRecruit = new HashMap<String, Object>();
        
        statusNormal.put("mem_no", mem_no);
        statusNormal.put("status", "정상");
        statusNormal.put("pageNormal", 0);
        model.addAttribute("normalCount",mService.getTotalDetailCount(statusNormal));
        model.addAttribute("statusNormal",mService.detailClass(statusNormal));
        logger.debug(" ╰(*°▽°*)╯ 현재 수강 중의 강의 개수 : "+mService.getTotalDetailCount(statusNormal));
        
        statusRecruit.put("mem_no", mem_no);
        statusRecruit.put("status", "모집");
        statusRecruit.put("pageRecruit", 0);
        model.addAttribute("recruitCount",mService.getTotalDetailCount(statusRecruit));
        model.addAttribute("statusRecruit",mService.detailClass(statusRecruit));
        logger.debug(" ╰(*°▽°*)╯ 수강 신청 강의 개수 : "+mService.getTotalDetailCount(statusRecruit));
        
		model.addAttribute("vo", countClassJSON);
		model.addAttribute("pageInfo",cri);
		
	}
	
	// 회원 상세 페이지 - 현재 수강 중인 강의 : 조회 및 페이징 처리
	@ResponseBody
	@GetMapping(value = "/detailsAjax")
	public RegistrationVO detailsAjaxGET(@RequestParam("mem_no") int mem_no, @RequestParam("pageNormal") int pageNormal, 
			 @RequestParam("pageRecruit") int pageRecruit, @RequestParam("status") String status, Model model) throws Exception{
	
		logger.debug(" detailsAjaxGET() 실행 ");
		logger.debug(" ############## 상태 : "+status);
		
		if(status.equals("정상")) {
			logger.debug(" @@@@@@@@ pageNormal 실행: "+pageNormal);
		Map<String, Object> statusNormal = new HashMap<String, Object>();
		statusNormal.put("mem_no", mem_no);
		statusNormal.put("status", status);
		statusNormal.put("pageNormal", pageNormal);
		logger.debug(" @@@@@@@@ statusNormal : "+statusNormal);
		logger.debug(" @@@@@@@@ result : "+mService.memberClassStatus(statusNormal));
		return mService.memberClassStatus(statusNormal);
		
		}else {
			
		Map<String, Object> statusRecruit = new HashMap<String, Object>();
		logger.debug(" @@@@@@@@ pageRecruit 실행: "+pageRecruit);
		statusRecruit.put("mem_no", mem_no);
		statusRecruit.put("status", status);
		statusRecruit.put("pageRecruit", pageRecruit);
		logger.debug(" @@@@@@@@ statusRecruit : "+mService.memberClassStatus(statusRecruit));
		return mService.memberClassStatus(statusRecruit);
		}
		
//		return null;
		
	}
	
	// 회원 상세 페이지 - 현재 수강 중인 강의 : 개수 세기
	@ResponseBody
	@GetMapping(value = "/countAjax")
	public int countAjaxGET(@RequestParam("mem_no") int mem_no,
			@RequestParam("status") String status) throws Exception{
		logger.debug(" countAjaxGET 실행 ");
		
		Map<String, Object> statusNormal = new HashMap<String, Object>();
//		Map<String, Object> statusRecruit = new HashMap<String, Object>();
		
		statusNormal.put("mem_no", mem_no);
		statusNormal.put("status", status);
		logger.debug(" @@@@@@@@ statusNormal : "+statusNormal);
		
		
//		statusRecruit.put("mem_no", mem_no);
//		statusRecruit.put("status", "모집");
//		logger.debug(" @@@@@@@@ statusRecruit : "+mService.detailClass(statusRecruit));
		
		return mService.getTotalDetailCount(statusNormal);
		
		
	}
	
	
	// 회원 상세페이지 - 수강분포 : 특정 스포츠 클릭 시 AJAX로 데이터 전달 후 상세정보 조회
	@ResponseBody
	@GetMapping(value = "/detailClass")
	public List<RegistrationVO> detailClassGET(@RequestParam("mem_no") int mem_no,
			@RequestParam("fieldCode") String fieldCode,
			@RequestParam("status") String status) throws Exception{
		logger.debug(" detailClassGET() 실행 ");
		
		// AJAX 파라미터를 통해 컨트롤러로 전달 받은 값들을
		// MAP (k:v)에 담아서 mapper 쿼리 조건절 인자에 전달
		
		// 특정 회원 번호
		logger.debug(" @@@@@@@@@@@@@@@@@ mem_no : "+mem_no);
		
		// 특정 스포츠
		logger.debug(" @@@@@@@@@@@@@@@@@ fieldCode : "+fieldCode);
		
		// 특정 스포츠의 수업 상태 (종료가 전달됨)
		logger.debug(" @@@@@@@@@@@@@@@@@ status : "+status);
	
		Map<String, Object> vo = new HashMap<String, Object>();
		vo.put("mem_no", mem_no);
		vo.put("fieldCode", fieldCode);
		vo.put("status", status);
		
		// 실행 결과를 출력
		logger.debug("  (●'◡'●) 특정 스포츠 상세 정보 : "+ mService.detailClass(vo));
		
		// 결과값이 여러개일 수 있으므로 List에 담아 리턴
		return mService.detailClass(vo);
				
	}
	
	
	// 회원 건강 모니터링 페이지 연결
	@GetMapping(value = "/monitoring")
	public void monitoringGET(@RequestParam int mem_no,@RequestParam int pageStart,Model model) throws Exception{
		logger.debug(" monitoringGET() 실행 ");
		
		Map<String, Object> health = new HashMap<String, Object>();
		health.put("mem_no", mem_no);
		health.put("pageStart", pageStart);
		model.addAttribute("healthInfo",mService.getHealthMonitor(health));
		
		logger.debug(" (●'◡'●) 특정 회원 건강 정보 : "+mService.getHealthMonitor(health));
		
		List<Map<String, Object>> bodyDataResult = mService.getChangeBody(mem_no);
		
		ObjectMapper mapper = new ObjectMapper();
        String bodyDataJSON = "";
        try {
        	bodyDataJSON = mapper.writeValueAsString(bodyDataResult);
        } catch (Exception e) {
            logger.error("new6MemCount을 JSON으로 변환하는데 실패하였습니다.", e);
        }
        
        List<Map<String, Object>> inbodyList = mService.getChangeBody(mem_no);
        Collections.reverse(inbodyList); 
        
        model.addAttribute("bodyDataJSON", bodyDataJSON);
        model.addAttribute("inbodyDate", inbodyList);
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateInbody", method = RequestMethod.POST)
	public void updateInbodyPOST(HealthMonitorVO vo) throws Exception {
		logger.debug(" updateInbodyPOST(vo) 실행 ");
		
		logger.debug(" 인바디 수정 할 정보 : "+vo);
		
		mService.updateInbody(vo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertInbody", method = RequestMethod.POST)
	public void insertInbodyPOST(HealthMonitorVO vo) throws Exception {
		logger.debug(" insertInbodyPOST(vo) 실행 ");
		
		logger.debug(" 인바디 추가 할 정보 : "+vo);
		
		mService.insertInbody(vo);
	}
	
	// 회원 문서 페이지 연결
	@GetMapping(value = "/document")
	public void documentGET(Criteria cri,Model model) throws Exception{
		logger.debug(" documentGET() 실행 ");
	}
		
	// 회원리스트 페이지 - 회원 등록 AJAX
	@ResponseBody
	@PostMapping(value = "/memJoin")
	public void memJoinPOST(MultipartHttpServletRequest multiRequest, MemberVO vo, fileVO fvo) throws Exception {
		logger.info(" memJoinPOST(vo) 실행 ");
		
		// 컨트롤러로 회원 등록을 위해 전달받은 값을 출력
		// 회원 등록 시 전달받는 값이 여러개이므로 vo에 받아서 전달
		logger.info(" (●'◡'●) 회원 등록 vo :"+vo);
		
		// 만약 SMS 또는 이메일 마케팅 동의여부에 값이 없을 경우
		// 0을 담아서 전달
		if(vo.getSms_opt()==null) {
			vo.setSms_opt(0);
		}
		if(vo.getEmail_opt()==null) {
			vo.setEmail_opt(0);
		}
		
		// 파일업로드
		multiRequest.setCharacterEncoding("UTF-8");
        Map<String, String> paramMap = new HashMap();
        Enumeration<String> enu = multiRequest.getParameterNames();
        
        while (enu.hasMoreElements()) {
            String name = enu.nextElement();
            String value = multiRequest.getParameter(name);
            paramMap.put(name, value);
        }
        
        logger.debug("paramMap :{} ", paramMap);

        List<String> fileNameList = fileProcess(multiRequest);
        paramMap.put("fileNameList", String.join(",", fileNameList));
        logger.debug("paramMap :{} ", paramMap);
        
        logger.debug("@@@@@@ 난 이제 지쳤어요 땡벌땡벌 "+ paramMap.get("fileNameList"));
        fvo.setFile_name(paramMap.get("fileNameList"));
        logger.debug("@@@@@@ 난 이제 지쳤어요 땡벌땡벌 "+ fvo.getFile_name());
        
        mService.memJoin(vo);
        mService.fileMemAdd(fvo);
		
		// insert로 회원 등록 실행 (return 값 없음)
		
	}
	
	//파일업로드 메서드
    public List<String> fileProcess(MultipartHttpServletRequest multiRequest) throws Exception {
        logger.debug("fileProcess : 파일 업로드 처리 시작!");

        List<String> fileNameList = new ArrayList();
        Iterator<String> fileNames = multiRequest.getFileNames();
        while (fileNames.hasNext()) {
            String fileName = fileNames.next();
            MultipartFile mFile = multiRequest.getFile(fileName);
            String oFileName = mFile.getOriginalFilename();
            fileNameList.add(oFileName);

            File file = new File(multiRequest.getRealPath(FAKE_PATH) + "\\" + oFileName);
            if (mFile.getSize() != 0) {
                if (!file.exists()) {
                    if (file.getParentFile().mkdirs()) {
                        file.createNewFile();
                    }
                }
                mFile.transferTo(file);
            }
        }
        logger.debug("fileNameList : {}", fileNameList);
        logger.debug("파일 업로드 완료!!, 파일 이름 저장 완료!");

        return fileNameList;
    }

    @GetMapping("/download")
    public void downloadGET(@RequestParam("fileName") String fileName, HttpServletResponse resp, HttpServletRequest req) 
    		throws Exception {
logger.debug(" downloadGET() 실행 ");	
		
		// 외부 (브라우저)로 통신가능한 통로
		OutputStream out = resp.getOutputStream();
		
		// 다운로드할 파일의 정보(위치)
		String downFile = req.getRealPath(FAKE_PATH)+"\\"+fileName;
		
		// 다운로드할 파일 생성
		File file = new File(downFile);
		
		// 다운로드에 필요한 설정
		resp.setHeader("Cache-Control", "no-cache");
		resp.addHeader("Content-disposition", "attachment; fileName="+URLEncoder.encode(fileName,"UTF-8"));
		
		FileInputStream fis = new FileInputStream(file);
		
		byte[] buffer = new byte[1024 * 8];
		
		while(true) {
			int data = fis.read(buffer);
			if(data == -1) break; // 파일의 끝
			
			
			out.write(buffer,0,data);
		}
    }
	
	// 회원 기본페이지 - 회원 수정 AJAX
	@ResponseBody
	@PostMapping(value = "/memUpdate")
	public void memUpdatePOST(MemberVO vo) throws Exception {
		logger.info(" memUpdatePOST(vo) 실행 ");
		
		// 컨트롤러로 회원 수정을 위해 전달받은 값을 출력
		// 회원 수정 시 전달받는 값이 여러개이므로 vo에 받아서 전달
		logger.info(" (●'◡'●) 회원 수정 vo :"+vo);
		
		// 만약 SMS 또는 이메일 마케팅 동의여부에 값이 없을 경우
		// 0을 담아서 전달
		if(vo.getSms_opt()==null) {
			vo.setSms_opt(0);
		}
		if(vo.getEmail_opt()==null) {
			vo.setEmail_opt(0);
		}
		
		// update로 회원 등록 실행 (return 값 없음)
		mService.memUpdate(vo);
		
	}
	
	// 회원 기본페이지 - 회원 삭제 AJAX
	@ResponseBody
	@PostMapping(value = "/memDelete")
	public void memDeletePOST(@RequestBody Map<String, List> mem_no) throws Exception {
		logger.info(" memDeletePOST(mem_no) 실행 ");
		
		// 컨트롤러로 회원 삭제를 위해 전달받은 값을 출력
		// 회원 삭제 시 전달받는 값이 하나
		logger.info(" (●'◡'●) 회원 삭제 :"+mem_no);
		
		// delete로 회원 삭제 실행 (return 값 없음)
		mService.memDelete(mem_no);
		
	}
	
	// 회원리스트 페이지 - 메시지 전송 : 선택된 회원의 연락처 AJAX로 조회
	@ResponseBody
	@PostMapping(value = "/memPhone")
	public List<MemberVO> memPhoneGET(@RequestBody Map<String, List> mem_no) throws Exception {
		logger.info(" memPhoneGET(mem_no) 실행 ");
		
		// 컨트롤러로 선택된 회원 연락처 조회를 위해 전달받은 값을 출력
		// 선택된 회원 연락처 조회 시 전달받는 값이 하나
		logger.info(" (●'◡'●) 회원 연락처 조회를 위한 mem_no :"+mem_no);
		
		// 결과값이 여러개일 수 있으므로 List에 담아서 변수에 저장
		List<MemberVO> result = mService.memPhone(mem_no);
		
		// 선택된 회원 연락처 조회 결과 출력
		logger.info(" (´▽`ʃ♡ƪ) 회원 연락처 결과 : "+result);
		
		// AJAX 이므로 return으로 값을 돌려줌
		return result;
		
		
	}
	
	// 디지털 마케팅 페이지 - 발송 메시지 조회 및 페이징 처리
	@GetMapping(value="/message")
	public void messageGET(Model model,Criteria cri) throws Exception {
		logger.info(" messageGET(model,cri) 실행 ");
		
		// 전체 조회이므로 조회를 위해 전달받을 값은 없으며
		// 페이징을 위해 cri를 전달 후 model 객체에 담아서 뷰페이지 전달
		model.addAttribute("SMS",mService.selectSMS(cri));
		
		// 페이징을 위해 필요한 정보를 뷰페이지에 전달
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(mService.getTotalSMS());
		model.addAttribute("pageVO",pageVO);
		
	}
	
	
	
}
