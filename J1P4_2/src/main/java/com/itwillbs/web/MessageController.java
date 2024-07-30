package com.itwillbs.web;

import java.io.File;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
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

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.BaseVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.RecipientVO;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.MessageService;
import com.itwillbs.service.SearchService;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.model.StorageType;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.MultipleDetailMessageSentResponse;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@RequestMapping(value="/message/*")
public class MessageController {
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Inject
	private MessageService mService;

	@ResponseBody
    @PostMapping("/sendMem")
    public void sendMemPOST(@RequestBody RecipientVO vo) throws Exception {
		
		String api_key = "NCSD9O2CTBIE4GSB";
		String api_secret = "JMEBX3LIRV6ABZBOECOBFSATC56Z5JYW";
		
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize(api_key, api_secret, "https://api.coolsms.co.kr");
		
		// 수신번호와 전송내용을 변수에 담음 (수신번호는 여러개 담길 경우 split 함수로 쪼개줌)
		String[] phoneNum = vo.getRecipient_mem().split(",");
		String content = vo.getMessage();
		
		// 테이블에 전송내용 저장
		mService.insertMemSMS(content);
    	
    	ArrayList<Message> messageList = new ArrayList<>();
   
    	for(String item : phoneNum) {
	    	Message message = new Message();
	    	message.setFrom("01052301972");
	    	message.setTo(item);
	    	message.setText("[STS Center] "+content);
	    	messageList.add(message);
	    	mService.insertMemReceiver(item);
    	}
    	
    	logger.debug(" @@@@@@@@@@@@@@@@@@@@@@@ : "+messageList);
    	try {
    		// 예약 시간 설정
	    	LocalDateTime localDateTime = LocalDateTime.parse("2024-07-30 12:40:00", DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	        ZoneOffset zoneOffset = ZoneId.systemDefault().getRules().getOffset(localDateTime);
	        Instant instant = localDateTime.toInstant(zoneOffset);
	        
	    	// send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
	//    	MultipleDetailMessageSentResponse response = messageService.send(messageList, false, true);
	    	MultipleDetailMessageSentResponse response = messageService.send(messageList, instant, true);
    	
    	} catch (NurigoMessageNotReceivedException exception) {
    	  // 발송에 실패한 메시지 목록 확인
    	  System.out.println(exception.getFailedMessageList());
    	  System.out.println(exception.getMessage());
    	  
    	} catch (Exception exception) {
    		
    	  System.out.println(exception.getMessage());
    	  
    	}
    }
	
	
}
