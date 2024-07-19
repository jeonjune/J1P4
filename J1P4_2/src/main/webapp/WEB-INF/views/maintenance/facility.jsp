<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<div class="content-wrapper" style="min-height: 831px;">


	<h1>facility</h1>
	<%-- ${facList} <br> --%>


	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">등록하기</button>
	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-striped dataTable dtr-inline"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">시설번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">시설이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="facility" items="${facList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${facility.facility_no }</td>
						<td class=""><a
							href="/maintenance/read?facility_no=${facility.facility_no }">${facility.facility_name }</a></td>
						<td>${facility.name }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>


<!-- 시설등록 모달 -->
<form action="" method="post" id="fm1">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">시설등록</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">


			<section class="content">
				<div class="container-fluid">

					<div class="form-group">
						<label>시설이름</label> <input type="text" name="facility_name"
							class="form-control" id="facility_name">
					</div>

					<div class="form-group">
						<label>담당자</label> <input type="text" name="name"
							class="form-control" />
					</div>

					<button type="button" class="btn btn-primary" id="submitButt">등록</button>

				</div>
			</section>
		</div>
	</div>

</form>



<script>
	$(function() {
		$("#submitButt").click(function() {
			console.log($("#fm1").serialize());
			$.ajax({
				url : "/maintenance/facility",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					alert("시설이 등록 되었습니다.");

					history.go(0); //새로고침
				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});
</script>


<%@ include file="../include/footer.jsp"%>