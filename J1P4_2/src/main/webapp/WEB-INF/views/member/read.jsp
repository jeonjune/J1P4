<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/memMenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="col-sm-13">

		<div class="card">
			<div class="card-header">
				<h2 class="card-title">회원 기본정보</h2>
			</div>


			<div class="card-body ">
				<strong><i class="fas fa-user mr-1"></i> 이름</strong>

				<div class="card">
					<div class="card-body">
						<h2>${readMem.mem_name }님</h2>
					</div>
				</div>

				<div class="col-md-6" style="display: inline-block;">


					<strong><i class="fas fa-phone mr-1"></i> 연락처</strong>
					<p class="text-muted">
						<c:if test="${readMem.sms_opt == 1}">
							<span class="badge badge-warning right"> 수신 동의 </span>
						</c:if>
						<c:if test="${readMem.sms_opt == 0}">
							<span class="badge badge-info right" style="color: #000;">
								수신 미동의 </span>
						</c:if>
						${readMem.mem_phone}
					</p>
					<hr>
					<strong><i class="far fa-heart mr-1"></i> 생일</strong>
					<p class="text-muted">${readMem.mem_birth }</p>
					<hr>
					<strong><i class="fas fa-venus-mars mr-1"></i> 성별</strong>
					<p class="text-muted">
					<c:if test="${readMem.mem_gender == 1}">
					여자<br>
						</c:if>
						<c:if test="${readMem.mem_gender == 0}">
					남자<br>
						</c:if>
					</p>
					<hr>
					<strong><i class="far fa-file-alt mr-1"></i> 생일</strong>
					<p class="text-muted">${readMem.mem_birth }</p>
					<hr>
					<strong><i class="far fa-folder-open mr-1"></i> 수강 상태</strong>
					<p class="text-muted">
					<c:if test="${readMem.class_status == 1}">
					미수강<br>
						</c:if>
						<c:if test="${readMem.class_status == 0}">
					수강중<br>
						</c:if>
					</p>
					

				</div>
				<div class="col-md-5" style="display: inline-block;">


					<strong><i class="far fa-envelope mr-1"></i> 이메일</strong>
					<p class="text-muted">
						<c:if test="${readMem.email_opt == 1}">
							<span class="badge badge-warning right"> 수신 동의 </span>
						</c:if>
						<c:if test="${readMem.email_opt == 0}">
							<span class="badge badge-info right" style="color: #000;">
								수신 미동의 </span>
						</c:if>
						${readMem.mem_email}
					</p>
					<hr>
					<strong><i class="fas fa-map-marker-alt mr-1"></i> 주소</strong>
					<p class="text-muted">${readMem.mem_addr1}${readMem.mem_addr2}</p>
					<hr>
					<strong><i class="fas fa-star mr-1"></i> 회원등급</strong>
					<p class="text-muted">${readMem.mem_rank}</p>
					<hr>
					<strong><i class="far fa-calendar mr-1"></i> 등록일</strong>
					<p class="text-muted">${readMem.reg_date}</p>
					<hr>
					<strong><i class="far fa-regular fa-clock mr-1"></i> 수강 시간</strong>
					<p class="text-muted">${readMem.class_time}시간</p>
					
				</div>
				<hr>
				<strong><i class="far fa-file-alt mr-1"></i> 특이 사항</strong>
				<p class="text-muted">${readMem.mem_note}</p>
			</div>
		</div>

	</div>

</div>

<%@ include file="../include/footer.jsp"%>