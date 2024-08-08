<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">
    <form action="" method="post" id="detailForm" accept-charset="UTF-8" enctype="multipart/form-data">
    <div class="col-md-8" style="margin-left: 300px; padding-top: 20px; padding-bottom: 50px;">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <div class="card">
        <div class="card m-4">
        <div class="card-body">
            <div class="form-group">
            <div class="p-1">
				<h2>장비신청 수정</h2>
				</div>
				<div class="d-flex justify-content-between my-3">
            <div class="form-group col-md-4">
                <label>장비번호</label>
                <input type="text" name="equipment_no" id="equipment_no" class="form-control" readonly="readonly" value="${resultVO.equipment_no}"/>
            </div>

            <div class="form-group col-md-4">
                <label>담당자</label>
                <input type="text" name="name" id="name" class="form-control" value="${resultVO.name}"/>
            </div>

            <div class="form-group col-md-4">
                <label>작성날짜</label>
                <input type="date" name="report_date" id="report_date" class="form-control" value="${resultVO.report_date}"/>
            </div>
            </div>
            </div>
            </div>
		</div>
		
		<div class="card-body">
		<div class="d-flex justify-content-between p-1" >
            <div class="form-group col-md-6">
                <label>장비신청유형</label>
                
                <select id="select_type" name="e_repair_type" size="1" class="form-control">
                    <option>선택하세요.</option>
                    <option value="구입" ${resultVO.e_repair_type == '구입' ? 'selected' : ''}>구입</option>
                    <option value="추가구입" ${resultVO.e_repair_type == '추가구입' ? 'selected' : ''}>추가구입</option>
                    <option value="수리" ${resultVO.e_repair_type == '수리' ? 'selected' : ''}>수리</option>
                    <option value="폐기" ${resultVO.e_repair_type == '폐기' ? 'selected' : ''}>폐기</option>
                </select>
            </div>
	
            <div class="form-group col-md-6">
                <label>분야</label>
                <select id="field" name="field" class="form-control">
                    <c:forEach var="field" items="${fields}">
                        <option value="${field.codeValue}" ${resultVO.field == field.codeValue ? 'selected' : ''}>${field.codeValueName}</option>
                    </c:forEach>
                </select>
            </div>
           </div>
			
			<div class="d-flex justify-content-between p-1" >
            <div class="form-group col-md-6">
                <label>신청장비이름</label>
                <input type="text" name="equipment_name" id="equipment_name" class="form-control" value="${resultVO.equipment_name}"/>
            </div>
		
            <div class="form-group col-md-6">
                <label>제조사</label>
                <input type="text" name="manufacturer" id="manufacturer" class="form-control" value="${resultVO.manufacturer}"/>
            </div>
            </div>
			<div class="d-flex justify-content-between p-1" >
            <div class="form-group col-md-4">
                <label>개수</label>
                <input type="text" name="count" id="count" class="form-control" value="${resultVO.count}"/>
            </div>

            <div class="form-group col-md-4">
                <label>가격</label>
                <input type="text" name="cost" id="cost" class="form-control" value="${resultVO.cost}"/>
            </div>

            <div class="form-group col-md-4">
                <label>총 가격</label>
                <input type="text" name="total" id="total" class="form-control" value="${resultVO.total}"/>
            </div>
			</div>
            <div class="form-group p-2">
                <label>유지보수이유</label><br>
                <textarea class="form-control" id="comment" name="repair_reason" rows="5" cols="100" placeholder="입력하세요.">${resultVO.repair_reason}</textarea>
            </div>

           	 <div class="form-group p-2">
						<label>첨부파일</label>
						<a href="/maintenance/download?fileName=${fileList.file_name }">${fileList.file_name }</a>
			</div>
			
			<div class="p-2" style="text-align: right;">
            <a href="/maintenance/list"><button type="button" class="btn btn-outline-primary">취소</button></a>
            <button type="button" class="btn btn-primary" id="updateButt">수정</button>
			</div>
        </div>
        </div>
        </div>
    </form>
        </div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    const equipmentNo = $('#equipment_no').val(); // 폼 필드에서 equipment_no 값을 가져옴

    if (equipmentNo) {
        $.ajax({
            url: '/maintenance/updateDetail',
            method: 'GET',
            data: { equipment_no: equipmentNo },
            success: function(data) {
                const resultVO = data.resultVO;

                $('#name').val(resultVO.name);
                $('#report_date').val(resultVO.report_date);
                $('#select_type').val(resultVO.e_repair_type);
                $('#field').val(resultVO.field);
                $('#equipment_name').val(resultVO.equipment_name);
                $('#manufacturer').val(resultVO.manufacturer);
                $('#count').val(resultVO.count);
                $('#cost').val(resultVO.cost);
                $('#total').val(resultVO.total);
                $('#comment').val(resultVO.repair_reason);
					
                // 파일 리스트 등 다른 데이터도 필요시 처리 가능

                // AJAX 요청 성공 후 페이지 리다이렉트
                window.location.href = '/maintenance/updateDetail'; // 원하는 URL로 변경하세요
            },
            error: function(err) {
                console.error(err);
            }
        });
    } else {
        console.error('장비 번호가 설정되지 않았습니다.');
    }
});

//수정
$(document).ready(function(){
	$('#updateButt').click(function(){
		$.ajax({
			url : "/maintenance/updateDetail",
			type : "POST",
			data : $("#detailForm").serialize(),
			success : function(data) {
				alert("수정되었습니다.");
				window.location.href = '/maintenance/list'
			
			},
			error : function() {
				alert("오류오류");
			}
		});
	});
});




</script>

<%@ include file="../include/footer.jsp"%>
