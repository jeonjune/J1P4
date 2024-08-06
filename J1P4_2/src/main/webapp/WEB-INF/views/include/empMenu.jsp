<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->

<nav class="main-header navbar navbar-expand navbar-white navbar-light" style="z-index: 2;">
	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/vacation/vacation"
			role="button"><i class="fas">직원일정</i></a></li>
		<c:if test="${sess_job.equals('관리자') }">	
			<li class="nav-item"><a class="nav-link"
				href="/employee/empList"
				role="button"><i class="fas">직원리스트</i></a></li>
		</c:if>
		<c:if test="${sess_rank.equals('관리자')||sess_rank.equals('팀장') }">	
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
		</c:if>
			
			
	</ul>

</nav>