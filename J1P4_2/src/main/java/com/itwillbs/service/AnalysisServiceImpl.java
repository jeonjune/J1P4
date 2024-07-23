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
}
