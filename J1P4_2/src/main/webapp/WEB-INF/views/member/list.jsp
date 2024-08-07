<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 바디 시작 -->
<div class="content-wrapper" style="min-height: 831px; padding-top:20px;">
	<div class="col-sm-12">
	<!-- 스피너 (검색 시 돌아가는 로딩바) -->
	<div class="spinner-border text-primary d-none" id="spinner"
		role="status" aria-hidden="true">
		<span class="visually-hidden">Loading...</span>
	</div>

	<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->
	<form action="" method="get" class='actionForm'>

		<div class="form-inline">
		
			<!-- 검색 -->
			<div class="input-group mb-3">
			
				<!-- 검색 타입 선택 -->
				<div class="input-group-prepend">
					<select name="searchType" id="selectType" class="form-control">
						<option value="searchAll" selected="selected">전체</option>
						<option value="searchName">이름</option>
						<option value="searchPhoneNum">연락처</option>
						<option value="searchEmail">이메일</option>
					</select>
				</div>
				
				<!-- 검색 입력창 -->
				<input class="form-control" type="search" name="keyword"
					value="${param.keyword }" placeholder="Search" aria-label="Search">
				
				<!-- 검색 버튼 -->	
				<div class="input-group-append">
					<button class="btn" type="submit" id="submitBtn"
						onclick="toggleSpinner()">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
				
			</div>
			
		</div>
		<div style="display: inline-block;">
		<!-- 필터 모달창 버튼 -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#filterModal">
				<i class="fas fa-filter fa-fw"></i>
			</button>

			<!-- 필터 지우기 버튼 -->
			<button type="button" class="btn btn-info" id="resetFilters">
				<i class="fas fa-trash fa-fw"></i>
			</button>
		</div>
		
		<!-- 사용자가 선택한 필터를 보여주는 공간 -->
		<div style="padding-left: 10px; display: inline-block;">
		<div class="filter1" style="display: inline-block;">
			<div class="deleteFilter">
				<!-- 사용자가 필터를 사용하여 검색했을 때 선택한 필터를 보여주는 공간 -->
				<c:if test="${not empty param.filter }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="filter" value="${param.filter }">${param.filter }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter2" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.memYear }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="memYear" value="${param.memYear }">${param.memYear }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter3" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.mem_gender }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="mem_gender"
							value="${param.mem_gender }"> <c:if
								test="${param.mem_gender == 0}">남자</c:if> <c:if
								test="${param.mem_gender == 1}">여자</c:if>
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter4" style="display: inline-block;">
			<c:if test="${not empty param.msg_opt }">
				<div class="border border-1 rounded-3 p-2" role="group"
					style="width: 120px; margin-bottom: 20px; background-color: #fff;">
					<button class="removeFi btn-close" aria-label="Close"
						style="width: 1px; position: absolute;"></button>
					<input type="hidden" value="chk" name="msg_opt"> <span
						style="padding-left: 20px; font-size: 18px; font-weight: bold;">
						<c:if test="${not empty param.msg_opt}">메시지만 동의</c:if>
					</span>
				</div>
			</c:if>
		</div>
		</div>

		<!-- 테이블 커스텀 (정렬 / 행 개수) -->
		<div class="content memListSort">
		
			<div>검색결과 : ${pageVO.totalCount }명</div>
			
			<!-- 정렬 기준 선택 -->
			<div id="sortRight">
				<input type="hidden" name="sortCri"> <input type="hidden"
					name="sortVal"> <input type="radio" value="mem_name"
					class="btn-check chkSort" id="radioName1"> <label
					class="btn" for="radioName1">이름순(오름차순)</label> <input type="radio"
					value="mem_name" class="btn-check chkSort" id="radioName2">
				<label class="btn" for="radioName2">이름순(내림차순)</label> <input
					type="radio" value="reg_date" class="btn-check chkSort"
					id="radioReg"> <label class="btn" for="radioReg">등록순</label>
			</div>
			
			<!-- 행 개수 선택 -->
			<div class="textRight">
				<select name="pageSize" id="selectPage" class="form-control">
					<option value="10">10개씩 보기</option>
					<option value="50">50개씩 보기</option>
					<option value="100">100개씩 보기</option>
				</select>
			</div>
			
		</div>

	</form>
	<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->

	<!-- 필터 모달창 시작 -->
	<div class="modal fade" id="filterModal" tabindex="-1"
		aria-labelledby="filterModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- 필터 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="filterModalLabel">필터하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 필터 모달창 바디(본문) -->
				<div class="modal-body">

					<h5>회원등급</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check" name="filter"
							id="radioRank1"> <label
							class="btn btn-outline-dark radioField" for="radioRank1">신규회원</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter"
							id="radioRank2"> <label
							class="btn btn-outline-dark radioField" for="radioRank2">일반회원</label>
						<input type="radio" value="장기회원" class="btn-check" name="filter"
							id="radioRank3"> <label
							class="btn btn-outline-dark radioField" for="radioRank3">장기회원</label>
					</div>
					<hr>
					<h5>성별</h5>
					<div class="content">
						<input type="radio" value=0 class="btn-check" name="mem_gender"
							id="radioGen1"> <label
							class="btn btn-outline-dark radioField" for="radioGen1">남자</label>
						<input type="radio" value=1 class="btn-check" name="mem_gender"
							id="radioGen2"> <label
							class="btn btn-outline-dark radioField" for="radioGen2">여자</label>
					</div>
					<hr>
					<h5>수신 동의 여부</h5>
					<div class="content">
						<input type="radio" value="chk" class="btn-check" name="msg_opt"
							id="radioMsg1"> <label
							class="btn btn-outline-dark radioField" for="radioMsg1">메시지만
							동의</label> <input type="radio" value="chk" class="btn-check"
							name="email_opt" id="radioMsg2"> <label
							class="btn btn-outline-dark radioField" for="radioMsg2">이메일만
							동의</label> <input type="radio" value="chk" class="btn-check"
							name="double_opt" id="radioMsg3"> <label
							class="btn btn-outline-dark radioField" for="radioMsg3">모두
							동의</label>
					</div>
					<hr>
					<h5>연도별</h5>
					<input type="month" id="monthInput">년

				</div>

				<!-- 필터 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary filterBtn"
						data-bs-dismiss="modal">필터 추가</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 필터 모달창 끝 -->

	<!-- 메시지 전송 모달창 시작 -->
	<div class="modal fade" id="smsModal" tabindex="-1"
		aria-labelledby="smsModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- 메시지 전송 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="smsModalLabel">메시지 전송</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 메시지 전송 모달창 바디(본문) -->
				<div class="modal-body">
					<div class="m-2">
					<div class="accordion-item">
					
					    <h2 class="accordion-header" id="headingTwo">
					      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					        수신 번호
					      </button>
					    </h2>
					    
					    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					      <div class="accordion-body">
							<div id="smsReceiver"></div>        
					      </div>
					    </div>
					</div>
					
					<div id="smsReceiverHidden"></div>
					
					
					<label style="font-weight: normal; margin-top: 10px;">
					<input type="checkbox" id="chkSendType">
					예약전송
					</label>
					<div id="sendDate" style="margin-bottom: 10px;">
					<input type="hidden" name="noti_date" id="currentDatetime">
					<input type="hidden" name="noti_type" value="일반전송">
					</div>
					<p><span id="length">0</span> / 500자<p>
					<textarea rows="20" cols="200" name="message" id="comment" 
					class="form-control" onkeyup="up()" placeholder="메시지 내용을 입력하세요."></textarea>
					</div>
					

				</div>

				<!-- 메시지 전송 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary smsSendBtn"
						data-bs-dismiss="modal">전송하기</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 메시지 전송 모달창 끝 -->

	<!-- 회원 리스트 출력 -->

		<table id="example1" class="table table-bordered table-hover"
			style="background: #fff; height: 100px;" aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting"><input type="checkbox" class="chkGrp"
						id="chkAll" style="accent-color: #cdb4db;" ></th>
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
							name="mem_no" class="chkGrp" value="${vo.mem_no }"
							style="accent-color: #a2d2ff;"></td>
						<td class="dtr-control" tabindex="0">${vo.mem_no }</td>
						<td class="">
							<a href="${pageContext.request.contextPath}/member/detail/${vo.mem_no}">${vo.mem_name }</a>
							
							</td>
						<td class="mem_phone">${vo.formatted_mem_phone}</td>
						<td>${vo.mem_rank }</td>
						<td>${vo.reg_date }</td>
						<td class="sorting_1">${vo.class_time }</td>
						<td>${vo.class_status }</td>
						<td>${vo.mem_note }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	


	<div class="col-sm-12">
		<div class="d-flex justify-content-between align-items-center">
		
	<!-- 하단 버튼 모음 -->	
	<div>
		<!-- 메시지 전송 버튼 -->
		<button type="button" class="btn btn-danger smsBtn" data-bs-toggle="modal"
			data-bs-target="#smsModal">
			<i class="fas fa-envelope fa-fw" style="color: #fff"></i> 메시지 발송
		</button>
		
		<!-- 회원 삭제 버튼 -->
		<button class="btn btn-primary deleteMem" type="button" style="display: inline-block;">
		<i class="fas fa-minus fa-fw"></i> 회원 삭제</button>
	
		<!-- 회원 등록 버튼 -->
		<button class="btn btn-primary" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
			aria-controls="offcanvasRight"><i class="fas fa-plus fa-fw"></i> 회원 등록</button>
	</div>
			<!-- 페이징 처리 -->
			<ul class="pagination" >
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword and empty param.memYear and empty param.filter and empty param.mem_gender
						and empty param.sortCri and empty param.sortVal}">
							<a
								href="/member/list?page=${pageVO.startPage-1 }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword or not empty param.memYear or not empty param.filter or not empty param.mem_gender
						or not empty param.sortCri or not empty param.sortVal}">
							<a
								href="/member/list?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&memYear=${pageVO.cri.memYear }&filter=${pageVO.cri.filter }
								&mem_gender=${pageVO.cri.mem_gender }&sortCri=${pageVO.cri.sortCri }&sortVal=${pageVO.cri.sortVal }&page=${pageVO.startPage-1 }&pageSize=${pageVO.cri.pageSize}"
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
							test="${empty param.keyword and empty param.memYear and empty param.filter and empty param.mem_gender
						and empty param.sortCri and empty param.sortVal}">
							<a href="/member/list?page=${i }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword or not empty param.memYear or not empty param.filter or not empty param.mem_gender
						or not empty param.sortCri or not empty param.sortVal}">
							<a
								href="/member/list?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&memYear=${pageVO.cri.memYear }&filter=${pageVO.cri.filter }
								&mem_gender=${pageVO.cri.mem_gender }&sortCri=${pageVO.cri.sortCri }&sortVal=${pageVO.cri.sortVal }&page=${i }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if>
					</li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword and empty param.memYear and empty param.filter and empty param.mem_gender
						and empty param.sortCri and empty param.sortVal}">
							<a
								href="/member/list?page=${pageVO.endPage+1 }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword or not empty param.memYear or not empty param.filter or not empty param.mem_gender
						or not empty param.sortCri or not empty param.sortVal }">
							<a
								href="/member/list?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&memYear=${pageVO.cri.memYear }&filter=${pageVO.cri.filter }
							&mem_gender=${pageVO.cri.mem_gender }&sortCri=${pageVO.cri.sortCri }&sortVal=${pageVO.cri.sortVal }&page=${pageVO.endPage+1 }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if>
					</li>
				</c:if>
			</ul>
				
		</div>
	</div>
		
		
		
		
	</div>


	<!-- 회원 등록 오프캔버스 시작 -->
	<form action="" method="post" id="fm1" name="fm1" enctype="multipart/form-data">

		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />

		<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
			aria-labelledby="offcanvasRightLabel">

			<!-- 회원 등록 오프캔버스 헤더 시작 -->
			<div class="offcanvas-header">
				<h5 id="offcanvasRightLabel">회원등록</h5>

				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>

			</div>

			<!-- 회원 등록 오프캔버스 바디 시작 -->
			<div class="offcanvas-body">

				<section class="content">
					<div class="container-fluid">
						<div class="form-group">
							<label>이름</label> <input type="text" name="mem_name"
								class="form-control">
						</div>
						<div class="form-group">
							<label>생일</label> <input type="date" name="mem_birth"
								class="form-control" />
						</div>

						<div class="form-group">
							<label>성별</label><br> <label
								style="font-weight: normal !important;"><input
								type="radio" name="mem_gender" style="accent-color: #cdb4db;"
								value="0">&nbsp; 남자</label>&nbsp;&nbsp; <label
								style="font-weight: normal !important;"><input
								type="radio" name="mem_gender" style="accent-color: #cdb4db;"
								value="1">&nbsp; 여자</label>
						</div>

						<div class="form-group">
							<label>전화번호</label> <input type="text" name="mem_phone"
								class="form-control" maxlength="13" oninput="formatPhoneNumber(this)"> <label class="chkboxCustom">
								<input type="checkbox" name="sms_opt"
								style="accent-color: #cdb4db;" value="1">&nbsp;sms 수신 동의
							</label>
						</div>

						<div class="form-group">
							<label>이메일</label> <input type="email" name="mem_email"
								class="form-control"> <label class="chkboxCustom">
								<input type="checkbox" style="accent-color: #cdb4db;"
								name="email_opt" value="1">&nbsp;이메일 수신 동의
							</label>
						</div>
						<div class="form-group">
							<label>메모</label> <br>
							<textarea class="form-control" name="mem_note" rows="5" cols="38"></textarea>
						</div>
						<div class="form-group">
							<label>주소</label>
							<div class="input-group">
								<input type="button" onclick="sample6_execDaumPostcode()"
									value="주소 찾기" class="btn btn-dark btn-sm"> <input
									type="text" id="sample6_address" placeholder="주소"
									name="mem_addr1" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label>상세주소</label> <input type="text" id="sample6_detailAddress"
								placeholder="상세주소" name="mem_addr2" class="form-control">
						</div>

						<div class="form-group">
						<label>첨부파일</label> <input type="file" name="file"
						 class="form-control" />
						</div>
						<button type="button" class="btn btn-primary" id="submitButt">등록하기</button>

					</div>
				</section>
			</div>

		</div>

	</form>
	<!-- 회원 등록 오프캔버스 시작 -->

