<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">


<h1>장비신청내역 페이지 - list</h1>



	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight" onclick = "location.href = '/maintenance/regist'">장비신청</button>

	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-striped dataTable dtr-inline"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">장비번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">분야</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">장비보수유형</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">장비이름</th>
				
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">작성날짜</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${list.equipment_no }</td>
						<td>${list.field}</td>
						<td>${list.e_repair_type}</td>
					<td class=""><a
							href="/maintenance/detail?equipment_no=${list.equipment_no}">${list.equipment_name }</a></td>
						<td>${list.name }</td>
						<td>${list.report_date }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>





<%@ include file="../include/footer.jsp"%>


