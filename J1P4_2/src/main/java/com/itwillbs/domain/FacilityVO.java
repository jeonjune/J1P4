package com.itwillbs.domain;

import java.util.List;

import lombok.Data;

@Data
public class FacilityVO {
	
	//시설테이블
	private int facility_no; //시설번호
	private Integer manager_no; //담당자 번호
	private String facility_name; //시설이름
	private String name; //담당자이름
	
	private List<FacilityVO> facilityList;
	
	
}
