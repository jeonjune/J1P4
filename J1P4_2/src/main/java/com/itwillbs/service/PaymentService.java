package com.itwillbs.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.persistence.PaymentDAO;

@Service
public class PaymentService {

    @Autowired
    private PaymentDAO paymentDAO;

    public void savePayment(PaymentVO payment) {
        paymentDAO.insertPayment(payment);
    }
    
    //-----11/23일 환불기능구현 시작
    
    //결제취소 로직
    public String cancelPayment(int facNo) throws Exception {
        // 1. 예약 번호를 기반으로 merchant_id 조회
        String merchantId = paymentDAO.getMerchantId(facNo);
        System.out.println("멀찬트아이디: " + merchantId);

        if (merchantId == null || merchantId.isEmpty()) {
            throw new Exception("Merchant ID를 찾을 수 없습니다.");
        }

        // 2. 아임포트 토큰 발급
        String accessToken = getAccessToken();

        // 3. 아임포트 결제 취소 API 호출
        Map<String, String> cancelData = new HashMap<>();
        cancelData.put("merchant_uid", merchantId); // Key 이름 수정: 아임포트는 'merchant_uid'를 사용합니다.

        ResponseEntity<JsonNode> response = callIamportCancelAPI(accessToken, cancelData);

        // 4. 결제 취소 성공 여부 확인
        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            JsonNode responseBody = response.getBody();

            // 성공 여부 확인 (code == 0일 때 성공)
            if (responseBody.get("code").asInt() == 0) {
                // 결제 취소 성공 시 상태 업데이트
                paymentDAO.payStatus(facNo, "결제취소");
                System.out.println("결제 상태가 '결제취소'로 업데이트되었습니다.");
            } else {
                // 실패 시 메시지 확인
                throw new Exception("결제 취소 실패: " + responseBody.get("message").asText());
            }
        } else {
            throw new Exception("결제 취소 실패: HTTP 상태 코드 " + response.getStatusCode());
        }

        return "결제 및 예약 취소가 완료되었습니다.";
    }

    
    
    // 아임포트 토큰 발급
    private String getAccessToken() throws Exception {
        // REST API 키와 Secret
        String impKey = "8664108458872175";
        String impSecret = "snT9VMqh9kiXUN5lge2u6BJjHlUTeKAhRjrhO1zZilec3r2whfEVTo5klmCNBT0jaV2hhXQXdrR0exMc";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> tokenRequest = new HashMap<>();
        tokenRequest.put("imp_key", impKey);
        tokenRequest.put("imp_secret", impSecret);

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(tokenRequest, headers);
        ResponseEntity<JsonNode> response = new RestTemplate()
            .postForEntity("https://api.iamport.kr/users/getToken", requestEntity, JsonNode.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            return response.getBody().get("response").get("access_token").asText();
        } else {
            throw new Exception("토큰 발급 실패: " + response.getBody());
        }
    }

    
 // 아임포트 결제 취소 API 호출
    private ResponseEntity<JsonNode> callIamportCancelAPI(String accessToken, Map<String, String> cancelData) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", accessToken);

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(cancelData, headers);

        // RestTemplate 사용
        return new RestTemplate().postForEntity("https://api.iamport.kr/payments/cancel", requestEntity, JsonNode.class);
    }

    
    //-----11/23일 환불기능구현 끝
    
    
}
