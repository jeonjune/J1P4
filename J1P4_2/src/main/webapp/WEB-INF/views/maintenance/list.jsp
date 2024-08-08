<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>

<div class="content-wrapper p-3" style="min-height: 831px;">

		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th width="3%">번호</th>
					<th width="19.4%">분야</th>
					<th width="19.4%">장비보수유형</th>
					<th width="19.4%">장비이름</th>
					<th width="19.4%">담당자</th>
					<th width="19.4%">작성날짜</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${list.equipment_no }</td>
						<td>${list.field}</td>
						<td>${list.e_repair_type}</td>
					<c:if test="${sess_rank.equals('팀장') }">
					<td class=""><a href="/maintenance/detail?equipment_no=${list.equipment_no}">${list.equipment_name }</a></td>
					</c:if>
					<c:if test="${sess_rank.equals('사원') }">
 					<td><a href="/maintenance/updateDetail?equipment_no=${list.equipment_no}">${list.equipment_name }</a></td> 
					</c:if>
						<td>${list.name }</td>
						<td>${list.report_date }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
		
			<div class="d-flex justify-content-between">
		<div></div>

		<div>
			<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight" onclick = "location.href = '/maintenance/regist'">장비 신청</button>
		</div>
		</div>

</div>





<%@ include file="../include/footer.jsp"%>


