<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/employee/empList"
			role="button"><i class="fas">직원리스트</i></a></li>
		<li class="nav-item"><a class="nav-link"
			href="/vacation/vacation"
			role="button"><i class="fas">직원일정</i></a></li>
			
		<li class="dropdown">
		    <button class="btn nav-item dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: rgba(0, 0, 0, .5);">
		     <i class="fas">휴가관리</i>
		    </button>
		    <ul class="dropdown-menu">
		        <li><a class="dropdown-item" href="/vacation/yVacList">휴가 리스트</a></li>
		        <li><a class="dropdown-item" href="/vacation/vacList">신청중 휴가</a></li>
		        <li><a class="dropdown-item" href="/vacation/nVacList">반려된 휴가</a></li>
		    </ul>
		</li>	
			
			
	</ul>

</nav>