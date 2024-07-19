<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

	<form action="/member/listSearch" type="get">
		<div class="form-inline">
			<div class="input-group">
				<input class="form-control" type="search" name="keyword"
					placeholder="Search" aria-label="Search">
				<div class="input-group-append">
					<button class="btn" type="submit">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
			</div>
		</div>
	</form>

	<!-- Button trigger modal -->
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
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
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
					<input type="month">년
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>

	<select>
		<option>등록순</option>
		<option>이름순</option>
		<option></option>
	</select>

	<div class="col-sm-12">
		<table id="example1" class="table table-bordered table-hover" style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" width="20px"><input type="checkbox"
						class="chkGrp" id="chkAll"></th>
					<th class="sorting">NO<i
						class="fas fa-sort fa-fw left-align-icon" onclick="sortMem()"></i></th>
					<th class="sorting">회원이름<i
						class="fas fa-sort fa-fw left-align-icon" onclick="sortMem()"></i></th>
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



	<!-- 페이징 처리 (현재 쌓인 데이터가 얼마 없어 Criteria.pageSize는 2, PageVO.pageBlock은 3 처리해둠) -->
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
	// 	$('.dataTables_paginate.paging_simple_numbers').click(function() {
	// 		alert('test');

	// 		$('body').addClass('sidebar-collapse');

	// 	});

	//스크립트 영역

	$(function() {
		$("#chkAll").click(function() {
			$(".chkGrp").attr("checked", this.checked);
		});

	});
	
	$(function() {
		$(".left-align-icon").click(function() {
			alert('wwwwwwwww');
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
	
	function sortMem() {
		alert("정렬기능!");	
	}
</script>

<%@ include file="../include/footer.jsp"%>