package com.itwillbs.domain;

import lombok.Data;

@Data
public class TimeTableVO {
	
	private int id; //pk
	private String round; //회차
	private String time; //시간대
	private int facility_no; //시설번호
	private int status_no; //예약완료=1, 디폴트=0
	
}
