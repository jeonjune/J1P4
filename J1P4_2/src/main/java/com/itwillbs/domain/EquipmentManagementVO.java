package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class EquipmentManagementVO {
	
	//장비관리 테이블
	
	private int equipment_no; //장비번호 pk
	private Integer manager_no; //담당자번호
	private String equipment_name; //장비이름
	private Integer cost; //비용
	private String manufacturer; //제조사
	private String equipment_status; //장비상태
	private Date purchase_date; //구입날짜
	
	private String repair_reason; //유지보수사유
	private String repair_approval; //유지보수승인(미승인/승인/반려)
	private String equipment_reject; //반려사유
	
	
	
}
