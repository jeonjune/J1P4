<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/sidemenu.jsp" %>
  <div class="content-wrapper" style="min-height: 831px;">
<h1>/member/list.jsp</h1>

	${memberList }
	${pageVO }
	
<div class="box">
	<div class="box-header with-border">
		<h3 class="box-title">게시판 리스트(ALL)</h3>
	</div>

	<div class="box-body">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th style="width: 10px">회원번호</th>
					<th>회원이름</th>
					<th>회원등급</th>
					<th>등록일</th>
					<th>강의누적기간</th>
					<th>현재 수강상태</th>
				</tr>
				<c:forEach var="vo" items="${memberList }">
					<tr>
						<td>${vo.mem_no }</td>
						<td>
							<a href="/member/read?mem_no=${vo.mem_no }&page=${param.page==null? 1:param.page}">${vo.mem_name }</a>
						</td>
						<td>${vo.mem_rank }</td>
						<td>${vo.reg_date }</td>
						<td><span class="badge bg-orange">${vo.class_time }</span></td>
						<td>${vo.class_status }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</div>

<%@ include file="../include/footer.jsp" %>