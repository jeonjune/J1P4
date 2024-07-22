<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

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
							id="radioWf1"> <label
							class="btn btn-outline-dark radioField" for="radioWf1">남자</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter2"
							id="radioWf2"> <label
							class="btn btn-outline-dark radioField" for="radioWf2">여자</label>
					</div>
					<hr>
					<h5>수신동의여부</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check" name="filter3"
							id="radioWf1"> <label
							class="btn btn-outline-dark radioField" for="radioWf1">동의</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter3"
							id="radioWf2"> <label
							class="btn btn-outline-dark radioField" for="radioWf2">미동의</label>
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
					<th class="sorting"><input type="checkbox"
						class="chkGrp" id="chkAll"></th>
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
	<c:if test="${empty param.keyword and empty param.memYear and empty param.filter }">
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
	<c:if test="${not empty param.keyword or not empty param.memYear or not empty param.filter }">
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

</script>

<%@ include file="../include/footer.jsp"%>