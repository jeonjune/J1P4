package com.itwillbs.persistence;

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
}
