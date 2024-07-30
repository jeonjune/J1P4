<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/myMenu.jsp"%>



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
						(${myP.job } ${myP.job_rank })</h2>
					<div class="card" style="margin-top: 20px;">
						<div class="card-body">
							<strong><i class="far fa-file-alt mr-1 cardMy"></i> 이번달 출근 현황 </strong>
							<br> <br>
							출석 <br>
							지각 <br>
							반차 <br>
							휴가 <br>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



</div>


<%@ include file="../include/footer.jsp"%>