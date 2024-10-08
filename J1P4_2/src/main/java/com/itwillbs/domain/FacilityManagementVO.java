package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class FacilityManagementVO {
	
	//시설관리 테이블
	private int facility_no; //시설번호 fk
	private Integer manager_no; //담당자 번호
	private Date repair_date; //유지보수 날짜
	private String repair_type; //유지보수 유형(청소/방역/점검)
	private String repair_status; //유지보수상세
	private String name; //담당자이름
	private Integer count; // 한달간격 유지보수유형 count
	
	
}
