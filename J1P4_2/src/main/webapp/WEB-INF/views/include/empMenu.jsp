<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Navbar -->

<nav class="main-header navbar navbar-expand navbar-white navbar-light" style="z-index: 3;">

		 <style>
       .navbar-nav .nav-link {
            color: black; /* 기본 색상 */
            position: relative;
            display: inline-block;
        }
        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            display: block;
            margin-top: 5px;
            left: 50%;
            transform: translateX(-50%);
            background: black;
            transition: width 0.3s;
        }
        .navbar-nav .nav-link:hover::after {
            width: 80%; /* 밑줄 길이 조정 */
        }
        .navbar-nav .nav-link.active::after {
            width: 80%; /* 활성화된 메뉴의 밑줄 길이 조정 */
        }
    </style>

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
		        <li><a class="dropdown-item nav-link" href="/vacation/yVacList">휴가 리스트</a></li>
		        <li><a class="dropdown-item nav-link" href="/vacation/vacList">신청중 휴가</a></li>
		        <li><a class="dropdown-item nav-link" href="/vacation/nVacList">반려된 휴가</a></li>
		    </ul>
		</li>	
		</c:if>
			
			
	</ul>

</nav>

<script>
$(document).ready(function() {
    const currentUrl = window.location.href;
    $('.navbar-nav .nav-link').each(function() {
        const linkUrl = $(this).attr('href');
        if (linkUrl === '/employee/empList' && (currentUrl.includes('/employee/empList') || currentUrl.includes('/employee/empDetail'))) {
            $(this).addClass('active');
        } else if (linkUrl === '/maintenance/list' && (currentUrl.includes('/maintenance/list') || currentUrl.includes('/maintenance/detail') || currentUrl.includes('/maintenance/updateDetail'))) {
            $(this).addClass('active');
        } else if (currentUrl.includes(linkUrl)) {
            $(this).addClass('active');
        }
    });
    });
    </script>