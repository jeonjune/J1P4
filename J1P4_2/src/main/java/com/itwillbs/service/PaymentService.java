package com.itwillbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itwillbs.domain.PaymentVO;
import com.itwillbs.persistence.PaymentDAO;

@Service
public class PaymentService {

    @Autowired
    private PaymentDAO paymentDAO;

    public void savePayment(PaymentVO payment) {
        paymentDAO.insertPayment(payment);
    }
}
