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

import com.itwillbs.domain.EquipManageVO;
import com.itwillbs.domain.fileVO;
import com.itwillbs.service.CommonCodeService;
import com.itwillbs.service.EquipManageService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping(value = "/maintenance/*")
public class EquipmentController {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	private final String FAKE_PATH = "/upload";

	@Inject
	private EquipManageService eService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	
	//장비내역 페이지
	//http://localhost:8088/maintenance/equipment
	@GetMapping(value = "/equipment")
	public void equipmentGET(Model model)throws Exception {
		List<EquipManageVO> eList = eService.listEquip();
		model.addAttribute("eList", eList);
		
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

        eService.equipAdd(vo);

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
    public void downloadGET(@RequestParam("file_name") String fileName, HttpServletResponse resp, HttpServletRequest req) 
    		throws Exception {
        logger.debug("downloadGET() 실행");

        OutputStream out = resp.getOutputStream();
        String downFile = req.getRealPath(FAKE_PATH) + "\\" + fileName;
        File file = new File(downFile);
        
        int lastIdx = fileName.lastIndexOf(".");
		String thumbName = fileName.substring(0,lastIdx);
		
		File thumbnail = new File(req.getRealPath(FAKE_PATH)+"\\"+"thumbnail"+"\\"+thumbName+".png");
        
        if (file.exists()) {
        	//썸네일을 출력 
			Thumbnails.of(file).size(100, 100).outputFormat("png").toOutputStream(out);
        }
            
        	//다운로드에 필요한 설정
        	resp.setHeader("Cache-Control", "no-cache");
            resp.addHeader("Content-disposition", "attachment; fileName=" + URLEncoder.encode(fileName, "UTF-8"));

            FileInputStream fis = new FileInputStream(file);
            byte[] buffer = new byte[1024 * 8];
            while (true) {
                int data = fis.read(buffer);
                if (data == -1) break;
                out.write(buffer, 0, data);
            }
            fis.close();
            out.close();
    }
	
	
	
	//반려내역
	//http://localhost:8088/maintenance/reject
	@GetMapping(value = "/reject")
	public void rejectGET(Model model) throws Exception {
		List<EquipManageVO> rList = eService.rejectList();
		model.addAttribute("rList", rList);
		
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
	
	
	
	
	
	
	
}