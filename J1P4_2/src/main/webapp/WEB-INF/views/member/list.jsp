<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<div class="content-wrapper" style="min-height: 831px;">

	<div class="spinner-border text-primary d-none" id="spinner"
		role="status" aria-hidden="true">
		<span class="visually-hidden">Loading...</span>
	</div>
	
	
	<!-- 검색 / 필터 / 정렬 데이터 전송 -->
	<form action="" method="get" class='actionForm'>

		<div class="form-inline">
			<!-- 검색 키워드 입력창 -->
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<select name="searchType" id="selectType" class="form-control">
						<option value="searchAll" selected="selected">전체</option>
						<option value="searchName">이름</option>
						<option value="searchPhoneNum">연락처</option>
						<option value="searchEmail">이메일</option>
					</select>
				</div>
				<input class="form-control" type="search" name="keyword"
					value="${param.keyword }" placeholder="Search" aria-label="Search">
				<div class="input-group-append">
					<button class="btn" type="submit" id="submitBtn"
						onclick="toggleSpinner()">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
			</div>
			<!-- 필터 모달창 버튼 -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#exampleModal">
				<i class="fas fa-filter fa-fw"></i>
			</button>
			<button type="button" class="btn btn-info" id="resetFilters">
				<i class="fas fa-trash fa-fw"></i>
			</button>
		</div>
		<!-- 사용자가 선택한 필터를 보여주는 공간 -->
		<div class="filter1" style="display: inline-block;">
			<div class="deleteFilter">
				<!-- 사용자가 필터를 사용하여 검색했을 때 선택한 필터를 보여주는 공간 -->
				<c:if test="${not empty param.filter }">
					<h5><span class="badge badge-warning p-2" style="color: #000;">
					<input type="hidden" name="filter" value="${param.filter }">${param.filter }
					<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">
					</button></span></h5>
				</c:if>
			</div>
		</div>
		<div class="filter2" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.memYear }">
					<h5><span class="badge badge-warning p-2" style="color: #000;">
					<input type="hidden" name="memYear" value="${param.memYear }">${param.memYear }
					<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">
					</button></span></h5>
				</c:if>
			</div>
		</div>
		<div class="filter3" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.mem_gender }">
					<h5><span class="badge badge-warning p-2" style="color: #000;">
					<input type="hidden" name="mem_gender" value="${param.mem_gender }">
							<c:if test="${param.mem_gender == 0}">남자</c:if> <c:if
								test="${param.mem_gender == 1}">여자</c:if>					
					<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">
					</button></span></h5>
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


		<div class="content memListSort">
			<div>검색결과 : ${pageVO.totalCount }명</div>
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
			<div class="textRight">
				<select name="pageSize" id="selectPage" class="form-control">
					<option value="10">10개씩 보기</option>
					<option value="20">50개씩 보기</option>
					<option value="30">100개씩 보기</option>
				</select>
			</div>
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

				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary filterBtn"
						data-bs-dismiss="modal">필터 추가</button>
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
						id="chkAll" style="accent-color: #cdb4db;"></th>
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
<%-- 					<c:if test="${not empty vo.mem_delete }"> --%>
						<td class="dtr-control" tabindex="0"><input type="checkbox" name="mem_no"
							class="chkGrp" value="${vo.mem_no }" style="accent-color: #a2d2ff;"></td>
						<td class="dtr-control" tabindex="0">${vo.mem_no }</td>
						<td class=""><a
							href="/member/read?mem_no=${vo.mem_no }&page=${param.page==null? 1:param.page}">${vo.mem_name }</a></td>
						<td>${vo.mem_phone }</td>
						<td>${vo.mem_rank }</td>
						<td>${vo.reg_date }</td>
						<td class="sorting_1">${vo.class_time }</td>
						<td>${vo.class_status }</td>
						<td>${vo.mem_note }</td>
<%-- 					</c:if> --%>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 페이징 처리 -->
	<div class="col-sm-12 col-md-7">
		<div class="dataTables_paginate paging_simple_numbers"
			id="example1_paginate">
			<ul class="pagination">
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

	<!-- 메시지 보내기 버튼 -->
	<button class="btn btn-primary" type="button">메시지 전송</button>

	<!-- 회원 삭제 버튼 -->
	<button class="btn btn-primary deleteMem" type="button">삭제하기</button>

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
								class="form-control"> <label class="chkboxCustom">
								<input type="checkbox" name="sms_opt"
								style="accent-color: #cdb4db;" value="1">&nbsp;sms 수신 동의
							</label>
						</div>

						<div class="form-group">
							<label>이메일</label> <input type="text" name="mem_email"
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


						<button type="button" class="btn btn-primary" id="submitButt">등록하기</button>

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

							let filter = $('input[name=filter]:checked').val();
							let memYear = $('#monthInput').val();
							let mem_gender = $('input[name=mem_gender]:checked')
									.val();

							/* 회원유형 필터를 선택했을 때 */
							if (filter != undefined) {
								$('.filter1')
										.html(
												'<h5><span class="badge badge-warning p-2" style="color: #000;">'+
												'<input type="hidden" name="filter" value="'+filter+'">'+filter+
												'<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'+
												'</button></span></h5>');
							}

							/* 연도별을 선택했을 때 */
							if (memYear != "") {
								$('.filter2')
										.html(
												'<h5><span class="badge badge-warning p-2" style="color: #000;">'+
												'<input type="hidden" name="memYear" value="'+memYear+'">'+memYear+
												'<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'+
												'</button></span></h5>');
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
												'<h5><span class="badge badge-warning p-2" style="color: #000;">'+
												'<input type="hidden" name="mem_gender" value="'+mem_gender+'">'+displayGender+
												'<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'+
												'</button></span></h5>');
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
	
	$(document).ready(function() {
		$('.deleteMem').click(function() {
		
        var selectedOptions = [];
        const token = $("meta[name='_csrf']").attr("content")
        const header = $("meta[name='_csrf_header']").attr("content");
        
        $('input[name="mem_no"]:checked').each(function() {
            selectedOptions.push(this.value);
        });
        
        console.log(selectedOptions);
        console.log(JSON.stringify({ mem_no: selectedOptions }));
        
        $.ajax({
            url: '/member/memDelete',
            method: 'POST',
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify({ mem_no: selectedOptions }),
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
            success: function(response) {
				alert("회원이 성공적으로 삭제되었습니다");
            },
            error: function(error) {
				alert("오류 발생");
            }
        });
        
        });
       });
</script>

<%@ include file="../include/footer.jsp"%>