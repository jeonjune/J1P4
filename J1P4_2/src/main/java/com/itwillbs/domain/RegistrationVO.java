package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RegistrationVO {
	private Integer registration_no;
    private Integer schedule_no;
    private Integer mem_no;
    private Date registration_date;
}
