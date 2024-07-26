<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%-- <%@ include file="../include/equipMenu.jsp"%> --%>



<div class="content-wrapper" style="min-height: 831px;">

<h1>장비신청페이지 - regist</h1>
<form action=""  method="post" id="registForm"  accept-charset="UTF-8" enctype="multipart/form-data">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<div>

					
					<div class="form-group">
						<label>담당자</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>작성날짜</label> <input type="date" name="report_date"
							class="form-control" />
					</div>
					
					
					<div class="form-group">
						<label> 장비신청유형 </label> <select id="select_type"
							name="e_repair_type" size="1">
							<option>선택하세요.</option>
							<option value="구입">구입</option>
							<option value="수리">수리</option>
							<option value="폐기">폐기</option>
						</select>
					</div>
					
					<div class="form-group">
                            <label>분야</label>
					<form:form method="post" modelAttribute="EquipManageVO">
                            <form:select path="field" class="form-control">
                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                    </form:form>
                    </div>
					
					<div class="form-group">
						<label>신청장비이름</label> <input type="text" name="equipment_name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>제조사</label> <input type="text" name="manufacturer"
							class="form-control" />
					</div>

					<div class="form-group">
						<label>개수</label> <input type="text" name="count"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>가격</label> <input type="text" name="cost"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>총 가격</label> <input type="text" name="total"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>유지보수이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100"
							placeholder="입력하세요."></textarea>
					</div>

					<div class="form-group fileDiv">
						<label for="exampleInputFile">첨부파일</label> <input type="file" name="file"
						 class="form-control" />
					</div>

					<button type="button" class="btn btn-primary" id="submitButt">등록</button>


		</div>
</form>



</div>


<script>
$(document).ready(function() {
    $('#submitButt').on('click', function() {
        var formData = new FormData($('#registForm')[0]);
        
        // CSRF 토큰 값을 메타 태그에서 가져오기
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        
        $.ajax({
            url: '/maintenance/regist',
            type: 'POST',
            data: formData,
            contentType: false, //필수
            processData: false, //필수
            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                alert("등록성공!");
                window.location.href = '/maintenance/list';
            },
            error: function(xhr, status, error) {
                alert('등록실패 ' + error);
            }
        });
    });
});
    
    
    //파일추가버튼 클릭시 함수
//     var cnt = 1; //파일 수
//     function addFile(){
//     	alert("파일추가버튼클릭!");
//     	$('.fileDiv').append("<input type='file' name='file"+cnt+"' id='exampleInputFile'>");
//     	cnt++;
    	
//     }
    
    
    
    
</script>






<%@ include file="../include/footer.jsp"%>
