package com.itwillbs.domain;

import com.itwillbs.domain.PaymentVO;
import com.itwillbs.domain.RegistrationVO;

import lombok.Data;

@Data
public class RegistrationPaymentRequest {
    private RegistrationVO registration;
    private PaymentVO paymentInfo;
    
}
