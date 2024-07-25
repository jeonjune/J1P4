<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

<%-- 	${facDe} --%>
	<h1>read</h1>


	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">상세페이지 등록</button>

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
						aria-label="Rendering engine: activate to sort column ascending">유지보수유형</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">특이사항</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">유지보수날짜</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="facDe" items="${facDe }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${facDe.facility_no }</td>
						<td>${facDe.repair_type}</td>
						<td>${facDe.repair_status}</td>
						<td>${facDe.repair_date}</td>
						<td>${facDe.name }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>


<!-- 상세내역 모달창 -->
<form action="" method="post" id="fm1">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="facility_no" value="${param.facility_no }">
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">시설상세페이지</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">


			<section class="content">
				<div class="container-fluid">
					<div class="form-group">
						<label> 유지보수유형 </label> <select id="select_type"
							name="repair_type" size="1">
							<option>선택하세요.</option>
							<option value="청소">청소</option>
							<option value="점검">점검</option>
							<option value="방역">방역</option>
						</select>
					</div>

					<div class="form-group">
						<label>특이사항</label><br>
						<textarea id="comment" name="repair_status" rows="3"
							placeholder="20자이내입력" onkeyup="up()"></textarea>
						<p>글자수 <span id="length">0</span><p>
					</div>

					<div class="form-group">
						<label>유지보수날짜</label> <input type="date" name="repair_date"
							class="form-control" />
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
				url : "/maintenance/read",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					history.go(0); //새로고침
					alert("입력완료!");
				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});
 	

 	//시설상세페이지 - 특이사항 글자수 제한(20자)
 	function up(){
 		var com = document.getElementById("comment");
 		var len = document.getElementById("length");
 		var val = com.value;
 		
 		//글자수 세기
 		len.textContent = val.length;
 		//글자수 제한
 		if(val.length>20){
 			com.value = val.substring(0,20);
 			len.textContent = 20; //제한 후 글자수 업데이트
 		}
 	}
 	
 	
 	
 	
</script>



<%@ include file="../include/footer.jsp"%>