</div>
<!-- 바디 끝 -->

<script>
	/* 사용자가 선택한 필터 출력 */
	$(function() {
		$('.filterBtn')
				.click(
						function() {

							let filter = $('input[name=filter]:checked').val();
							let memYear = $('#monthInput').val();
							let mem_gender = $('input[name=mem_gender]:checked')
									.val();

							/* 회원유형 필터를 선택했을 때 */
							if (filter != undefined) {
								$('.filter1')
										.html(
												'<h5><span class="badge badge-warning p-2" style="color: #000;">'
														+ '<input type="hidden" name="filter" value="'+filter+'">'
														+ filter
														+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
														+ '</button></span></h5>');
							}

							/* 연도별을 선택했을 때 */
							if (memYear != "") {
								$('.filter2')
										.html(
												'<h5><span class="badge badge-warning p-2" style="color: #000;">'
														+ '<input type="hidden" name="memYear" value="'+memYear+'">'
														+ memYear
														+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
														+ '</button></span></h5>');
							}

							/* 성별을 선택했을 때 */
							if (mem_gender != null) {

								var displayGender = '';

								if (mem_gender == 0) {
									displayGender = '남자';
								}
								if (mem_gender == 1) {
									displayGender = '여자';
								}

								$('.filter3')
										.html(
												'<h5><span class="badge badge-warning p-2" style="color: #000;">'
														+ '<input type="hidden" name="mem_gender" value="'+mem_gender+'">'
														+ displayGender
														+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
														+ '</button></span></h5>');
							}

						});

	});

	/* 선택한 필터 개별 삭제 */
	$(document).on('click', '.removeFi', function() {
		$(this).parent().remove()
	});

	/* 선택한 필터 전체 삭제 */
	$(document).ready(function() {
		$('#resetFilters').click(function() {
			if (confirm("필터를 삭제하시겠습니까?")) {
				$('.deleteFilter').empty();
			}
		});
	});

	/* 최상위 체크박스 클릭 시 전체 체크박스 선택 */
	$(function() {
		$("#chkAll").click(function() {
			$(".chkGrp").attr("checked", this.checked);
		});

	});

	if ('${param.searchType}' == '${pageVO.cri.searchType}'
			&& '${pageVO.cri.searchType}' != '') {
		$("#selectType").val("${param.searchType}");
	}

	$("#selectPage").val("${pageVO.cri.pageSize }");

	/* 회원등록 Ajax */
	$(function() {
		$("#submitButt").click(function(event) {
			
			const token = $("meta[name='_csrf']").attr("content")
			const header = $("meta[name='_csrf_header']").attr("content");
			
	        // 전화번호 필드에서 하이픈 제거
	        $("input[name='mem_phone']").each(function() {
	            var cleanedPhone = $(this).val().replace(/-/g, '');
	            $(this).val(cleanedPhone);
	        });
			
			var formData = new FormData($("#fm1")[0]);
			
			$.ajax({
				url : "/member/memJoin",
				type : "POST",
				data : formData,
				contentType: false, //필수
	            processData: false, //필수
	            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
	                xhr.setRequestHeader(header, token);
	            },
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

	/* 우편번호 API */
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

	$("#selectPage").change(function() {

		$('input[name="sortVal"]').val('${param.sortVal}');
		$('input[name="sortCri"]').val('${param.sortCri}');

		$(".actionForm").submit();
	});

	$(document).ready(function() {
		$('.chkSort').on('change', function() {
			var selectedVal = $(this).val();
			var sortCriValue;

			if ($(this).attr('id') === 'radioName1') {
				sortCriValue = 'asc'; // 오름차순
			} else if ($(this).attr('id') === 'radioName2') {
				sortCriValue = 'desc'; // 내림차순
			} else if ($(this).attr('id') === 'radioReg') {
				sortCriValue = 'asc'; // 등록순
			}

			// sortCri, sortVal 업데이트
			$('input[name="sortVal"]').val(selectedVal);
			$('input[name="sortCri"]').val(sortCriValue);

			// 확인을 위해 콘솔에 출력
			console.log('Selected sortCri:', sortCriValue);

			$(".actionForm").submit();

		});
	});

	// 검색 시 스피너 작동
	function toggleSpinner() {

		var spinner = document.getElementById('spinner');
		// 스피너가 현재 보이는지 확인
		var isVisible = spinner.classList.contains('d-block');

		if (!isVisible) {
			// 로딩 시작: 스피너 활성화
			spinner.classList.add('d-block');
			spinner.classList.remove('d-none');
			spinner.setAttribute('aria-hidden', 'false');
		} else {
			// 로딩 중지: 스피너 비활성화
			spinner.classList.remove('d-block');
			spinner.classList.add('d-none');
			spinner.setAttribute('aria-hidden', 'true');
		}
	}

	/* 회원 삭제 (회원 삭제날짜 업데이트) */
	$(document).ready(function() {
		$('.deleteMem').click(function() {

			var delete_mems = [];
			const token = $("meta[name='_csrf']").attr("content")
			const header = $("meta[name='_csrf_header']").attr("content");

			$('input[name="mem_no"]:checked').each(function() {
				delete_mems.push(this.value);
			});
			
			if (confirm("회원 삭제하시겠습니까?")) {
			$.ajax({
				url : '/member/memDelete',
				method : 'POST',
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					mem_no : delete_mems
				}),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(response) {
					alert("회원이 성공적으로 삭제되었습니다");
					history.go(0);
				},
				error : function(error) {
					alert("오류 발생");
				}
			});
			}

		});
	});
	
	/* 회원번호 선택 후 메시지 전송 클릭 시 메시지 모달창에 이름과 연락처 출력 */
	$(document).ready(function() {
		$('.smsBtn').click(function() {
			
			var selectedOptions = [];
			const token = $("meta[name='_csrf']").attr("content")
			const header = $("meta[name='_csrf_header']").attr("content");

			$('input[name="mem_no"]:checked').each(function() {
				selectedOptions.push(this.value);
			});
			
			$.ajax({
				url : '/member/memPhone',
				method : 'POST',
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					mem_no : selectedOptions
				}),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(data) {
					var selectedPhones = [];
					$.each(data, function(index, member) {
						
						$('#smsReceiver').append("<div class='memPhone"+index+"' style='margin-bottom:5px;'>"+member.mem_name+
						"("+member.formatted_mem_phone+")<button class='deletePhone"+index+" btn-close btn-xs'></button></div>");
						selectedPhones.push(member.mem_phone);
						
						$('.deletePhone'+index).click(function() {
							selectedPhones = selectedPhones.filter(function(phone) {
					            return phone !== member.mem_phone;
					        });

					        $(this).parent().remove();

					        $('#smsReceiverHidden').html("<input type='hidden' name='recipient_mem' value='" + selectedPhones + "'>");

						    });
					});
					
					$('#smsReceiverHidden').html("<input type='hidden' name='recipient_mem' value='"+selectedPhones+"'>");
					
				},
				error : function(error) {
					alert("선택이 되지 않았습니다.");
					return;
				}
			});
			
			
			
		});
	});
	
	/* 메시지 모달창이 닫혔을 때 출력된 회원이름과 연락처 초기화 */
	$(document).ready(function () {
        $('#smsModal').on('hidden.bs.modal', function () {
            $('#smsReceiver').empty();
        });
    });
	
	
	$(document).ready(function() {
		$('.smsSendBtn').click(function() {
			var selectedOptions = "";
			var selectedMessage = "";
			var selectedNotiDate = "";
			var selectedNotiType = "";
			var manager = "${sess_name}";
			
			const token = $("meta[name='_csrf']").attr("content")
			const header = $("meta[name='_csrf_header']").attr("content");

			$('input[name="recipient_mem"]').each(function() {
				selectedOptions = this.value;
			});
			$('textarea[name="message"]').each(function() {
				selectedMessage = this.value;
			});
			$('input[name="noti_date"]').each(function() {
				selectedNotiDate = this.value;
			});
			$('input[name="noti_type"]').each(function() {
				selectedNotiType = this.value;
			});
						
			$.ajax({
				url : '/message/sendMem',
				method : 'POST',
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify({
					recipient_mem : selectedOptions,
					message : selectedMessage,
					noti_date : selectedNotiDate,
					noti_type : selectedNotiType,
					sender_user : manager
				}),
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(data) {
					alert("메시지 전송 성공");
				},
				error : function(error) {
					alert("오류 발생");
				}
			});
			
			
			
		});
	});
	
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
	
	
	/* 메시지 입력 내용 글자수 제한 */
 	function up(){
 		var com = document.getElementById("comment");
 		var len = document.getElementById("length");
 		var val = com.value;
 		//글자수 세기
 		len.textContent = val.length;
 		
 		//글자수 제한
 		if(val.length>500){
 			com.value = val.substring(0,5000);
 			len.textContent = 500; //제한 후 글자수 업데이트
 		}
 	}
	
	/* 메시지 일반전송 시 현재 시간을 hidden에 담아서 전송 */
	
    
function getKoreanTimeISO() {
    const now = new Date();
    // 한국 시간으로 변환
    const offset = 9 * 60 * 60 * 1000; // 9시간을 밀리초로 변환
    const kst = new Date(now.getTime() + offset);

    // ISO 8601 형식으로 변환 (마지막 'Z' 제거)
    const isoString = kst.toISOString().slice(0, -1);

    return isoString;
}

document.getElementById('currentDatetime').value = getKoreanTimeISO();
 	
 	
	/* 예약전송 클릭 시 시간선택 추가 */
	$(function() {
		$("#chkSendType").change(function() {
	        if ($(this).is(':checked')) {
	            // 체크된 경우
	            $("#sendDate").html('<label for="datetime-input">날짜와 시간을 선택하세요:</label>'+
	            		'<input type="datetime-local" class="form-control" id="datetime-input">'+
	                                ' <p id="adjusted-time"></p><input type="hidden" name="noti_type" value="예약전송">'
	                                +'<input type="hidden" id="hidden-noti-date" name="noti_date">');
				 $('#datetime-input').on('change', function() {
			         // 선택한 날짜와 시간 값 가져오기
			         const selectedDateTime = $(this).val();
			         
			         // hidden 필드에 값 설정
			         $('#hidden-noti-date').val(selectedDateTime);
			     });
	        } else {
	        	
	            // 체크 해제된 경우
	            $("#sendDate").html('<input type="hidden" name="noti_date" value="'+getKoreanTimeISO()+'">'
	            		+'<input type="hidden" name="noti_type" value="일반전송">');
	        }
	    });

	});
	
</script>

<%@ include file="../include/footer.jsp"%>