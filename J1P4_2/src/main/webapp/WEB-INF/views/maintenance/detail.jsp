<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>



<div class="content-wrapper" style="min-height: 831px;">

<h1>장비신청상세페이지 - detail</h1>
<form action=""  method="post" id="detailForm"  accept-charset="UTF-8" >
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="equipment_no" value="${param.equipment_no }">
	<div>

					
					<div class="form-group">
						<label>장비번호</label> <input type="text" name="equipment_no"
							class="form-control" value="${resultVO.equipment_no }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>담당자</label> <input type="text" name="name"
							class="form-control" value="${resultVO.name}"/>
					</div>
					
					<div class="form-group">
						<label>작성날짜</label> <input type="date" name="report_date"
							class="form-control" value="${resultVO.report_date }"/>
					</div>
					
					<div class="form-group">
						<label>장비신청유형</label> <input type="text" name="e_repair_type"
							class="form-control" value="${resultVO.e_repair_type }"/>
					</div>
					
					
					<div class="form-group">
						<label>분야</label> <input type="text" name="field"
							class="form-control" value="${resultVO.field }" />
					</div>
					
					<div class="form-group">
						<label>신청장비이름</label> <input type="text" name="equipment_name"
							class="form-control" value="${resultVO.equipment_name }" />
					</div>
					
					<div class="form-group">
						<label>제조사</label> <input type="text" name="manufacturer"
							class="form-control" value="${resultVO.manufacturer }"/>
					</div>

					<div class="form-group">
						<label>개수</label> <input type="text" name="count"
							class="form-control" value="${resultVO.count }"/>
					</div>
					
					<div class="form-group">
						<label>가격</label> <input type="text" name="cost"
							class="form-control" value="${resultVO.cost }" />
					</div>
					
					<div class="form-group">
						<label>총 가격</label> <input type="text" name="total"
							class="form-control" value="${resultVO.total }"/>
					</div>
					
					<div class="form-group">
						<label>유지보수이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100"
							placeholder="입력하세요.">${resultVO.repair_reason }</textarea>
					</div>

<!-- 					<div class="form-group"> -->
<!-- 						<label>첨부파일</label> <input type="file" name="file" -->
<!-- 							class="form-control" /> -->
<!-- 					</div> -->

					<button type="button" class="btn btn-primary" id="submitButt">수정</button>
					<button type="button" class="btn btn-primary" id="submitButt">삭제</button>


		</div>
</form>



</div>





<%@ include file="../include/footer.jsp"%>
