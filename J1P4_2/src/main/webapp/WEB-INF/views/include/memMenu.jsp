<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-primary navbar-dark">
	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/member/read?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button">기본페이지</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/details?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button">상세페이지</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/monitoring?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button">건강모니터링</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/document?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button">회원문서</a></li>
	</ul>
	
	<div style="position:absolute; right: 0; padding-right: 10px;">	
	<a href="/member/readModify?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"><button type="button" class="btn btn-info">수정하기</button></a>
	<a href="/member/list">
	<button type="button" class="btn btn-light">뒤로가기</button></a>
	</div>

</nav>