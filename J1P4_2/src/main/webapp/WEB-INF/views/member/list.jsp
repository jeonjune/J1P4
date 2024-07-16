<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-striped dataTable dtr-inline"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">회원번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">회원이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">회원등급</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Platform(s): activate to sort column ascending">등록일</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Engine version: activate to sort column ascending">강의
						누적 기간</th>
					<th class="sorting sorting_asc" tabindex="0"
						aria-controls="example1" rowspan="1" colspan="1"
						aria-label="CSS grade: activate to sort column descending"
						aria-sort="ascending">현재 수강상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${memberList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${vo.mem_no }</td>
						<td class=""><a
							href="/member/read?mem_no=${vo.mem_no }&page=${param.page==null? 1:param.page}">${vo.mem_name }</a></td>
						<td>${vo.mem_rank }</td>
						<td>${vo.reg_date }</td>
						<td class="sorting_1">${vo.class_time }</td>
						<td>${vo.class_status }</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<th rowspan="1" colspan="1">회원번호</th>
					<th rowspan="1" colspan="1">회원이름</th>
					<th rowspan="1" colspan="1">회원등급</th>
					<th rowspan="1" colspan="1">등록일</th>
					<th rowspan="1" colspan="1">강의 누적 시간</th>
					<th rowspan="1" colspan="1">현재 수강상태</th>
				</tr>
			</tfoot>
		</table>
	</div>

	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">Toggle right offcanvas</button>

	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">Offcanvas right</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">...</div>
	</div>

	<div class="col-sm-12 col-md-5">
		<div class="dataTables_info" id="example1_info" role="status"
			aria-live="polite"></div>
	</div>

	<!-- 페이징 처리 (현재 쌓인 데이터가 얼마 없어 Criteria.pageSize는 2, PageVO.pageBlock은 3 처리해둠) -->
	<div class="col-sm-12 col-md-7">
		<div class="dataTables_paginate paging_simple_numbers"
			id="example1_paginate">
			<ul class="pagination">
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous"><a
						href="/member/listPage?page=${pageVO.startPage-1 }"
						aria-controls="example1" data-dt-idx="0" tabindex="0"
						class="page-link">«</a></li>
				</c:if>
				<c:forEach var="i" begin="${pageVO.startPage }"
					end="${pageVO.endPage }" step="1">
					<li
						class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }"><a
						href="/member/listPage?page=${i }" aria-controls="example1"
						data-dt-idx="1" tabindex="0" class="page-link">${i }</a></li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next"><a
						href="/member/listPage?page=${pageVO.endPage+1 }"
						aria-controls="example1" data-dt-idx="7" tabindex="0"
						class="page-link">»</a></li>
				</c:if>
			</ul>
		</div>
	</div>

</div>



<script>
	$(function() {
		$("#example1").DataTable({
			"responsive" : true,
			"lengthChange" : false,
			"autoWidth" : false,
			"buttons" : [ "copy", "csv", "excel", "pdf", "print", "colvis" ]
		}).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

	});

// 	$('.dataTables_paginate.paging_simple_numbers').click(function() {
// 		alert('test');

// 		$('body').addClass('sidebar-collapse');
		
		
// 	});
	
	
</script>

<%@ include file="../include/footer.jsp"%>