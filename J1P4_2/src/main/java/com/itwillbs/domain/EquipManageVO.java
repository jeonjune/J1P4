package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class EquipManageVO {
	
	private int equipment_no; //장비번호 pk
	private Integer manager_no; //담당자번호
	private String equipment_name; //장비이름
	private Integer cost; //비용
	private Integer total; //총 비용
	private String manufacturer; //제조사
	private Integer count; //장비개수
	private String equipment_status; //장비상태
	private Date approval_date; //승인날짜
	private Date report_date; //작성날짜
	private String field; // 분야 - 수영,필라테스...등등
	private String name; //담당자이름
	private String e_repair_type; //장비보수유형 - 구입/수리/폐기
	private String repair_reason; //유지보수사유
	private String equipment_reject; //반려사유

	
	
}
