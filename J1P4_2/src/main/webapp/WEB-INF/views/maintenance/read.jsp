<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/facMenu.jsp"%>

<div class="content-wrapper p-3" style="min-height: 831px;">

<!-- 	<h1>read</h1> -->
	 
					<div class="card" style="margin-bottom: 30px;">
						<div class="card-body">
							<div class="d-flex justify-content-between">
							<div><h2 class="p-1 mx-1">${name}</h2></div>
							<div>	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">내역 추가</button></div>
		</div>
							<div class="card my-2" >
							<div class="card-body">
							<strong><i class="far fa-file-alt mr-1 cardMy"></i> 이번달 유지보수 현황 </strong><br>
							<div class="my-3 mx-2">
							<c:if test="${not empty count}">
							<c:if test="${not empty count[0].count}">
							${count[0].repair_type} ${count[0].count}번 |
							</c:if>
							<c:if test="${not empty count[1].count}">
							${count[1].repair_type} ${count[1].count}번 |
							</c:if>
							<c:if test="${not empty count[2].count}">
							${count[2].repair_type} ${count[2].count}번 <br>
							</c:if>
							</c:if>
							<c:if test="${empty count}">
							이번달 내역이 없습니다.<br>
							</c:if>
							<div class="my-3">
							<c:if test="${not empty fac}">
							<c:if test="${not empty fac[0].repair_date}">
							최근 ${fac[0].repair_type}
							${fac[0].repair_date}<br>
							</c:if>
							<c:if test="${not empty fac[1].repair_date}">
							최근 ${fac[1].repair_type}
							${fac[1].repair_date}
							</c:if>
							</c:if>
							<c:if test="${empty fac}">
							최근 내역이 없습니다.<br>
							</c:if>
							</div>
							</div>
							</div>
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

		

	<div class="my-2">
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th width="4%">번호</th>
					<th width="15%">유지보수유형</th>
					<th width="51%">특이사항</th>
					<th width="15%">유지보수날짜</th>
					<th width="15%">담당자</th>

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
		<div class="d-flex justify-content-between">
		<div>

		</div>
		
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

</div>


<!-- 상세내역 모달창 -->
<form action="" method="post" id="fm1">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="facility_no" value="${param.facility_no }">
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">유지보수 내역 추가</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">


			<section class="content">
				<div class="container-fluid">
					<div class="form-group">
						<label> 유지보수유형 </label> <select id="select_type" class="form-control"
							name="repair_type" size="1">
							<option value="" selected disabled>선택하세요.</option>
							<option value="청소">청소</option>
							<option value="점검">점검</option>
							<option value="방역">방역</option>
						</select>
					</div>

					<div class="form-group">
						<label>특이사항</label><br>
						<textarea class="form-control" id="comment" name="repair_status" rows="3" 
							placeholder="20자 이내 입력" onkeyup="up()"></textarea>
						<p style="text-align: right;"><span id="length">0</span> / 20자<p>
					</div>

					<div class="form-group">
						<label>유지보수날짜</label> <input type="date" name="repair_date" id="repair_date"
							class="form-control" />
					</div>

					<div class="form-group">
						<label>담당자</label> <input type="text" name="name" id="name"
							class="form-control" value="${sess_name }"/>
					</div>

					<button type="button" class="btn btn-primary" id="submitButt">추가</button>

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