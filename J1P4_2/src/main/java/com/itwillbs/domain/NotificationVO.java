package com.itwillbs.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NotificationVO {
	private Integer noti_no;
	private Integer sender_user;
	private String noti_type;
	private String message;
	private Date noti_date;
	private Integer noti_check;
}
