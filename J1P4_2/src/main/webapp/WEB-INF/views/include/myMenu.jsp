<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-primary navbar-dark" style="z-index: 2;">
	<!--     Left navbar links -->
	<ul class="navbar-nav" style="margin-left: 150px;">
		<li class="nav-item"><a class="nav-link"
			href="/employee/myPage"
			role="button">마이페이지</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/employee/attend?date=${date[0].formatted_date }"
			role="button">출석정보</a></li>
		<li class="nav-item"><a class="nav-link"
			href="/employee/myVacation"
			role="button">휴가관리</a></li>
	</ul>
	
	

</nav>