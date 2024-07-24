package com.itwillbs.service;

public interface AnalysisService {

	// 총 회원 수
	public int totalMemCount() throws Exception;

	// 이번달 신규 회원 수
	public int newMemCount() throws Exception;

	// 이번달 등록 회원 수
	public int regMemCount() throws Exception;	

	// 이번달 등록 회원 수/ 총 회원 수 
	public double rmcTmc() throws Exception;	
}
