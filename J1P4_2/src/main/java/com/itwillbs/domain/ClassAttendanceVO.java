package com.itwillbs.domain;

import lombok.Data;

@Data
public class ClassAttendanceVO {
    private int classSchedule_no;
    private int mem_no;
    private int totalClasses;
    private int attendedClasses;
    private double attendanceRate;
    private String mem_name;
    private String mem_phone;

    // Constructor
    public ClassAttendanceVO(int classSchedule_no, int mem_no) {
        this.classSchedule_no = classSchedule_no;
        this.mem_no = mem_no;
    }

    // Default constructor
    public ClassAttendanceVO() {
    }
}
