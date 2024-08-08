package com.itwillbs.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PaymentVO {
	private int paymentNo;
    private int registrationNo;
    private Date paymentDate;
    private int amount;
    private String paymentStatus;
    private String paymentMethod;
    private String transactionId;
    private String merchantId;
}
