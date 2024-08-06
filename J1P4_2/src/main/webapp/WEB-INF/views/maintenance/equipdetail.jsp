<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>



<div class="content-wrapper" style="min-height: 831px;">

<h1>장비내역 상세페이지(추가구매/수리/폐기) - equipdetail</h1>

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
							class="form-control" value="${resultVO.name}" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>작성날짜</label> <input type="date" name="report_date" id="date"
							class="form-control" value="${resultVO.report_date }"/>
					</div>
					
<!-- 					<div class="form-group"> -->
<!-- 						<label>장비신청유형</label> <input type="text" name="e_repair_type" -->
<%-- 							class="form-control" value="${resultVO.e_repair_type }"/> --%>
<!-- 					</div> -->
					
					<div class="form-group">
						<label> 장비신청유형 </label> <select id="select_type" class="form-control"
							name="e_repair_type" size="1">
							<option>선택하세요.</option>
							<option value="추가구입">추가구입</option>
							<option value="수리">수리</option>
							<option value="폐기">폐기</option>
						</select>
					</div>
					
					
					<div class="form-group">
						<label>분야</label> <input type="text" name="field"
							class="form-control" value="${resultVO.field }"  readonly="readonly"/>
					</div>
					
					
					<div class="form-group">
						<label>신청장비이름</label> <input type="text" name="equipment_name"
							class="form-control" value="${resultVO.equipment_name }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>제조사</label> <input type="text" name="manufacturer"
							class="form-control" value="${resultVO.manufacturer }" readonly="readonly"/>
					</div>

					<div class="form-group">
						<label>개수</label> <input type="text" name="count" id="count"
							class="form-control" value="${resultVO.count }"/>
					</div>
					
					<div class="form-group">
						<label>가격</label> <input type="text" name="cost" id="cost"
							class="form-control" value="${resultVO.cost }" />
					</div>
					
					<div class="form-group">
						<label>총 가격</label> <input type="text" name="total" id="total"
							class="form-control" value="${resultVO.total }"/>
					</div>
					
					<div class="form-group">
						<label>유지보수이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100" class="form-control"
							placeholder="입력하세요.">${resultVO.repair_reason }</textarea>
					</div>

					<div class="form-group">
						<label>첨부파일</label>
						<c:if test="${!fileList.file_name.equals('no') }">
					<a href="/maintenance/download?fileName=${fileList.file_name }">${fileList.file_name }</a></p>					
					</c:if>

					</div>

					<button type="button" class="btn btn-primary" id="submitBut">등록</button>
			        


		</div>
</form>

	
	
	
	
	
	
	

</div>

<script>
$(document).ready(function() {
    $('#submitBut').on('click', function() {
        var formData = new FormData($('#registForm')[0]);
        var type = $('#select_type').val();
        var count = $('#count').val();
        var cost = $('#cost').val();
        var total = $('#total').val();
        var date = $('#date').val();
        var content = $('#comment').val();
        
        // CSRF 토큰 값을 메타 태그에서 가져오기
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            url: '/maintenance/equipdetail',
            type: 'POST',
            data: {"equipment_no":"${resultVO.equipment_no }",
            	e_repair_type:type,
            	count : count,
            	cost : cost,
            	total : total,
            	repair_reason : content,
            	report_date : date},
            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                alert("등록완료@@!");
                window.location.href = '/maintenance/list';
            },
            error: function(xhr, status, error) {
                alert('등록실패 ' + error);
            }
        });
    });
});
    
    
    


    
    
    
</script>




<%@ include file="../include/footer.jsp"%>
