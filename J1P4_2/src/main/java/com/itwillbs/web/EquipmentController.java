package com.itwillbs.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.fileVO;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.EquipManageService;
import com.itwillbs.service.SearchService;


@Controller
@RequestMapping(value = "/maintenance/*")
public class EquipmentController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	private final String FAKE_PATH = "/upload";

	@Inject
	private EquipManageService eService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Inject
	private SearchService sService;
	
	
	//장비내역 페이지
	//http://localhost:8088/maintenance/equipment
	@GetMapping(value = "/equipment")
	public void equipmentGET(Model model,Criteria cri)throws Exception {
		
		if(cri.getKeyword() != null) {
			
			List<EquipManageVO> eList = sService.searchEquip(cri);
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getEquipCount(cri));
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("eList", eList);
			model.addAttribute("pageVO",pageVO);
			
			return;
		}
		
		List<EquipManageVO> eList = eService.listEquip(cri);
		model.addAttribute("eList", eList);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(eService.equipListCount());
		
		model.addAttribute("pageVO",pageVO);
		
	}
		

	
	
	//장비신청내역 페이지
	//http://localhost:8088/maintenance/list
	@GetMapping(value = "/list")
	public String listGET(Model model) throws Exception {
		List<EquipManageVO> list = eService.equipList();
		
		model.addAttribute("list",list);

		return "/maintenance/list";
		
	}
	
	
	//장비신청 (글쓰기)
	//http://localhost:8088/maintenance/regist
	@GetMapping(value = "/regist")
	public void registGET(Model model, EquipManageVO vo) {
		vo.setField("분야");
	    model.addAttribute("EquipManageVO", vo);
        model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        logger.info("job : "+commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
        logger.info("@@@@@@@vo@@@@ :"+ vo);
		
	}
	
	@ResponseBody
	@PostMapping(value = "/regist")
	 public String registPOST(MultipartHttpServletRequest multiRequest, EquipManageVO vo, fileVO fvo, Model model) throws Exception {
        logger.info("22222222 vo 2222222222222 : " + vo);
        vo.setManager_no(12); // 로그인 기능 들고올때까지 임시로 설정(user_no) 나중에 세션에 담아서 사용

        // 폼 데이터 처리
        multiRequest.setCharacterEncoding("UTF-8");
        Map<String, String> paramMap = new HashMap();
        Enumeration<String> enu = multiRequest.getParameterNames();
        while (enu.hasMoreElements()) {
            String name = enu.nextElement();
            String value = multiRequest.getParameter(name);
            paramMap.put(name, value);
        }
        logger.debug("paramMap :{} ", paramMap);

        // 파일 업로드 처리
        List<String> fileNameList = fileProcess(multiRequest);
        paramMap.put("fileNameList", String.join(",", fileNameList));
        logger.debug("paramMap :{} ", paramMap);

        model.addAttribute("paramMap", paramMap);
        
        logger.debug("@@@@@@ 난 이제 지쳤어요 땡벌땡벌 "+ paramMap.get("fileNameList"));
        fvo.setFile_name(paramMap.get("fileNameList"));
        logger.debug("@@@@@@ 난 이제 지쳤어요 땡벌땡벌 "+ fvo.getFile_name());
        
        eService.equipAdd(vo);
        eService.fileAdd(fvo);

        return "redirect:/maintenance/list";
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
	
	//------------------------------------------------------------------------
	
	//반려내역
	//http://localhost:8088/maintenance/reject
	@GetMapping(value = "/reject")
	public void rejectGET(Model model,Criteria cri) throws Exception {
		
		if(cri.getKeyword() != null) {
			
			List<EquipManageVO> rList = sService.searchEquip(cri);
			// 하단 페이징처리 정보
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(sService.getEquipCount(cri));
			// 연결된 뷰페이지로 정보 전달
			model.addAttribute("rList", rList);
			model.addAttribute("pageVO",pageVO);
			
			return;
		}
		
		List<EquipManageVO> rList = eService.rejectList(cri);
		model.addAttribute("rList", rList);
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(eService.rejectListCount());

		// 연결된 뷰페이지로 정보 전달
		model.addAttribute("pageVO",pageVO);
		
	}
	
	//장비신청 상세페이지
	//http://localhost:8088/maintenance/detail
	@GetMapping(value = "/detail")
	public void detailGET(Model model, @RequestParam("equipment_no") int eno) throws Exception {
		//전달정보 저장 
		logger.info("####eno##### :"+ eno);
		
		//DAO 저장된 정보 가져오기
		Map<String, Object> resultVO = eService.equipDetail(eno);
		logger.info("resultVO :"+ resultVO);
		logger.info("resultVO :"+ resultVO.get("fileVO"));
		
		//전달할 정보 저장
		model.addAttribute("resultVO", resultVO.get("EquipManageVO"));
		model.addAttribute("fileList", resultVO.get("fileVO"));
		
		model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
	}
	
	//장비신청 상세페이지 업데이트 - 승인
	@ResponseBody
	@PostMapping(value = "/detail")
	public String updateType(@RequestParam("equipment_no")int eq,EquipManageVO vo) throws Exception{
		logger.info("#### eq ##### :"+ eq);
		logger.info("#### vo ##### :"+ vo);
		vo.setEquipment_no(eq);
		eService.updateType(vo);
		
		return"redirect:/maintenance/equipment";
	}
	
	//장비신청 상세페이지 업데이트 - 반려
	@ResponseBody
	@PostMapping(value = "/detail2")
	public String updateReject(@RequestParam("equipment_no") int eno,EquipManageVO vo, @RequestParam("equipment_reject") String ereject) throws Exception{
		logger.info("#### eno ##### :"+ eno);
		logger.info("@@@ erejet @@@ :"+ ereject);
		vo.setEquipment_no(eno);
		vo.setEquipment_reject(ereject);
		eService.updateReject(vo);
		
		
		return"redirect:/maintenance/reject";
	}
	
	
	
	//장비내역 상세페이지 - 여기서 추가구매/수리/폐기 수정 후 신청내역으로 이동
		//http://localhost:8088/maintenance/equipdetail
		@GetMapping(value = "/equipdetail")
		public void equipDetailGET(Model model, @RequestParam("equipment_no") int eno) throws Exception {
			//전달정보 저장 
			logger.info("####eno##### :"+ eno);
			
			//DAO 저장된 정보 가져오기
			Map<String, Object> result = eService.equipDetailGET(eno);
			logger.info("result :"+ result);
			
			//전달할 정보 저장
			model.addAttribute("resultVO", result.get("EquipManageVO"));
			model.addAttribute("fileList", result.get("fileVO"));
			
			model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));
		}
	
	
	//장비내역 (추가구매/수리/폐기) - 수정하기
	@PostMapping(value = "/equipdetail")
	public String equipdetailPOST(EquipManageVO vo, @RequestParam("equipment_no")int eno) throws Exception {
		logger.info("!!!! eno !!!!!!! :"+ eno);
		vo.setEquipment_no(eno);
		eService.equipUpdate(vo);
		
		return"redirect:/maintenance/list";
	}
	
	//장비내역 (수리중 -> 정상)으로 수정하기
	@ResponseBody
	@PostMapping(value = "/equipdetail2")
	public String repairOk(EquipManageVO vo,@RequestParam("equipment_no")int eno) throws Exception {
		eService.repairOk(vo);
		vo.setEquipment_no(eno);
		
		return"redirect:/maintenance/equipment";
	}
	
	//반려사유 가져오기
	@ResponseBody
	@GetMapping(value = "/getReject")
	public Map<String, String> getReject(@RequestParam("equipment_no")int eno) throws Exception {
		EquipManageVO evo = eService.getReject(eno);
		
		Map<String, String> reject = new HashMap<String, String>();
		reject.put("equipment_reject", evo.getEquipment_reject());
		reject.put("name", evo.getName());
		
		return reject;
	}
	
	
	//장비신청 상세페이지 조회
	// 장비신청 상세페이지 조회
	@GetMapping(value = "/updateDetail")
	public String updateDetail(Model model, @RequestParam("equipment_no") int eno) throws Exception {
	    // 전달 정보 저장
	    logger.info("####eno##### :" + eno);

	    // DAO 저장된 정보 가져오기
	    Map<String, Object> resultVO = eService.equipDetail(eno);
	    logger.info("resultVO :" + resultVO);
	    logger.info("resultVO :" + resultVO.get("fileVO"));

	    // EquipManageVO 객체를 모델에 추가
	    model.addAttribute("resultVO", resultVO.get("EquipManageVO"));
	    // 파일 리스트 추가
	    model.addAttribute("fileList", resultVO.get("fileVO"));
	    // fields 리스트 추가
	    model.addAttribute("fields", commonCodeService.getCommonCodeDetailsByCodeId("FIELD"));

	    return "/maintenance/updateDetail"; // JSP 페이지 이름
	}

	
	//장비신청 상세페이지 수정 (사원)
	@PostMapping(value = "/updateDetail")
	public void updateDetailPOST(EquipManageVO vo) throws Exception{
			eService.updateDetail(vo);
			logger.info("상세페이지 수정완료");
			
		}
	
	
	
	
	
	
	
	
	
	
}