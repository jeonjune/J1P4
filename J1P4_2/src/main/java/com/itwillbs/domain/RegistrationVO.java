package com.itwillbs.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class RegistrationVO {
	private Integer registration_no;
    private Integer schedule_no;
    private Integer mem_no;
    private Date registration_date;
    private int class_count;
    
    private List<MemberVO> memList;
    private List<EmployeeVO> empList;
    private List<ClassScheduleVO> classScheduleList;
}
