<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1> customLogout.jsp </h1>
	
	<!-- 로그아웃 처리 -->
	<!-- 로그아웃에 대한 처리(POST) 동작은 시큐리티 내부에서 처리 -->
	<form action="/customLogout" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>