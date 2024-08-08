<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/facMenu.jsp"%>
<div class="content-wrapper p-3" style="min-height: 831px; padding-top: 20px;">

	<div class="my-1" >
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th width="4%">번호</th>
					<th width="48%">시설이름</th>
					<th width="48%">담당자</th>

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
<div class="d-flex justify-content-between align-items-center">
<div></div>
	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">등록</button>
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
						<label>담당자</label> <input type="text" name="name" id="name"
							value="${sess_name }" class="form-control" />
					</div>

					<button type="button" class="btn btn-primary" id="submitButt" >등록</button>

				</div>
			</section>
		</div>
	</div>

</form>



<script>
	$(function() {
		$("#submitButt").click(function() {
			console.log($("#fm1").serialize());
			
			//빈칸검사
			  var facility_name = $('#facility_name').val();
		      var name = $('#name').val();
			        
	        if (facility_name == "" || name == "") {
	            alert("빈칸을 모두 입력해주세요.");
	            return;
	        }
			
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