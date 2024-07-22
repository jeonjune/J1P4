<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-wrapper" style="min-height: 831px;">

	<!-- 검색 / 필터 / 정렬 데이터 전송 -->
	<form action="" method="get">

		<div class="form-inline">
			<!-- 검색 키워드 입력창 -->
			<div class="input-group">
				<input class="form-control" type="search" name="keyword"
					value="${param.keyword }" placeholder="Search" aria-label="Search">
				<div class="input-group-append">
					<button class="btn" type="submit" class="submitBtn">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
			</div>
			<!-- 필터 모달창 버튼 -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#exampleModal">
				<i class="fas fa-filter fa-fw"></i>
			</button>
		</div>

		<!-- 사용자가 선택한 필터를 보여주는 공간 -->
		<div class="filter1" style="display: inline-block;">
			<!-- 사용자가 필터를 사용하여 검색했을 때 선택한 필터를 보여주는 공간 -->
			<c:if test="${not empty param.filter }">
				<div class="border border-1 rounded-3 p-2" role="group"
					style="width: 120px; margin-bottom: 20px; background-color: #fff;">
					<!-- 선택한 필터 삭제 버튼 -->
					<button class="removeFi btn-close" aria-label="Close"
						style="width: 1px; position: absolute;"></button>
					<!-- hidden으로 숨겨서 필터 정보를 전달 -->
					<input type="hidden" value="${param.filter }" name="filter">
					<span
						style="padding-left: 20px; font-size: 16px; font-weight: bold;">${param.filter }</span>
				</div>
			</c:if>
		</div>
		<div class="filter2" style="display: inline-block;">
			<c:if test="${not empty param.memYear }">
				<div class="border border-1 rounded-3 p-2" role="group"
					style="width: 120px; margin-bottom: 20px; background-color: #fff;">
					<button class="removeFi btn-close" aria-label="Close"
						style="width: 1px; position: absolute;"></button>
					<input type="hidden" value="${param.memYear }" name="memYear">
					<span
						style="padding-left: 20px; font-size: 18px; font-weight: bold;">${param.memYear }</span>
				</div>
			</c:if>
		</div>

		<!-- 행 개수 선택 -->
		<div style="text-align: right;">
			<select name="pageSize" id="selectPage">
				<option value="10">10개씩 보기</option>
				<option value="50">50개씩 보기</option>
				<option value="100">100개씩 보기</option>
			</select>
		</div>

	</form>

	<!-- 모달창 시작 -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">필터하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 모달창 바디(본문) -->
				<div class="modal-body">

					<h5>회원등급</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check" name="filter"
							id="radioWf1"> <label
							class="btn btn-outline-dark radioField" for="radioWf1">신규회원</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter"
							id="radioWf2"> <label
							class="btn btn-outline-dark radioField" for="radioWf2">일반회원</label>
						<input type="radio" value="장기회원" class="btn-check" name="filter"
							id="radioWf3"> <label
							class="btn btn-outline-dark radioField" for="radioWf3">장기회원</label>
					</div>
					<hr>
					<h5>성별</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check" name="filter2"
							id="radioWf4"> <label
							class="btn btn-outline-dark radioField" for="radioWf4">남자</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter2"
							id="radioWf5"> <label
							class="btn btn-outline-dark radioField" for="radioWf5">여자</label>
					</div>
					<hr>
					<h5>수신동의여부</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check" name="filter3"
							id="radioWf6"> <label
							class="btn btn-outline-dark radioField" for="radioWf6">동의</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter3"
							id="radioWf7"> <label
							class="btn btn-outline-dark radioField" for="radioWf7">미동의</label>
					</div>
					<hr>
					<h5>연도별</h5>
					<input type="month" id="monthInput">년

				</div>

				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary filterBtn"
						data-bs-dismiss="modal">필터 적용</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 모달창 끝 -->

	<!-- 회원 리스트 출력 -->
	<div class="col-sm-12">
		<table id="example1" class="table table-bordered table-hover"
			style="background: #fff" aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting"><input type="checkbox" class="chkGrp"
						id="chkAll"></th>
					<th class="sorting">NO</th>
					<th class="sorting">회원이름</th>
					<th class="sorting">연락처</th>
					<th class="sorting">회원등급</th>
					<th class="sorting">등록일</th>
					<th class="sorting">강의 누적 기간</th>
					<th class="sorting">현재 수강상태</th>
					<th class="sorting">메모</th>
				</tr>
			</thead>
			<tbody class="test">
				<c:forEach var="vo" items="${memberList }">
					<tr class="tr:hover">
						<td class="dtr-control" tabindex="0"><input type="checkbox"
							class="chkGrp"></td>
						<td class="dtr-control" tabindex="0">${vo.mem_no }</td>
						<td class=""><a
							href="/member/read?mem_no=${vo.mem_no }&page=${param.page==null? 1:param.page}">${vo.mem_name }</a></td>
						<td>${vo.mem_phone }</td>
						<td>${vo.mem_rank }</td>
						<td>${vo.reg_date }</td>
						<td class="sorting_1">${vo.class_time }</td>
						<td>${vo.class_status }</td>
						<td>${vo.mem_note }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 페이징 처리 (기존 페이지) -->
	<c:if
		test="${empty param.keyword and empty param.memYear and empty param.filter }">
		<div class="col-sm-12 col-md-7">
			<div class="dataTables_paginate paging_simple_numbers"
				id="example1_paginate">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="paginate_button page-item previous"
							id="example1_previous"><a
							href="/member/list?page=${pageVO.startPage-1 }"
							aria-controls="example1" data-dt-idx="0" tabindex="0"
							class="page-link">«</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }"
						end="${pageVO.endPage }" step="1">
						<li
							class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }"><a
							href="/member/list?page=${i }" aria-controls="example1"
							data-dt-idx="1" tabindex="0" class="page-link">${i }</a></li>
					</c:forEach>
					<c:if test="${pageVO.next && pageVO.endPage > 0 }">
						<li class="paginate_button page-item next" id="example1_next"><a
							href="/member/list?page=${pageVO.endPage+1 }"
							aria-controls="example1" data-dt-idx="7" tabindex="0"
							class="page-link">»</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</c:if>

	<!-- 페이징 처리 (검색 후 페이지) -->
	<c:if
		test="${not empty param.keyword or not empty param.memYear or not empty param.filter }">
		<div class="col-sm-12 col-md-7">
			<div class="dataTables_paginate paging_simple_numbers"
				id="example1_paginate">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="paginate_button page-item previous"
							id="example1_previous"><a
							href="/member/list?keyword=${pageVO.cri.keyword }
						&memYear=${pageVO.cri.memYear }&filter=${pageVO.cri.filter }&page=${pageVO.startPage-1 }"
							aria-controls="example1" data-dt-idx="0" tabindex="0"
							class="page-link">«</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }"
						end="${pageVO.endPage }" step="1">
						<li
							class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }"><a
							href="/member/list?keyword=${pageVO.cri.keyword }
						&memYear=${pageVO.cri.memYear }&filter=${pageVO.cri.filter }&page=${i }"
							aria-controls="example1" data-dt-idx="1" tabindex="0"
							class="page-link">${i }</a></li>
					</c:forEach>
					<c:if test="${pageVO.next && pageVO.endPage > 0 }">
						<li class="paginate_button page-item next" id="example1_next"><a
							href="/member/list?keyword=${pageVO.cri.keyword }
						&memYear=${pageVO.cri.memYear }&filter=${pageVO.cri.filter }&page=${pageVO.endPage+1 }"
							aria-controls="example1" data-dt-idx="7" tabindex="0"
							class="page-link">»</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</c:if>

	<button class="btn btn-primary" type="button">삭제하기</button>
	<!-- 회원 등록 버튼 -->
	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">등록하기</button>

	<!-- 회원 등록창 (모달) -->
	<form action="" method="post" id="fm1" name="fm1">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
			aria-labelledby="offcanvasRightLabel">
			<div class="offcanvas-header">
				<h5 id="offcanvasRightLabel">회원등록</h5>
				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="offcanvas-body">


				<section class="content">
					<div class="container-fluid">
						<!-- mem_name, mem_birth, mem_gender, mem_phone, sms_opt, mem_email, email_opt, mem_note, mem_addr1, mem_addr2
                   -->
						<div class="form-group">
							<label>이름</label> <input type="text" name="mem_name"
								class="form-control">
						</div>

						<div class="form-group">
							<label>생일</label> <input type="date" name="mem_birth"
								class="form-control" />
						</div>

						<div class="form-group">
							<label>성별</label><br> <input type="radio" name="mem_gender"
								value="0">남 <input type="radio" name="mem_gender"
								value="1">여
						</div>

						<div class="form-group">
							<label>전화번호</label> sms 수신동의<input type="radio" name="sms_opt"
								value="1"> <input type="text" name="mem_phone"
								class="form-control">
						</div>

						<div class="form-group">
							<label>이메일</label> 이메일 수신동의<input type="radio" name="email_opt"
								value="1"> <input type="text" name="mem_email"
								class="form-control">
						</div>
						<div class="form-group">
							<label>메모</label> <input type="text" name="mem_note"
								class="form-control" />
						</div>
						<div class="form-group">
							<label>주소</label> <input type="button"
								onclick="sample6_execDaumPostcode()" value="주소 찾기"
								class="btn btn-dark btn-sm"> <input type="text"
								id="sample6_address" placeholder="주소" name="mem_addr1"
								class="form-control">
						</div>
						<div class="form-group">
							<label>상세주소</label> <input type="text" id="sample6_detailAddress"
								placeholder="상세주소" name="mem_addr2" class="form-control">
						</div>


						<button type="button" class="btn btn-primary" id="submitButt">등록</button>

					</div>
				</section>
			</div>
		</div>

	</form>

