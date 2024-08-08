<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/memMenu.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="card cardCustom">
		

		<div class="col-md-10" style="margin-left: 150px; margin-top: 30px; margin-bottom: 10px;">

			<div class="card">
				<div class="card-body">
					<div style="position: absolute; right: 30px;">
							<button type="button" class="btn btn-light" onclick="goBack()">뒤로가기</button>
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
					<p class="text-muted cardMy">${readMem.mem_birth } ( 만 ${readMem.mem_age }세 )</p>
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
					<strong><i class="far fa-clock mr-1 cardMx"></i> 강의 누적 기간</strong>
					<c:if test="${not empty counting }">
					<p class="text-muted cardMy">${counting } 일</p>
					</c:if>
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
					<strong><i class="far fa-regular fa-file mr-1 cardMx"></i>
						계약서</strong>
					<c:if test="${!fileList.file_name.equals('no') }">
					<p class="text-muted cardMy">
					<a href="/maintenance/download?fileName=${fileList.file_name }">${fileList.file_name }</a></p>					
					</c:if>
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
							<label>이름</label> <input type="text" name="mem_name" id="mem_name"
								value="${readMem.mem_name }" class="form-control">
						</div>
						<div class="form-group">
							<label>생년월일</label> <input type="date" name="mem_birth" id="mem_birth"
								value="${readMem.mem_birth }" class="form-control" />
						</div>

						<div class="form-group">
							<label>연락처</label> <input type="text" name="mem_phone" id="mem_phone"
								value="${readMem.formatted_mem_phone }" class="form-control" maxlength="13" oninput="formatPhoneNumber(this)"> <label
								class="chkboxCustom"> <input type="checkbox"
								name="sms_opt" style="accent-color: #cdb4db;" value="1">&nbsp;sms
								수신 동의
							</label>
						</div>

						<div class="form-group">
							<label>이메일</label> <input type="text" name="mem_email" id="mem_email"
								value="${readMem.mem_email }" class="form-control"> <label
								class="chkboxCustom"> <input type="checkbox"
								style="accent-color: #cdb4db;" name="email_opt" value="1">&nbsp;이메일
								수신 동의
							</label>
						</div>
						<div class="form-group">
							<label>메모</label> <br>
							<textarea class="form-control" name="mem_note" rows="5" cols="38" id="mem_note"><c:out value="${readMem.mem_note }" /></textarea>
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

<script>
	$(function() {
		$("#submitButt").click(function() {
			
			//빈칸검사
			   var mem_name = $('#mem_name').val();
		       var mem_birth = $('#mem_birth').val();
		       var mem_phone = $('#mem_phone').val();
		       var mem_email = $('#mem_email').val();
		       var mem_note = $('#mem_note').val();
		       var sample6_address = $('#sample6_address').val();
		       var sample6_detailAddress = $('#sample6_detailAddress').val();
		       
		        if (mem_name == "" || mem_birth == "" || mem_phone =="" ||
		        	mem_email ==""|| mem_note =="" || 
		        	sample6_address =="" || sample6_detailAddress == "") {
		            alert("빈칸을 모두 입력해주세요.");
		            return;
		        }
			
			// 전화번호 필드에서 하이픈 제거
	        $("input[name='mem_phone']").each(function() {
	            var cleanedPhone = $(this).val().replace(/-/g, '');
	            $(this).val(cleanedPhone);
	        });
				$.ajax({
					
					
					url : "/member/memUpdate",
					type : "POST",
					data : $("#fm1").serialize(),
					success : function(data) {
						alert("회원정보가 수정되었습니다.");
	
						history.go(0);
	
					},
					error : function() {
						alert("오류발생");
					}
				});
		});
	});

	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById("sample6_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("sample6_detailAddress").focus();
			}
		}).open();
	}
	
	$(":checkbox[name='sms_opt'][value='${readMem.sms_opt}']").attr('checked', true);
	$(":checkbox[name='email_opt'][value='${readMem.email_opt}']").attr('checked', true);
	
	// 연락처 입력 시 자동으로 하이픈 추가
	function formatPhoneNumber(input) {
		let value = input.value.replace(/\D/g, ''); // 숫자 이외의 문자 제거
        let formattedValue = '';
        
        if (value.length <= 3) {
            formattedValue = value;
        } else if (value.length <= 7) {
            formattedValue = value.replace(/(\d{3})(\d{0,4})/, '$1-$2');
        } else {
            formattedValue = value.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
        }
        
        input.value = formattedValue;
    }
	function goBack() {
        window.history.back();
    }

</script>


<%@ include file="../include/footer.jsp"%>