package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class fileVO {
	
	private int equipment_no; //장비번호
	private int file_no; //파일번호
	private String cvt_name; //파일경로
	private Date file_date; //날짜
	private String file_name; //파일이름
	
}
