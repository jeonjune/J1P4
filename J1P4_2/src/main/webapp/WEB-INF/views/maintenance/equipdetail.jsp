<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>


<div class="content-wrapper" style="min-height: 831px;">

<form action=""  method="post" id="detailForm"  accept-charset="UTF-8" >
<div class="col-md-8" style="margin-left: 300px; padding-top: 20px; padding-bottom: 50px;">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="equipment_no" value="${param.equipment_no }">
		<div class="card">
		<div class="card m-4">
			<div class="card-body">
			<div class="p-1">
				<h2>장비 유지보수</h2>
				</div>
			<div class="d-flex justify-content-between my-3">
					<div class="form-group col-md-4">
						<label>장비번호</label> <input type="text" name="equipment_no"
							class="form-control" value="${resultVO.equipment_no }" readonly="readonly"/>
					</div>
					
					<div class="form-group col-md-4">
						<label>담당자</label> <input type="text" name="name"
							class="form-control" value="${resultVO.name}" readonly="readonly"/>
					</div>
					
					<div class="form-group col-md-4">
						<label>작성 날짜</label> <input type="date" name="report_date" id="date"
							class="form-control"/>
					</div>
			</div>
			</div>
		</div>
					<div class="card-body">
					<div class="d-flex justify-content-between p-1" >
					<div class="form-group col-md-6" style="height:50px;">
						<label > 장비신청 유형 </label> <select id="select_type" class="form-control"
							name="e_repair_type" size="1">
							<option selected disabled>선택하세요.</option>
							<option value="추가구입">추가구입</option>
							<option value="수리">수리</option>
							<option value="폐기">폐기</option>
						</select>
						<br>
					
					</div>
					
					<div class="form-group col-md-6">
						<label>분야</label> <input type="text" name="field"
							class="form-control" value="${resultVO.field }"  readonly="readonly"/>
					</div>
					</div>
					
					<div class="d-flex justify-content-between p-1">
					<div class="form-group col-md-6">
						<label>신청장비 이름</label> <input type="text" name="equipment_name"
							class="form-control" value="${resultVO.equipment_name }" readonly="readonly"/>
					</div>
					
					<div class="form-group col-md-6">
						<label>제조사</label> <input type="text" name="manufacturer"
							class="form-control" value="${resultVO.manufacturer }" readonly="readonly"/>
					</div>
					</div>
					
					  <div class="d-flex justify-content-between p-1">
					<div class="form-group col-md-4">
				        <label>현재 개수</label> 
				        <input type="text" name="count" id="count" readonly="readonly" class="form-control" value="${resultVO.count }"/>
				    </div>
				    
				    <div class="form-group col-md-4">
				        <label>개당 가격</label> 
				        <input type="text" name="cost" id="cost" readonly="readonly" class="form-control" value="${resultVO.cost }" />
				    </div>
				    
				    <div class="form-group col-md-4">
				        <label>현재 총 가격</label> 
				        <input type="text" name="total" id="total" readonly="readonly" class="form-control" value="${resultVO.total }"/>
				    </div>
				    </div>
				    
				    <div class="d-flex justify-content-between p-1 addCount">
					<div class="form-group col-md-4 addcount"></div>
      				<!-- 새 개수, 새 총 가격, 최종 총 가격 필드가 여기 추가됨 -->
    				</div>
					
					<div class="form-group p-2">
						<label>유지보수 이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100" class="form-control"
							placeholder="입력하세요."></textarea>
					</div>

					<div class="form-group fileDiv p-2"">
						<label for="exampleInputFile">첨부파일</label> <input type="file" name="file"
						 class="form-control" />
					</div>

					<div class="p-2" style="text-align: right;">
					<a href="/maintenance/equipment"><button type="button" class="btn btn-outline-primary">취소</button></a>
					<button type="button" class="btn btn-primary" id="submitBut">등록</button>
					</div>
					</div>
			        


		</div>
		</div>
</form>

	

</div>

<script>
$(document).ready(function() {
    $('#submitBut').on('click', function() {
        var formData = new FormData($('#registForm')[0]);
        var type = $('#select_type').val();
        var count = $('#count').val();
        var addcount = $('#addcount').val();
        var cost = $('#cost').val();
        var total = $('#total').val();
        var date = $('#date').val();
        var content = $('#comment').val();
//         alert("${resultVO.equipment_no }");
        // CSRF 토큰 값을 메타 태그에서 가져오기
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            url: '/maintenance/equipdetail',
            type: 'POST',
            data: {equipment_no:"${resultVO.equipment_no }",
            	e_repair_type:type,
            	count : count,
            	cost : cost,
            	total : total,
            	repair_reason : content,
            	report_date : date,
            	addcount : addcount},
            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                alert("장비 유지보수 신청이 완료되었습니다.");
                window.location.href = '/maintenance/list';
            },
            error: function(error) {
                alert('등록실패 ');
                console.log(error);
            }
        });
    });
});
    
    
    
$(document).ready(function() {
    function updateValues() {
        var originalCount = parseInt($('#count').val()) || 0;
        var originalCost = parseFloat($('#cost').val()) || 0;
        var originalTotal = parseFloat($('#total').val()) || 0;

        var addCount = parseInt($('#addcount').val()) || 0;

        var newCount = originalCount + addCount;
        var newTotal = newCount * originalCost;
        var finalTotal = originalTotal + (addCount * originalCost);

        $('#newCount').val(newCount);
        $('#newTotal').val(newTotal);
        $('#finalTotal').val(finalTotal);
    }

    $('#select_type').on('change', function() {
        let type = $(this).val();
        let addCountDiv = $('.addcount');

        if (type === "추가구입") {
            addCountDiv.html('<label>추가구입 개수</label><input id="addcount" type="number" name="addcount" class="form-control">');
            $('.addCount').append(`
                <div class="form-group col-md-4">
                    <label>추가구입 후 총 개수</label> 
                    <input type="text" id="newCount" readonly="readonly" class="form-control"/>
                </div>
                <div class="form-group col-md-4">
                    <label>추가구입 후 총 가격</label> 
                    <input type="text" id="finalTotal" readonly="readonly" class="form-control"/>
                </div>
            `);
            $('#addcount').on('input', updateValues);
        } else {
            addCountDiv.html(''); // 다른 옵션을 선택했을 때 input 창을 숨김
            $('.addCount').html(''); // 다른 옵션을 선택했을 때 새 값들을 숨김
        }
    });
});


    
</script>




<%@ include file="../include/footer.jsp"%>
