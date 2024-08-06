<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>accessErr.jsp</h1>
	
	${auth } <hr>
	${auth.principal}<hr>
	${auth.principal.username}<hr>
	${auth.principal.password}<hr>
	${auth.details}<hr>
	${auth.details.remoteAddress}<hr>
	
	${SPRING_SECURITY_403_EXCEPTION.getMessage() }
	
	<h1><a href="/all">메인페이지로 이동</a></h1>
</body>
</html>