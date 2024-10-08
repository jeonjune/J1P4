<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/myMenu.jsp"%>
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
  font-size: 22px;
  font-weight: bold;
  text-align : center;
}
</style>
    <script>

		// 휴가시작 종료일 반차일때 같은날로 고정하기
			function syncAndLockDate(status) {
		    var startDate = document.getElementById("vacation_start").value;
		    if (startDate) {
		        var start = new Date(startDate);
		        if (status === "오후반차") {
		            start.setDate(start.getDate() + 1); // 오후 반차인 경우 하루를 더함
		        }
		        var endDate = document.getElementById("vacation_end");
		        endDate.value = start.toISOString().split('T')[0]; // 날짜를 YYYY-MM-DD 형식으로 설정
		        endDate.readOnly = true;
		    }
		}
		
		// 휴가 상태를 확인하고 날짜를 동기화 및 고정하는 함수
		function checkVacationStatus() {
		    var status = document.getElementById("vacation_status").value;
		    if (status === "오전반차" || status === "오후반차") {
		        syncAndLockDate(status);
		    } else {
		        var endDate = document.getElementById("vacation_end");
		        endDate.value = "";
		        endDate.readOnly = false;
		    }
		}

	    </script>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="card cardCustom">
		<div class="card-header" style="margin-bottom: 30px">
			
		</div>

		<div class="col-md-10" style="margin-left: 150px;">

			<div class="card">
				<div class="card-body">
					<div style="position: absolute; right: 30px;">
					<!-- 페이징 처리 -->
	                  <div class="card-tools justify-content-end m-3">
	                    <form action="" method="get" class="myDateForm">
	                    <div class="form-inline" style="display: inline-block;">
	                    <c:if test="${not empty year }">
	                    <select class="form-control" id="selectMyDate" name="date">
	                    	<c:forEach items="${year}" var="item">
    						<option value="${item.formatted_date}">${item.formatted_date}</option>
						</c:forEach>
	                    </select>
	                    </c:if>
	                    </div>
					<button class="btn btn-primary" type="button" style="display: inline-block;"
							 data-bs-toggle="modal" data-bs-target="#vaModal">휴가신청</button>	
	                    </form>
	            	    </div>
						
							 
					</div>
					<c:if test="${myP.job_rank == '관리자'}">
						<span class="badge badge-success right"><strong><i
								class="fas fa-crown"></i> 관리자</strong></span>
					</c:if>
					<c:if test="${myP.job_rank == '사원'}">
						<span class="badge badge-success right"><strong><i
								class="fas fa-seedling"></i> 사원</strong></span>
					</c:if>
					<c:if test="${myP.job_rank == '팀장'}">
						<span class="badge badge-success right"><strong><i
								class="fas fa-user"></i> 팀장</strong></span>
					</c:if>
