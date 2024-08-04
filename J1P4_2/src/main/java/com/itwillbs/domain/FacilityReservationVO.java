package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class FacilityReservationVO {
	
	private int faReservation_no; // 예약번호
	private int facility_no; //시설번호
	private int manager_no; //담당자번호
	private int mem_no; // 회원번호
	private String rsv_name; //예약자
	private String rsv_phone; //예약자 폰번호
	private Date rsv_date; //예약날짜
	private String start_time; //시작시간
	private String end_time; //종료시간
	private String rsv_day; // 요일
	private String field; //분야
	private String facility_name; //시설이름
	private int count_people; //인원수
	private String rsv_status; // '예약완료'
	
	private String keyword; //검색키워드

	
	
}
