package com.itwillbs.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class RecipientVO {
	private Integer recipient_no;
	private Integer noti_no;
	private String recipient_mem;
	private String recipient_user;
		
	private NotificationVO nVO;
	private String message;
	private String noti_date;
	private String noti_type;

}
