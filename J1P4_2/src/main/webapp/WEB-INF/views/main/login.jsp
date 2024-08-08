<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>J1P4 Sports</title>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&amp;display=fallback">

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/plugins/fontawesome-free/css/all.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/adminlte.min.css?v=3.2.0">
<script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            if (error === 'true') {
                document.getElementById('error-message').textContent = '아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.';
                document.getElementById('error-message').style.display = 'block';
            }
        }
    </script>
</head>
<body class="login-page" style="min-height: 496.781px;">
	<div class="login-box" style=" ">
		<div class="login-logo">
			<a href="../../index2.html"><b>J1P4</b> Sports</a>
		</div>

		<div class="card">
			<div class="card-body login-card-body">
				<p class="login-box-msg">환영합니다. 오늘도 일 하셔야죠.</p>
				<form action="/login" method="post">
				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="ID" name="username">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
					<div class="input-group mb-3">
						<input type="password" class="form-control" placeholder="Password" name="password">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
					<p id="error-message" style="color: red; display: none;"></p>
					<div class="row">
<!-- 						<div class="col-8"> -->
<!-- 							<div class="icheck-primary"> -->
<!-- 								<input type="checkbox" id="remember"> <label -->
<!-- 									for="remember"> Remember Me </label> -->
<!-- 							</div> -->
<!-- 						</div> -->

						<div class="col-4">
							<input type="submit" class="btn btn-primary btn-block" value="Sign in">
						</div>

					</div>
				</form>

			</div>

		</div>
	</div>


	<script src="${pageContext.request.contextPath }/resources/plugins/jquery/jquery.min.js"></script>

	<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

	<script src="${pageContext.request.contextPath }/resources/dist/js/adminlte.min.js?v=3.2.0"></script>


</body>
</html>