<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>


<div class="content-wrapper" style="min-height: 831px;">

<h1>승인된 장비 내역 페이지- equipment</h1>


<!-- 	<button class="btn btn-primary" type="button" -->
<!-- 		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" -->
<!-- 		aria-controls="offcanvasRight">버튼</button> -->

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
						aria-label="Browser: activate to sort column ascending">제조사</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">가격</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">수량</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">날짜</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="eList" items="${eList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${eList.equipment_no}</td>
						<td>${eList.field}</td>
						<td>${eList.e_repair_type}</td>
						<td>${eList.equipment_name}</td>
						<td>${eList.manufacturer }</td>
						<td>${eList.cost }</td>
						<td>${eList.count }</td>
						<td>${eList.name }</td>
						<td>${eList.approval_date }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>




<%@ include file="../include/footer.jsp"%>