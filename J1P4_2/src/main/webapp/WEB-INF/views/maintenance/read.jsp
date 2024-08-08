<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/facMenu.jsp"%>



<style type="text/css">

.centered-circle {
  width: 100px;
  height: 100px;
  background-color: #a2d2ff;
  border-radius: 50%;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  color: #ffffff; 
  font-size: 24px;
  font-weight: bold;
  text-align : center;
}
</style>



<div class="content-wrapper" style="min-height: 831px;">

	<h1>read</h1>
	 <div class="centered-circle"><span>출근일 수 <br>${countAtt }</span></div>
	<h2 style="margin-top: 10px;">${name}
						</h2>
					<div class="card" style="margin-top: 20px;">
						<div class="card-body">
							<strong><i class="far fa-file-alt mr-1 cardMy"></i> 월 유지보수 현황 </strong>
							<br> <br><div style="white-space:pre;">
							<c:out value="${count[0].repair_type}"></c:out>
							<c:out value="${count[0].count}"></c:out>
							<c:out value="${count[1].repair_type}"></c:out>
							<c:out value="${count[1].count}"></c:out>
							<c:out value="${count[2].repair_type}"></c:out>
							<c:out value="${count[2].count}"></c:out>
							
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-virus2" viewBox="0 0 16 16">
  <path d="M8 0a1 1 0 0 0-1 1v1.143c0 .557-.407 1.025-.921 1.24-.514.214-1.12.162-1.513-.231l-.809-.809a1 1 0 1 0-1.414 1.414l.809.809c.394.394.445.999.23 1.513C3.169 6.593 2.7 7 2.144 7H1a1 1 0 0 0 0 2h1.143c.557 0 1.025.407 1.24.921.214.514.163 1.12-.231 1.513l-.809.809a1 1 0 0 0 1.414 1.414l.809-.809c.394-.394.999-.445 1.513-.23.514.214.921.682.921 1.24V15a1 1 0 1 0 2 0v-1.143c0-.557.407-1.025.921-1.24.514-.214 1.12-.162 1.513.231l.809.809a1 1 0 0 0 1.414-1.414l-.809-.809c-.393-.394-.445-.999-.23-1.513.214-.514.682-.921 1.24-.921H15a1 1 0 1 0 0-2h-1.143c-.557 0-1.025-.407-1.24-.921-.214-.514-.162-1.12.231-1.513l.809-.809a1 1 0 0 0-1.414-1.414l-.809.809c-.394.393-.999.445-1.513.23-.514-.214-.92-.682-.92-1.24V1a1 1 0 0 0-1-1Zm2 5a1 1 0 1 1-2 0 1 1 0 0 1 2 0M7 7a1 1 0 1 1-2 0 1 1 0 0 1 2 0m1 5a1 1 0 1 1 0-2 1 1 0 0 1 0 2m4-4a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
</svg> <c:out value="${fac[0].repair_type}"></c:out>
							<c:out value="${fac[0].repair_date}"></c:out>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tools" viewBox="0 0 16 16">
  <path d="M1 0 0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.27 3.27a.997.997 0 0 0 1.414 0l1.586-1.586a.997.997 0 0 0 0-1.414l-3.27-3.27a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3q0-.405-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814zm9.646 10.646a.5.5 0 0 1 .708 0l2.914 2.915a.5.5 0 0 1-.707.707l-2.915-2.914a.5.5 0 0 1 0-.708M3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026z"/>
</svg> <c:out value="${fac[1].repair_type}"></c:out>
							<c:out value="${fac[1].repair_date}"></c:out>
							</div>
						</div>
					</div>

	<form action="" method="get" class='actionForm'>
	<input type="hidden" value="${param.facility_no }" name="facility_no">
		<div class="content">
						<input type="radio" value="전체" class="btn-check btn-check-all" 
							id="radioRepair0"> <label
							class="btn btn-outline-dark radioField" for="radioRepair0">전체</label>
						<input type="radio" value="점검" class="btn-check btn-check-type" name="repair_type"
							id="radioRepair1"> <label
							class="btn btn-outline-dark radioField" for="radioRepair1">점검</label>
						<input type="radio" value="방역" class="btn-check btn-check-type" name="repair_type"
							id="radioRepair2"> <label
							class="btn btn-outline-dark radioField" for="radioRepair2">방역</label>
						<input type="radio" value="청소" class="btn-check btn-check-type" name="repair_type"
							id="radioRepair3" > <label
							class="btn btn-outline-dark radioField" for="radioRepair3">청소</label>
					</div>
	</form>				
	
	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">상세페이지 등록</button>
		

	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
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
	<!-- 페이징 처리 -->
			<ul class="pagination" >
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.repair_type}">
							<a
								href="/maintenance/read?facility_no=${param.facility_no }&page=${pageVO.startPage-1 }"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.repair_type}">
							<a
								href="/maintenance/read?facility_no=${param.facility_no }&repair_type=${pageVO.cri.repair_type }&page=${pageVO.startPage-1 }"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if>
					</li>
				</c:if>
				<c:forEach var="i" begin="${pageVO.startPage }"
					end="${pageVO.endPage }" step="1">
					<li
						class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.repair_type}">
							<a href="/maintenance/read?facility_no=${param.facility_no }&page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.repair_type}">
							<a
								href="/maintenance/read?facility_no=${param.facility_no }&repair_type=${pageVO.cri.repair_type }&page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if>
					</li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.repair_type}">
							<a
								href="/maintenance/read?facility_no=${param.facility_no }&page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.repair_type}">
							<a
								href="/maintenance/read?facility_no=${param.facility_no }&repair_type=${pageVO.cri.repair_type }&page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if>
					</li>
				</c:if>
			</ul>

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
						<label> 유지보수유형 </label> <select id="select_type" class="form-control"
							name="repair_type" size="1">
							<option value="">선택하세요.</option>
							<option value="청소">청소</option>
							<option value="점검">점검</option>
							<option value="방역">방역</option>
						</select>
					</div>

					<div class="form-group">
						<label>특이사항</label><br>
						<textarea class="form-control" id="comment" name="repair_status" rows="3" 
							placeholder="20자이내입력" onkeyup="up()"></textarea>
						<p>글자수 <span id="length">0</span><p>
					</div>

					<div class="form-group">
						<label>유지보수날짜</label> <input type="date" name="repair_date" id="repair_date"
							class="form-control" />
					</div>

					<div class="form-group">
						<label>담당자</label> <input type="text" name="name" id="name"
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
			
			//빈칸검사
			  var comment = $('#comment').val();
		      var repair_date = $('#repair_date').val();
		      var name = $('#name').val();
			        
	        if (comment == "" || repair_date == "" || name == "") {
	            alert("빈칸을 모두 입력해주세요.");
	            return;
	        }
	       
	        if($('#select_type').val() == ""){
	        	   alert("선택하지 않은 필드를 선택해주세요.");
	            return;
	          } 
			
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
 	
 	$(function() {
		$('.btn-check-type')
				.click(
						function() {
							
							$(".actionForm").submit();

						});

	});
 	
 	$(function() {
		$('.btn-check-all')
				.click(
						function() {
							
							window.location.href = '/maintenance/read?facility_no=${param.facility_no}';

						});

	});
 	
 	$(function() {
	 	if ('${param.repair_type}' == '${pageVO.cri.repair_type}') {
	 		if ('${param.repair_type}'=='') {
	 			$(".btn-check-all").attr('checked', true);
	 		}
	 		$(":radio[name='repair_type'][value='${param.repair_type}']").attr('checked', true);
	 	}
 	});
 	
</script>



<%@ include file="../include/footer.jsp"%>