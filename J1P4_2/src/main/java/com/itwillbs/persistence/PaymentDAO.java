package com.itwillbs.persistence;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.itwillbs.domain.PaymentVO;

@Repository
public class PaymentDAO {

    private static final String NAMESPACE = "com.itwillbs.mapper.PaymentMapper";

    @Autowired
    private SqlSession sqlSession;

    public void insertPayment(PaymentVO payment) {
        sqlSession.insert(NAMESPACE + ".insertPayment", payment);
    }
    
    
	//------------11/23일 환불기능 시작
	//merchant_id 조회
	public String getMerchantId(int facNo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".getMerchantId", facNo);
	}
	//결제 상태 업데이트
	public void payStatus(int facNo, String status) throws Exception {
		System.out.println("실행이닷");
		Map<String, Object> params = new HashMap<>();
        params.put("faReservation_no", facNo);
        params.put("status", status);

        sqlSession.update(NAMESPACE + ".payStatus", params);
		
	}
	
	//---------------11/23일 환불기능 끝
    
    
    
}
