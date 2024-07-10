package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.TestVO;
import com.itwillbs.persistence.TestDAO;

@Service
public class TestServiceImpl implements TestService {
	
	@Inject
	private TestDAO tdao;

	@Override
	public void test(TestVO vo) {
		tdao.test(vo);
	}
	
	
}
