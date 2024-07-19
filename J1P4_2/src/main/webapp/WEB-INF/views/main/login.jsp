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
</head>
<body class="login-page" style="min-height: 496.781px;">
	<div class="login-box" style=" ">
		<div class="login-logo">
			<a href="../../index2.html"><b>J1P4</b> Sports</a>
		</div>

		<div class="card">
			<div class="card-body login-card-body">
				<p class="login-box-msg">환영합니다. 오늘도 일 하셔야죠.</p>
				<form action="../../index3.html" method="post">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="ID">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
					</div>
					<div class="input-group mb-3">
						<input type="password" class="form-control" placeholder="Password">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-8">
							<div class="icheck-primary">
								<input type="checkbox" id="remember"> <label
									for="remember"> Remember Me </label>
							</div>
						</div>

						<div class="col-4">
							<button type="submit" class="btn btn-primary btn-block">Sign
								In</button>
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