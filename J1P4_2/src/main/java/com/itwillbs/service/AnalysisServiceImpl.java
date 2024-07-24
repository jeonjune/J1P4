package com.itwillbs.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.persistence.AnalysisDAO;

@Service
public class AnalysisServiceImpl implements AnalysisService {

	private static final Logger logger = LoggerFactory.getLogger(AnalysisServiceImpl.class);
	
	@Inject
	private AnalysisDAO adao;

	// 총 회원 수
	@Override
	public int totalMemCount() throws Exception {
		logger.info("totalMemCount() 실행");
		
		return adao.totalMemCount();
	}

	// 이번 달 신규 회원 수
	@Override
	public int newMemCount() throws Exception {
		logger.info("newMemCount() 실행");
		
		return adao.newMemCount();
	}

	// 이번 달 등록 회원 수
	@Override
	public int regMemCount() throws Exception {
		logger.info("regMemCount() 실행");
		
		return adao.regMemCount();
	}

	// 이번 달 등록 회원 수 / 총 회원 수
	@Override
	public double rmcTmc() throws Exception {
		logger.info("rmcTmc() 실행");
		
		return adao.rmcTmc();
	}
	
	
}
