<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">
	
	<!-- 검색 / 필터 / 정렬 데이터 전송 -->
	<form action="/member/listSearch" method="get">
	
		<div class="form-inline">
			<div class="input-group">
				<input class="form-control" type="search" name="keyword"
					value="${param.keyword }" placeholder="Search" aria-label="Search">
				<div class="input-group-append">
					<button class="btn" type="submit" class="submitBtn">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
			</div>
		</div>
		<div class="filter1"></div>
		<div class="filter2"></div>

	</form>
	
	<!-- 필터 모달창 버튼 -->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#exampleModal">
		<i class="fas fa-filter fa-fw"></i>
	</button>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">필터하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<h5>회원등급</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check"
							name="work_field" id="radioWf1"> <label
							class="btn btn-outline-dark radioField" for="radioWf1">신규회원</label>
						<input type="radio" value="일반회원" class="btn-check"
							name="work_field" id="radioWf2"> <label
							class="btn btn-outline-dark radioField" for="radioWf2">일반회원</label>
						<input type="radio" value="장기회원" class="btn-check"
							name="work_field" id="radioWf3"> <label
							class="btn btn-outline-dark radioField" for="radioWf3">장기회원</label>
					</div>
					<hr>
					<h5>연도별</h5>
					<input type="month" id="monthInput">년
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary filterBtn"
						data-bs-dismiss="modal">필터 적용</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 회원 리스트 출력 -->
	<div class="col-sm-12">
		<table id="example1" class="table table-bordered table-hover"
			style="background: #fff" aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" width="20px"><input type="checkbox"
						class="chkGrp" id="chkAll"></th>
					<th class="sorting">NO<i
						class="fas fa-sort fa-fw left-align-icon" onclick="sortMem()"></i></th>
					<th class="sorting">회원이름<i
						class="fas fa-sort fa-fw left-align-icon1" onclick="sortMem()"></i></th>
					<th class="sorting">회원등급</th>
					<th class="sorting">등록일<i
						class="fas fa-sort fa-fw left-align-icon" onclick="sortMem()"></i></th>
					<th class="sorting">강의 누적 기간</th>
					<th class="sorting sorting_asc">현재 수강상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${memberList }">
					<tr class="tr:hover">
						<td class="dtr-control" tabindex="0"><input type="checkbox"
							class="chkGrp"></td>
						<td class="dtr-control" tabindex="0">${vo.mem_no }</td>
						<td class=""><a
							href="/member/read?mem_no=${vo.mem_no }&page=${param.page==null? 1:param.page}">${vo.mem_name }</a></td>
						<td><c:if test="${vo.mem_rank == 0}">
						신규회원
						</c:if> <c:if test="${vo.mem_rank == 1}">
						일반회원
						</c:if> <c:if test="${vo.mem_rank == 2}">
						장기회원
						</c:if></td>
						<td>${vo.reg_date }</td>
						<td class="sorting_1">${vo.class_time }</td>
						<td>${vo.class_status }</td>
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

	<button class="btn btn-primary" type="button" onclick="deleteMem()">삭제하기</button>

</div>
<script>
	// 선택한 필터 출력
	$(function() {
		$('.filterBtn')
				.click(
						function() {
							$(".filter").empty();
							let work_field = $('input[name=work_field]:checked')
									.val();
							let memYear = $('#monthInput').val();

							if (work_field != undefined) {
								$('.filter1')
										.html(
												'<p><div class="border border-1 rounded-3 p-2" role="group" style="width: 700px; margin-bottom: 20px;">'
														+ '<button class="removeLi btn-close" aria-label="Close" style="width: 1px; position: absolute; right:78px;"></button>'
														+ '<input type="hidden" name="work_field" value="'+work_field+'">'
														+ '<span style="padding-left: 20px;font-size: 18px; font-weight: bold;">'
														+ work_field
														+ '</span></div></p>');
							}

							if (memYear != "") {
								$('.filter2')
										.html(
												'<p><div class="border border-1 rounded-3 p-2" role="group" style="width: 700px; margin-bottom: 20px;">'
														+ '<button class="removeLi btn-close" aria-label="Close" style="width: 1px; position: absolute; right:78px;"></button>'
														+ '<input type="hidden" name="memYear" value="'+memYear+'">'
														+ '<span style="padding-left: 20px;font-size: 18px; font-weight: bold;">'
														+ memYear
														+ '</span></div></p>');
							}

						});

	});

// 	document.addEventListener("DOMContentLoaded", function() {
// 		var removeBtn = document.querySelector(".removeLi");

// 		removeBtn.addEventListener("click", function() {
// 			// 클릭 시 부모 요소인 div 태그를 삭제합니다.
// 			var parentDiv = removeBtn.closest(".border");
// 			if (parentDiv) {
// 				parentDiv.remove();
// 			}
// 		});
// 	});

	// 최상위 체크박스 클릭 시 전체 체크박스 선택
	$(function() {
		$("#chkAll").click(function() {
			$(".chkGrp").attr("checked", this.checked);
		});

	});

	$(function() {
		$(".left-align-icon1").click(function() {
			if ($(".left-align-icon1").hasClass("fa-sort")) {
				$(".left-align-icon1").removeClass("fa-sort");
				$(".left-align-icon1").addClass("fa-sort-up");

			} else if ($(".left-align-icon1").hasClass("fa-sort-up")) {
				$(".left-align-icon1").removeClass("fa-sort-up");
				$(".left-align-icon1").addClass("fa-sort-down");
			} else {
				$(".left-align-icon1").removeClass("fa-sort-down");
				$(".left-align-icon1").addClass("fa-sort");
			}
		});

	});

	function deleteMem() {

		let groupList = "";

		$(".chkGrp:checked").each(function(idx, item) {
			if (idx == 0) {
				groupList += item.value;
			} else {
				groupList += "," + item.value;
			}

		});
		alert(grouplist);
	}

</script>

<%@ include file="../include/footer.jsp"%>