</div>

<script>
	/* 사용자가 선택한 필터 출력 */
	$(function() {
		$('.filterBtn')
				.click(
						function() {
							// 							$(".filter").empty();

							let filter = $('input[name=filter]:checked').val();
							let memYear = $('#monthInput').val();

							if (filter != undefined) {
								$('.filter1')
										.html(
												'<div class="border border-1 rounded-3 p-2" role="group" style="width: 120px; margin-bottom: 20px; background-color:#fff;">'
														+ '<button class="removeFi btn-close" aria-label="Close" style="width: 1px; position: absolute;"></button>'
														+ '<input type="hidden" name="filter" value="'+filter+'">'
														+ '<span style="padding-left: 20px;font-size: 16px; font-weight: bold;">'
														+ filter
														+ '</span></div></p>');
							}

							if (memYear != "") {
								$('.filter2')
										.html(
												'<div class="border border-1 rounded-3 p-2" role="group" style="width: 120px; margin-bottom: 20px; background-color:#fff;">'
														+ '<button class="removeFi btn-close" aria-label="Close" style="width: 1px; position: absolute;"></button>'
														+ '<input type="hidden" name="memYear" value="'+memYear+'">'
														+ '<span style="padding-left: 20px;font-size: 18px; font-weight: bold;">'
														+ memYear
														+ '</span></div></p>');
							}

						});

	});

	/* 선택한 필터 삭제 */
	$(document).on('click', '.removeFi', function() {
		$(this).parent().remove()
	});

	/* 최상위 체크박스 클릭 시 전체 체크박스 선택 */
	$(function() {
		$("#chkAll").click(function() {
			$(".chkGrp").attr("checked", this.checked);
		});

	});

	$(function() {
		$("#submitButt").click(function() {
			$.ajax({
				url : "/member/memJoin",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					alert("회원이 등록 되었습니다.");

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
</script>

<%@ include file="../include/footer.jsp"%>