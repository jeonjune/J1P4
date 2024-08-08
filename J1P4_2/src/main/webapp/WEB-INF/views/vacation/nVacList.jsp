<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/empMenu.jsp"%>

 <div class="content-wrapper p-3" style="min-height: 831px;">
 	<div class="my-2">
 	<h4>반려 휴가 리스트</h4>
 	</div>
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">NO</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">직무</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">직급</th>
				
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 종류</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 시작일</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 종료일</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 사유</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">반려 사유</th>
					

				</tr>
			</thead>



			<tbody>
			<c:forEach var="list" items="${nList}">
            <c:forEach var="vList" items="${list.vacationList}">
                <tr class="odd">
                    <td class="dtr-control" tabindex="0">${list.user_no }</td>
                    <td>${list.name}</td>
                    <td>${list.job}</td>
                    <td>${list.job_rank}</td>
                    <td>${vList.vacation_status }</td>
                    <td>${vList.vacation_start }</td>
                    <td>${vList.vacation_end }</td>
                    <td>${vList.vacation_reason }</td>
                    <td>${vList.reject_reason }</td>
                </tr>
            </c:forEach>
        </c:forEach>
			</tbody>

		</table>
	</div>
 
 
 
 
  <%@ include file="../include/footer.jsp"%>