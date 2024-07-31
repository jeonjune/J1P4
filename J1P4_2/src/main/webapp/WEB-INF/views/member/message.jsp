<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<!-- 바디 시작 -->
<div class="content-wrapper" style="min-height: 831px; padding-top:20px;">
<table id="example1" class="table table-bordered table-hover"
			style="background: #fff; height: 100px;" aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting">NO</th>
					<th class="sorting">담당자</th>
					<th class="sorting">전송유형</th>
					<th class="sorting">전송내용</th>
					<th class="sorting">전송날짜</th>
					<th class="sorting">수신인</th>
				</tr>
			</thead>
			<tbody class="test">
				<c:forEach var="sms" items="${SMS }">
					<tr class="tr:hover">
						<td>${sms.noti_no }</td>
						<td>${sms.sender_user }</td>
						<td>${sms.noti_type }</td>
						<td>${sms.message }</td>
						<td>${sms.noti_date }</td>
						<td>${sms.recipient_mem }</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		
</div>

<%@ include file="../include/footer.jsp"%>