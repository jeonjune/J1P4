package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class HealthMonitorVO {
	
	private Integer inbody_no;
	private Integer manager_no;
	private Integer mem_no;
	private String exercise_goal;
	private double height;
	private double weight;
	private double fat;
	private double fat_mass;
	private double muscle;
	private double muscle_mass;
	private double belly_fat;
	private double bmi;
	private int bmr;
	private String inbody_date;
	private String consult_content;
	private String manager_name;

	
}
