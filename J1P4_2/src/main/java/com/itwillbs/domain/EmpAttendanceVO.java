package com.itwillbs.domain;

import java.sql.Date;
import java.sql.Time;

import lombok.Data;

@Data
public class EmpAttendanceVO {
	
	public int empAttend_no;
	public int user_no;
	
	public Date attend_date;
	public Time commute_time;
	public Time quitting_time;
	public String work_status;
	public String check_status;
	
	public String vacation_status;
	public String vacation_reason;
	public Date vacation_start;
	public Date vacation_end;
	public String vacation_approval;
	public String reject_reason;
	
	// 캘린더 출력용 이름
	public String v_name;
	public String formatted_date;

}
