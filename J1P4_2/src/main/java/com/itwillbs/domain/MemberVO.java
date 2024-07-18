package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberVO {
	private Integer mem_no;
	private String mem_name;
	private String mem_birth;
	private Integer mem_gender;
	private String mem_phone;
	private Integer sms_opt;
	private String mem_email;
	private Integer email_opt;
	private Date reg_date;
	private Integer mem_rank;
	private String mem_note;
	private Integer class_status;
	private Integer class_time;
	private String mem_addr1;
	private String mem_addr2;
	
}
