package com.itwillbs.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class EmployeeVO {
	
	private int user_no;
	private String user_id;
	private String user_pw;
	
	private String job_rank;
	private String job;
	private String name;
	
	private Date birth_date;
	private boolean gender;
	
	private String phone_no;
	private String email;
	
	private Date emp_date;
	private boolean retire_status;
	private Date retire_date;
	
	private int zip_code;
	private String addr1;
	private String addr2;
	private String enabled;
	
	// 조인을 수행하는 테이블의 정보 저장
	//private AuthVO authVO; // 1:1 구조
	private List<AuthVO> authList; // 1:N 구조
	
	
	
	

}
