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
  font-size: 24px;
  font-weight: bold;
  text-align : center;
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
							<strong><i class="far fa-file-alt mr-1 cardMy"></i> 올 해 연차 현황 </strong>
							<br> <br>
							<div class="centered-circle"><span>총 연차 <br>12</span></div>
							
							<div class="centered-circle"><span>연차 <br>12</span></div>
							
							<div class="centered-circle"><span>반차 <br>12</span></div>
							
							<div class="centered-circle"><span>남은 연차 <br>12</span></div>
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








</div>


<%@ include file="../include/footer.jsp"%>