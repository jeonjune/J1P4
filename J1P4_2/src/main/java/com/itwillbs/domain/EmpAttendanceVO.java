package com.itwillbs.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EmpAttendanceVO {
	
	public int empAttend_no;
	public int user_no;
	
	public Date attend_date;
	public Date commute_time;
	public Date quitting_time;
	public String vacation_status;
	public String vacation_reason;
	public String vacation_approval;
	public String rejevt_reason;
	

}
