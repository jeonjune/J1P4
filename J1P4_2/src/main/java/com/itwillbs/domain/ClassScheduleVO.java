package com.itwillbs.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class ClassScheduleVO {
	private int scheduleId;
    private int classNo;
    private Date startDate;
    private Date endDate;
    private String startTimeCode;
    private String endTimeCode;
    private String recurrencePattern;
    private String recurrenceDays;
    
    private List<ClassVO> classList;
    


}