<%-- 					<span class="badge badge-light right"> <c:if --%>
<%-- 							test="${readMem.class_status == 1}"> --%>
<!-- 					미수강<br> -->
<%-- 						</c:if> <c:if test="${readMem.class_status == 0}"> --%>
<!-- 					수강중<br> -->
<%-- 						</c:if></span> --%>
					<h2 style="margin-top: 10px;">${myP.name }님
						<c:if test="${myP.job_rank == '관리자'}">(${myP.job })</c:if>
						<c:if test="${myP.job_rank == '팀장' || myP.job_rank == '사원' }">(${myP.job } ${myP.job_rank })</c:if>
					</h2>
					<div class="card" style="margin-top: 20px;">
						<div class="card-body">
							<strong><i class="far fa-calendar mr-1 cardMy"></i> 올 해 연차 현황 </strong>
							<br> <br>
							<div class="centered-circle mx-2"><span>총 연차 <br>12</span></div>
							
							<div class="centered-circle mx-2"><span>연차 <br>${countVa }</span></div>
							
							<div class="centered-circle mx-2"><span>반차 <br>${countHalf }</span></div>
							
							<div class="centered-circle mx-2"><span>남은 연차 <br>${leftVa }</span></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<table id="example1" class="table table-bordered table-hover"
					style="background: #fff" aria-describedby="example1_info">
					<thead>
						<tr>
						
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">휴가 종류</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">휴가 시작일</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">휴가 종료일</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">휴가 사유</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">상태</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">반려이유</th>
								

						</tr>
						
					</thead>
					<tbody>
						<c:forEach var="myVaca" items="${myVaca }">
							<tr class="odd">
								<td class="dtr-control" tabindex="0">${myVaca.vacation_status }</td>
								<td class="dtr-control" tabindex="0">${myVaca.vacation_start }</td>
								<td>${myVaca.vacation_end }</td>
								<td>${myVaca.vacation_reason }</td>
								<td>${myVaca.vacation_approval }</td>
								<td>${myVaca.reject_reason }</td>
							</tr>
						</c:forEach>
					</tbody>
		
				</table>
			</div>
		</div>
		
	</div>

    <!-- 휴가 모달창 시작 -->
	<div class="modal fade" id="vaModal" tabindex="-1"
		aria-labelledby="vaModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="vaModalLabel">휴가 신청서</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 모달창 바디(본문) -->
				<form action="" method="post" id="fm1" name="fm1">
 					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="modal-body">
					<div class="m-2">
					<div class="accordion-item">
					<div class="textRight">
						<select name="vacation_status" id="vacation_status" class="form-control" onchange="checkVacationStatus()">
							<option value="휴가">휴가</option>
							<option value="오전반차">오전 반차</option>
							<option value="오후반차">오후 반차</option>
							<option value="기타">기타 휴가</option>
						</select>
					</div>
					</div>
					<div class="form-group">
						<label>휴가 시작일</label> 
						<input type="date" name="vacation_start" class="form-control" id="vacation_start"  onchange="checkVacationStatus()" />
					</div>
					<div class="form-group">
						<label>휴가 종료일(출근일)</label>
						<input type="date" name="vacation_end" class="form-control" id="vacation_end" />
					</div>
					<p><span id="length">0</span> / 500자<p>
					<textarea rows="20" cols="200" name="vacation_reason" id="vacation_reason" 
					class="form-control" onkeyup="up()" placeholder="휴가 사유를 입력하세요."></textarea>
					</div>
				 <span id="checkModal" style="font-size: 14px;"></span>	
				</div>
				</form>

				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary vaSendBtn"
						>전송하기</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 휴가 신청 모달창 끝 -->






</div>




<script>
$(document).ready(function(){
	$('.vaSendBtn').click(function(){
		
		
		//빈칸검사
	    var vacation_start = $('#vacation_start').val();
        var vacation_end = $('#vacation_end').val();
        var vacation_reason = $('#vacation_reason').val();
        
        if (vacation_start == "" || vacation_end == "" || vacation_reason == "") {
        	  $('#checkModal')
				.html(
					 '빈칸을 모두 입력해주세요.')
				.css('color', 'red');
	            return;
	        }else {
	        	 $('#varModal').modal('hide');
        	}
		
		
		function getCurrentYear() {
		    const date = new Date();
		    return date.getFullYear();
		}
		
		var year = getCurrentYear();
		
		$.ajax({
			url : "/vacation/vacation",
			type : "POST",
			data : $("#fm1").serialize(),
			success : function(data) {
				if(data === "endVa"){
					Swal.fire({
						  icon: "error",
						  title: "휴가소진",
						  text: "올해 휴가를 다 썼군요!",
						});
//	 				alert("남은 휴가가 없습니다.");					
					}else if(data === "overVa"){
					Swal.fire({
						  icon: "error",
						  title: "휴가부족",
						  text: "남은 휴가보다 많이 신청했습니다!",
						});
//	 				alert("남은 휴가보다 많이 신청했습니다.");
						
					}else {					
					alert("휴가 신청완료 되었습니다.");
					window.location.href = '/employee/myVacation?date='+year;
					}
				},
			error : function() {
				alert("오류발생");
			}
		});
	});
});

/* 메시지 입력 내용 글자수 제한 */
	function up(){
		var com = document.getElementById("vacation_reason");
		var len = document.getElementById("length");
		var val = com.value;
		//글자수 세기
		len.textContent = val.length;
		
		//글자수 제한
		if(val.length>500){
			com.value = val.substring(0,500);
			len.textContent = 500; //제한 후 글자수 업데이트
		}
	}
	
	$("#selectMyDate").change(function() {

		$(".myDateForm").submit();
	});

	$("#selectMyDate").val("${param.date }");

</script>

<%@ include file="../include/footer.jsp"%>