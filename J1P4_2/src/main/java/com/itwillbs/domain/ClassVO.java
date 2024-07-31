package com.itwillbs.domain;

import lombok.Data;

@Data
public class ClassVO {
    private int classNo;
    private String className;
    private String description;
    private String fieldCode;
    private String divisionCode;
    private String levelCode;
    private int maxCapacity;
    private int minCapacity;         // 추가
    private int currentEnrollment;   // 추가
    private int instructorNo;
    private String instructorName;
}
