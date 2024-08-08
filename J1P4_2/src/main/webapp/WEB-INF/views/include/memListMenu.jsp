<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light" style="z-index: 2;">


	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/member/list"
			role="button"><i class="fas">회원 리스트</i></a></li>
	</ul>

</nav>

<script>
$(document).ready(function() {
    const currentUrl = window.location.href;

    $('.navbar-nav .nav-link').each(function() {
        const linkUrl = $(this).attr('href');
        if (currentUrl.includes(linkUrl)) {
            $(this).addClass('active');
        }
    });
});
    </script>