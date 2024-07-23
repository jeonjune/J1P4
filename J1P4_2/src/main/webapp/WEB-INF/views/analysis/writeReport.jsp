<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/analysis/totalMemAnalysis"
			role="button"><i class="fas">전체 회원 분석</i></a></li>
		<li class="nav-item"><a class="nav-link"
			href="/analysis/writeReport"
			role="button"><i class="fas"> 보고서 작성</i></a></li>
	</ul>

</nav>

<div class="content-wrapper" style="min-height: 831px;">
writeReport.jsp
</div>

<%@ include file="../include/footer.jsp"%>