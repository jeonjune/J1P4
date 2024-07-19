package com.itwillbs.domain;

import lombok.Data;

@Data
public class InstructorVO {
	private int instructorNo;
    private int userNo;
    private String expertise;
    private String name; // employee 테이블에서 가져온 강사 이름
}
