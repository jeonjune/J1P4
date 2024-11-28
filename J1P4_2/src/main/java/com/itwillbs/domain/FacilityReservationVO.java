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
	
	//시간선택(이용가능시간 3시간) 11/11
	private String time1; 
	private String time2;
	private String time3;
	private String round; //회차
	private int status_no; //결제완료시 0-> 1로 변경
	// 11/11수정끝
	
	private String rsv_day; // 요일
	private String field; //분야
	private String facility_name; //시설이름
	private int count_people; //인원수
	private String rsv_status; // '예약완료'
	private int price; //가격
	private int total_time; //이용시간
	private int total_price; // 총 가격(결제금액)
	
	private String keyword; //검색키워드

	
	
}
