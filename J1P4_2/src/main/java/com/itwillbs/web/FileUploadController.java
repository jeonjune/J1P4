package com.itwillbs.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itwillbs.domain.fileVO;
import com.itwillbs.service.EmployeeService;
import com.itwillbs.service.FileUploadService;
import com.itwillbs.service.MainService;

//import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileUploadController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);
	private final String FAKE_PATH = "/upload";
	
	@Inject
	private FileUploadService fService;
	@Inject
	private EmployeeService eService;
	
	@Inject
	private MainService mService;
	
	//파일업로드처리
	@ResponseBody
	@PostMapping(value = "/file/upload")
	public void fileUploadPOST(MultipartHttpServletRequest multiRequest, Model model,fileVO fvo,
			@RequestParam("user_id") String user_id,HttpServletRequest request,Principal principal) throws Exception{
		logger.debug("@@@@@@ 파일 수정 유저번호 "+ eService.user_no(user_id));
		fvo.setUser_no(eService.user_no(user_id));
		
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
        
        int result = fService.updateEmpFile(fvo);
        if(result != 1) {        	
        	fvo.setUser_no(eService.user_no(user_id));
        	fvo.setFile_name(paramMap.get("fileNameList"));
        	logger.debug("@@@@@@ 집가구싶아아아아 "+ fvo.getUser_no());
        	fService.fileProfAdd(fvo);
        }
        if (principal != null) {
        	HttpSession session = request.getSession();
        	fileVO fvo2 = mService.logPic(principal.getName());
        	session.setAttribute("sess_pic", fvo2.getFile_name());
        	logger.info("@@@@@@@@@@@@@@file_name@@@@@@@@@@@ :"+session.getAttribute("sess_pic"));
        }
	
	}
	@ResponseBody
	@PostMapping(value = "/file/delete")
	public void fileDeletePOST(fileVO fvo, @RequestParam("user_id") String user_id, HttpServletRequest request,Principal principal) throws Exception{
		logger.debug("@@@@@@ 파일 수정 유저번호 "+ eService.user_no(user_id));
		fvo.setUser_no(eService.user_no(user_id));
		fvo.setFile_name(null);
		fService.updateEmpFile(fvo);
		
		if (principal != null) {
        	HttpSession session = request.getSession();
        	fileVO fvo2 = mService.logPic(principal.getName());
        	session.setAttribute("sess_pic", fvo2.getFile_name());
        	logger.info("@@@@@@@@@@@@@@file_name@@@@@@@@@@@ :"+session.getAttribute("sess_pic"));
        }
		
	}
	
	public List<String> fileProcess(MultipartHttpServletRequest multiRequest) throws Exception {
	    logger.debug("fileProcess : 파일 업로드 처리 시작!");

	    List<String> fileNameList = new ArrayList<>();
	    Iterator<String> fileNames = multiRequest.getFileNames();
	    while (fileNames.hasNext()) {
	        String fileName = fileNames.next();
	        MultipartFile mFile = multiRequest.getFile(fileName);
	        String oFileName = mFile.getOriginalFilename();
	        
	        // 중복 체크 및 파일명 수정
	        File file = new File(multiRequest.getRealPath(FAKE_PATH) + "\\" + oFileName);
	        String newFileName = oFileName;
	        int count = 1;
	        
	        while (file.exists()) {
	            int dotIndex = oFileName.lastIndexOf('.');
	            if (dotIndex != -1) {
	                newFileName = oFileName.substring(0, dotIndex) + "(" + count + ")" + oFileName.substring(dotIndex);
	            } else {
	                newFileName = oFileName + "(" + count + ")";
	            }
	            file = new File(multiRequest.getRealPath(FAKE_PATH) + "\\" + newFileName);
	            count++;
	        }

	        fileNameList.add(newFileName);

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
		
		//파일 다운로드
		@RequestMapping(value = "/download", method = RequestMethod.GET)
		public void downloadGET(@RequestParam("fileName")String fileName, HttpServletResponse resp, HttpServletRequest req) throws Exception{
			logger.debug("downloadGET() 실행");
			
			// 외부(브라우저)로 통신 가능한 통로
			OutputStream out = resp.getOutputStream();
			
			//다운로드 할 파일의 정보(위치)
			String downFile = req.getRealPath(FAKE_PATH)+"\\"+fileName;
			
			//다운로드 할 파일 생성 
			File file = new File(downFile);
			
			/*------------------------썸네일 생성 (다운로드 전 단계)--------------------------------*/
			
			int lastIdx = fileName.lastIndexOf(".");
			String thumbName = fileName.substring(0,lastIdx);
			
			File thumbnail = new File(req.getRealPath(FAKE_PATH)+"\\"+"thumbnail"+"\\"+thumbName+".png");
			
			if(file.exists()) { //다운로드 받아야 할 파일이 있는지 확인
				//썸네일 폴더 생성 -> 썸네일 이미지 파일 생성
				//thumbnail.getParentFile().mkdirs();
				//Thumbnails.of(file).size(50, 50).outputFormat("png").toFile(thumbnail); //다운로드 받아야 할 파일의 썸네일을 파일형태로 만들겠다
				
				//썸네일을 출력 
//				Thumbnails.of(file).size(100, 100).outputFormat("png").toOutputStream(out);
				
			}
			
			/*----------------------------------------------------------------------*/
			
			//다운로드에 필요한 설정
			resp.setHeader("Cache-Control", "no-cache");
			/* resp.addHeader("Content-disposition", "attachment; fileName="+fileName); */
			resp.addHeader("Content-disposition", "attachment; fileName="+URLEncoder.encode(fileName,"UTF-8"));
			
			FileInputStream fis = new FileInputStream(file); // 다운로드 할 파일에서 읽어온 파일의 경로의 읽어온다 
			
			byte[] buffer = new byte[1024 * 8]; //8키로 바이트 씩 데이터를 가져오겠다!
			while(true) {
				int data = fis.read(buffer);
				if(data == -1) break; // 파일의 끝
				
				out.write(buffer,0,data);
				
			}
			
				//해당 객체 자원해제
				fis.close(); 
				out.close();
			
		}
	
	
	
	
}
