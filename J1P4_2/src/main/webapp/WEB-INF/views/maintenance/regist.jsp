<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>
<%-- <%@ include file="../include/equipMenu.jsp"%> --%>



<div class="content-wrapper" style="min-height: 831px;">
<form action=""  method="post" id="registForm"  accept-charset="UTF-8" enctype="multipart/form-data">
	<div class="col-md-8" style="margin-left: 300px; padding-top: 20px; padding-bottom: 50px;">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<div class="card">
		<div class="card m-4">
			<div class="card-body">
			<div class="p-1">
				<h2>장비신청</h2>
			</div>
					<div class="d-flex justify-content-between my-3">
					<div class="form-group col-md-6">
						<label>담당자</label> <input type="text" name="name" id="name" value="${sess_name }"
							readonly="readonly" class="form-control" />
					</div>
					
					<div class="form-group col-md-6">
						<label>작성 날짜</label> <input type="date" name="report_date" id="report_date"
							class="form-control" />
					</div>
					
					</div>
			</div>
		</div>
				<div class="card-body">
					<div class="d-flex justify-content-between p-1">
					<div class="form-group col-md-6">
						<label> 장비신청 유형 </label> <select id="select_type" required="required" class="form-control"
							name="e_repair_type" size="1">
							<option value="" selected disabled>선택하세요.</option>
							<option value="구입">구입</option>
						</select>
					</div>
					
					<div class="form-group col-md-6">
                            <label>분야</label>
					<form:form method="post" modelAttribute="EquipManageVO">
                            <form:select path="field" class="form-control" id="field">
                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                    </form:form>
                    </div>
					</div>
					<div class="d-flex justify-content-between p-1">
					<div class="form-group col-md-6">
						<label>신청장비 이름</label> <input type="text" name="equipment_name" id="equipment_name"
							class="form-control" />
					</div>
					
					<div class="form-group col-md-6">
						<label>제조사</label> <input type="text" name="manufacturer" id="manufacturer"
							class="form-control" />
					</div>
					</div>
					<div class="d-flex justify-content-between p-1">
					<div class="form-group col-md-4">
						<label>개수</label> <input type="number" name="count" id="count"
							class="form-control" />
					</div>
					
					<div class="form-group col-md-4">
						<label>개당 가격</label> <input type="number" name="cost" id="cost"
							class="form-control" />
					</div>
					<div class="form-group col-md-4">
						<label>총 가격</label> <input type="text" name="total" id="total"
							class="form-control" readonly="readonly" />
					</div>
					</div>
					
					<div class="form-group p-2">
						<label>신청 이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100" class="form-control"
							placeholder="입력하세요."></textarea>
					</div>
					<div class="form-group fileDiv p-2"">
						<label for="exampleInputFile">첨부파일</label> <input type="file" name="file"
						 class="form-control" />
					</div>
					<div class="p-2" style="text-align: right;">
					<a href="/maintenance/list"><button type="button" class="btn btn-outline-primary">취소</button></a>
					<button type="button" class="btn btn-primary" id="submitButt">등록</button>
					</div>

</div>
</div>
		</div>
</form>



</div>


<script>

//빈칸 검사, 장비신청등록
$(document).ready(function() {
    $('#submitButt').on('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지

        // 빈칸 검사
        var name = $('#name').val();
        var report_date = $('#report_date').val();
        //var select_type = $('#select_type').val();
        var field = $('#field').val();
        var equipment_name = $('#equipment_name').val();
        var manufacturer = $('#manufacturer').val();
        var count = $('#count').val();
        var cost = $('#cost').val();
       // var total = $('#total').val();
        var comment = $('#comment').val();
        
        if (name == "" || report_date == "" || field == "" || equipment_name == "" ||
            manufacturer == "" || count == "" || cost == "" || comment == "") {
            alert("빈칸을 모두 입력해주세요.");
            return;
        }
       
        if($('#select_type').val() == ""){
        	   alert("선택하지 않은 필드를 선택해주세요.");
            return;
           } 

        
     //장비신청 등록
     // 폼 데이터 수집
     var formData = new FormData($('#registForm')[0]);
     // CSRF 토큰 값 가져오기
     var token = $("meta[name='_csrf']").attr("content");
     var header = $("meta[name='_csrf_header']").attr("content");
     
     $.ajax({
           url: '/maintenance/regist',
           type: 'POST',
           data: formData,
           contentType: false, // 필수
           processData: false, // 필수
           beforeSend: function(xhr) { // CSRF 토큰 설정
               xhr.setRequestHeader(header, token);
           },
           success: function(response) {
               alert("장비 신청이 완료되었습니다.");
               window.location.href = '/maintenance/list';
           },
           error: function(xhr, status, error) {
               alert('등록실패: ' + error);
           }
       });
    });
});

$(document).ready(function() {
    function calculateTotal() {
        var count = $('#count').val();
        var cost = $('#cost').val();
        var total = $('#total');
        
        // 개수와 가격이 입력된 경우에만 계산
        if(count && cost) {
            total.val(count * cost);
        } else {
            total.val('');
        }
    }

    $('#count, #cost').on('input', calculateTotal);
});
</script>



    






<%@ include file="../include/footer.jsp"%>
