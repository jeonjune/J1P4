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
  box-shadow: 0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
}
</style>


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
	                    <div class="form-inline">
	                    <c:if test="${not empty date }">
	                    <select class="form-control" id="selectMyDate" name="date">
	                    	<c:forEach items="${date }" var="date">
							<option value="${date.formatted_date }">${date.formatted_date }</option>
						</c:forEach>
	                    </select>
	                    </c:if>
	                    </div>
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
							<strong><i class="far fa-calendar mr-1 cardMy"></i> 
								${param.date } 출근 현황 </strong>
							<br> <br>
							<div class="centered-circle mx-2"><span>출근 <br>${countAtt }</span></div>
							
							<div class="centered-circle mx-2"><span>지각 <br>${countLate }</span></div>

							<div class="centered-circle mx-2"><span>반차 <br>${countHalf }</span></div>
							
							<div class="centered-circle mx-2"><span>연차 <br>${countVa }</span></div>
							
						</div>
					</div>
				</div>
			</div>
			
						<div class="col-sm-12">
				<table id="example1" class="table table-bordered table-hover"
					style="background: #fff" aria-describedby="example1_info">
					<thead>
						<tr>
						<!-- empAttend_no, attend_date, commute_time, quitting_time, work_status, check_status, vacation_status, vacation_start, vacation_end -->
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">출근 날짜</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">출근 시간</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">퇴근 시간</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">출근 정보</th>
							<th class="sorting" tabindex="0" aria-controls="example1"
								rowspan="1" colspan="1"
								aria-label="Browser: activate to sort column ascending">휴가 정보</th>
								

						</tr>
						
					</thead>
					<tbody>
						<c:forEach var="monthWork" items="${monthWork }">
							<tr class="odd">
							 	<c:if test="${monthWork.vacation_status == null}">
								<td class="dtr-control" tabindex="0">${monthWork.attend_date }</td>
							 	</c:if>
							 	<c:if test="${monthWork.vacation_status != null}">
								<td>${monthWork.vacation_start }~${monthWork.vacation_end }</td>
							 	</c:if>
								<td class="dtr-control" tabindex="0">${monthWork.commute_time }</td>
								<td>${monthWork.quitting_time }</td>
								<td>${monthWork.check_status }</td>
								<td>${monthWork.vacation_status }</td>
							</tr>
						</c:forEach>
						
						
					</tbody>
		
				</table>
			</div>
			
			
		</div>
	</div>



</div>
<script>
$("#selectMyDate").change(function() {

	$(".myDateForm").submit();
});

$("#selectMyDate").val("${param.date }");
</script>

<%@ include file="../include/footer.jsp"%>