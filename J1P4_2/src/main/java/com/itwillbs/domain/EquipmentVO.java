package com.itwillbs.domain;

import java.util.List;

import lombok.Data;

@Data
public class EquipmentVO {
	
	//장비테이블
	private int equipment_no; //장비번호
	private Integer manager_no; //담당자번호
	private int facility_no; //시설번호
	private Integer count; //수량
	
	
	//private List<EquipmentVO> equipmentList;
	
}
