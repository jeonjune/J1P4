<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<div class="content-wrapper" style="min-height: 831px;">


<h1>facility </h1>
${facList} <br>
<div class="content-wrapper" style="min-height: 831px;">
	
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">등록하기</button>
		</div>
	
	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-striped dataTable dtr-inline"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">시설번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">시설이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="facility" items="${facLsit }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${vo.facility_no }</td>
						<td class=""><a
							href="/member/read?mem_no=${vo.facility_no }&page=${param.page==null? 1:param.page}">${vo.facility_name }</a></td>
						<td>${vo.name }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>

</div>
<%@ include file="../include/footer.jsp"%>