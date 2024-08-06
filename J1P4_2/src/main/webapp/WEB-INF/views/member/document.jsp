<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/memMenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="card cardCustom">
		<div class="card-header" style="margin-bottom: 30px">
			<h2 class="card-title" style="margin-left: 150px;">회원 기본정보</h2>
		</div>

		<div class="col-md-10" style="margin-left: 150px;">

			<div class="card">
				<div class="card-body">
					<div style="position: absolute; right: 30px;">
						<a href="/member/list">
							<button type="button" class="btn btn-light">뒤로가기</button>
						</a>
						<button class="btn btn-primary" type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
							aria-controls="offcanvasRight">수정하기</button>
					</div>
					<c:if test="${readMem.mem_rank == '장기회원'}">
						<span class="badge badge-success right"><strong><i
								class="fas fa-crown"></i> VIP</strong></span>
					</c:if>
					<c:if test="${readMem.mem_rank == '신규회원'}">
						<span class="badge badge-success right"><strong><i
								class="fas fa-seedling"></i> NEW</strong></span>
					</c:if>
					<c:if test="${readMem.mem_rank == '일반회원'}">
						<span class="badge badge-success right"><strong><i
								class="fas fa-user"></i> MEM</strong></span>
					</c:if>
					<span class="badge badge-light right"> <c:if
							test="${readMem.class_status == 1}">
					미수강<br>
						</c:if> <c:if test="${readMem.class_status == 0}">
					수강중<br>
						</c:if></span>
					<h2 style="margin-top: 10px;">${readMem.mem_name }님
						(${readMem.formatted_mem_phone })</h2>
					<div class="card" style="margin-top: 20px;">
						<div class="card-body">
							<strong><i class="far fa-file-alt mr-1 cardMy"></i> 메모 </strong>
							<br> <br><div style="white-space:pre;"><c:out value="${readMem.mem_note}"/></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="d-flex justify-content-center" style="margin-top: 20px;">

			<div class="col-md-5" style="display: inline-block;">

				<div class="cardMy">
					<strong><i class="fas fa-phone mr-1 cardMx"></i> 연락처 </strong>
					<c:if test="${readMem.sms_opt == 1}">
						<span class="badge badge-warning right badgeCustom"> 수신 동의
						</span>
					</c:if>
					<c:if test="${readMem.sms_opt == 0}">
						<span class="badge badge-info right badgeCustom"> 수신 미동의 </span>
					</c:if>
					<p class="text-muted cardMy">${readMem.formatted_mem_phone}</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="far fa-heart mr-1 cardMx"></i> 생년월일</strong>
					<p class="text-muted cardMy">${readMem.mem_birth }</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="fas fa-venus-mars mr-1 cardMx"></i> 성별</strong>
					<p class="text-muted cardMy">
						<c:if test="${readMem.mem_gender == 1}">
					여자<br>
						</c:if>
						<c:if test="${readMem.mem_gender == 0}">
					남자<br>
						</c:if>
					</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="far fa-file-alt mr-1 cardMx"></i> 생일</strong>
					<p class="text-muted cardMy">${readMem.mem_birth }</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="far fa-folder-open mr-1 cardMx"></i> 수강
						상태</strong>
					<p class="text-muted cardMy">
						<c:if test="${readMem.class_status == 1}">
					미수강<br>
						</c:if>
						<c:if test="${readMem.class_status == 0}">
					수강중<br>
						</c:if>
					</p>
				</div>

			</div>
			<div class="col-md-5" style="display: inline-block;">


				<div class="cardMy">
					<strong><i class="far fa-envelope mr-1 cardMx"></i> 이메일 </strong>
					<c:if test="${readMem.email_opt == 1}">
						<span class="badge badge-warning right badgeCustom"> 수신 동의
						</span>
					</c:if>
					<c:if test="${readMem.email_opt == 0}">
						<span class="badge badge-info right badgeCustom"> 수신 미동의 </span>
					</c:if>
					<p class="text-muted cardMy">${readMem.mem_email}</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="fas fa-map-marker-alt mr-1 cardMx"></i>
						주소</strong>
					<p class="text-muted cardMy">${readMem.mem_addr1}${readMem.mem_addr2}</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="fas fa-star mr-1 cardMx"></i> 회원 등급</strong>
					<p class="text-muted cardMy">${readMem.mem_rank}</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="far fa-calendar mr-1 cardMx"></i> 등록일</strong>
					<p class="text-muted cardMy">${readMem.reg_date}</p>
				</div>
				<hr>
				<div class="cardMy">
					<strong><i class="far fa-regular fa-clock mr-1 cardMx"></i>
						수강 시간</strong>
					<p class="text-muted cardMy">${readMem.class_time}시간</p>
				</div>

			</div>
		</div>

	</div>

	<!-- 회원 수정창 (모달) -->
	<form action="" method="post" id="fm1" name="fm1">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="hidden" name="mem_no"
			value="${param.mem_no}" />
		<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
			aria-labelledby="offcanvasRightLabel">
			<div class="offcanvas-header">
				<h5 id="offcanvasRightLabel">회원수정</h5>
				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="offcanvas-body">


				<section class="content">
					<div class="container-fluid">
						<div class="form-group">
							<label>이름</label> <input type="text" name="mem_name"
								value="${readMem.mem_name }" class="form-control">
						</div>
						<div class="form-group">
							<label>생년월일</label> <input type="date" name="mem_birth"
								value="${readMem.mem_birth }" class="form-control" />
						</div>

						<div class="form-group">
							<label>연락처</label> <input type="text" name="mem_phone"
								value="${readMem.formatted_mem_phone }" class="form-control" maxlength="13" oninput="formatPhoneNumber(this)"> <label
								class="chkboxCustom"> <input type="checkbox"
								name="sms_opt" style="accent-color: #cdb4db;" value="1">&nbsp;sms
								수신 동의
							</label>
						</div>

						<div class="form-group">
							<label>이메일</label> <input type="text" name="mem_email"
								value="${readMem.mem_email }" class="form-control"> <label
								class="chkboxCustom"> <input type="checkbox"
								style="accent-color: #cdb4db;" name="email_opt" value="1">&nbsp;이메일
								수신 동의
							</label>
						</div>
						<div class="form-group">
							<label>메모</label> <br>
							<textarea class="form-control" name="mem_note" rows="5" cols="38"><c:out value="${readMem.mem_note }" /></textarea>
						</div>
						<div class="form-group">
							<label>주소</label>
							<div class="input-group">
								<input type="button" onclick="sample6_execDaumPostcode()"
									value="주소 찾기" class="btn btn-dark btn-sm"> <input
									type="text" id="sample6_address" placeholder="주소"
									name="mem_addr1" class="form-control"
									value="${readMem.mem_addr1 }">
							</div>
						</div>
						<div class="form-group">
							<label>상세주소</label> <input type="text" id="sample6_detailAddress"
								placeholder="상세주소" name="mem_addr2" class="form-control"
								value="${readMem.mem_addr2 }">
						</div>


						<button type="button" class="btn btn-primary" id="submitButt">수정하기</button>

					</div>
				</section>
			</div>
		</div>

	</form>
</div>


<%@ include file="../include/footer.jsp"%>