package com.itwillbs.domain;

import lombok.Data;

@Data
public class Criteria  {

	private int page;
	private int pageSize;
	private String keyword;
	private String memYear;
	private String filter;
	private String sort;
	private String sortCri;
	private String sortVal;
	private String mem_gender;
	private int sms_opt;
	private int email_opt;
	private String searchType;


	public Criteria() {
		this.page = 1;
		this.pageSize = 10;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page <=0) {
			this.page = 1;
			return;
		}
		this.page = page;
//		this.page = (page-1) * 10; // 페이징 처리 - 시작하는 위치(페이지X)
		
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 2;
			return;
		}
		this.pageSize = pageSize;
	}
	
	// 페이징 처리에서 필요한 시작 위치 계산 (mapper에서만 사용)
	public int getPageStart() {
		
		return (this.page - 1) * (this.pageSize);
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageSize=" + pageSize + ", keyword=" + keyword + ", memYear=" + memYear
				+ ", filter=" + filter + ", sort=" + sort + ", sortCri=" + sortCri + ", sortVal=" + sortVal
				+ ", mem_gender=" + mem_gender + ", sms_opt=" + sms_opt + ", email_opt=" + email_opt + ", searchType="
				+ searchType + "]";
	}

	
	
}
