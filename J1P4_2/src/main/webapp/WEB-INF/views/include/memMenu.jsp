<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-primary navbar-dark" style="z-index: 2;">
	<!--     Left navbar links -->
	<ul class="navbar-nav" style="margin-left: 150px;">
		<li class="nav-item"><a class="nav-link"
			href="/member/read?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button">기본페이지</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/details?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button">상세페이지</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/monitoring?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}&pageStart=0"
			role="button">건강모니터링</a></li>
	</ul>
	
	

</nav>