package com.itwillbs.domain;

import java.util.Date;

import lombok.Data;

@Data
public class DailyAttendanceVO {
	private int classSchedule_no;
    private int mem_no;
    private Date attendance_date;
    
 // 기본 생성자
    public DailyAttendanceVO() {}

 // 매개변수 있는 생성자
    public DailyAttendanceVO(int classSchedule_no, int mem_no) {
        this.classSchedule_no = classSchedule_no;
        this.mem_no = mem_no;
    }
}
