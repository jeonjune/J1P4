<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/member/read?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button"><i class="fas fa-bars"> 기본페이지</i></a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/details?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button"><i class="fas fa-bars"> 상세페이지</i></a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/monitoring?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button"><i class="fas fa-bars"> 건강모니터링</i></a></li>
		<li class="nav-item"><a class="nav-link"
			href="/member/document?mem_no=${param.mem_no }&page=${param.page==null? 1:param.page}"
			role="button"><i class="fas fa-bars"> 회원문서</i></a></li>
	</ul>

</nav>