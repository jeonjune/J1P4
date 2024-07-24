package com.itwillbs.service;

import java.util.Map;

public interface AnalysisService {

	// 총 회원 수
	public int totalMemCount() throws Exception;

	// 이번달 신규 회원 수
	public int newMemCount() throws Exception;

	// 이번달 등록 회원 수
	public int regMemCount() throws Exception;	

	// 이번달 등록 회원 수/ 총 회원 수 
	public double rmcTmc() throws Exception;	
	
	// 6개월간 월 별 신규 회원 수
	public Map<String, Integer> new6MemCount() throws Exception;
}
