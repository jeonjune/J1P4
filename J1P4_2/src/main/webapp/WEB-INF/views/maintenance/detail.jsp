<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>



<div class="content-wrapper" style="min-height: 831px;">

<h1>장비신청상세페이지 - 팀장님페이지 detail</h1>

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
						<label>작성날짜</label> <input type="date" name="report_date"
							class="form-control" value="${resultVO.report_date }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>장비신청유형</label> <input type="text" name="e_repair_type"
							class="form-control" value="${resultVO.e_repair_type }" readonly="readonly"/>
					</div>
					
					
					<div class="form-group">
						<label>분야</label> <input type="text" name="field"
							class="form-control" value="${resultVO.field }" readonly="readonly"/>
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
						<label>개수</label> <input type="text" name="count"
							class="form-control" value="${resultVO.count }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>추가구입 개수</label> <input type="text" name="addcount"
							class="form-control" value="${resultVO.addcount }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>가격</label> <input type="text" name="cost"
							class="form-control" value="${resultVO.cost }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>총 가격</label> <input type="text" name="total"
							class="form-control" value="${resultVO.total }" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>유지보수이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100" readonly="readonly"
							placeholder="입력하세요.">${resultVO.repair_reason }</textarea>
					</div>

					<div class="form-group">
						<label>첨부파일</label>
					
						
					<c:if test="${!fileList.file_name.equals('no') }">
					<p class="text-muted cardMy">
					<a href="/maintenance/download?fileName=${fileList.file_name }">${fileList.file_name }</a></p>					
					</c:if>
						

					</div>

					<button type="button" class="btn btn-primary" id="submitBut">승인</button>
			         <button type="button" class="btn btn-primary" data-bs-toggle="modal" onclick="showReject()"
			         data-bs-target="#submitButt">반려</button>


		</div>
</form>


	
	<!-------------------------- 반려사유 입력 모달창 시작 ----------------------------------->
   <div class="modal fade" id="rejectModal" tabindex="-1"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">

            <!-- 모달창 헤더 -->
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">반려사유</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal"
                  aria-label="Close"></button>
            </div>

            <!-- 모달창 바디(본문) -->
            <div class="modal-body">
			   
			   <h5>담당자</h5> <!-- 로그인한 팀장 이름 담기 -->
			   	<div class="form-group">
					<input type="text" name="name"
					class="form-control" value="${resultVO.name}" readonly="readonly"/>
				</div>
               
               <h5>반려사유</h5>
               <div class="content">
                  <div class="form-group">
						<textarea id="comment2" name="equipment_reject" rows="5" cols="55"
							placeholder="입력하세요."></textarea>
					</div>
                 
               </div>
             
               <hr>
<!--                <h5>연도별</h5> -->
<!--                <input type="month" id="monthInput">년 -->

            </div>

            <!-- 모달창 푸터 -->
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary"
                  data-bs-dismiss="modal">취소</button>
               <button type="button" class="btn btn-primary filterBtn"
                  data-bs-dismiss="modal" id="rejectBtt">확인</button>
            </div>

         </div>
      </div>
   </div>
   <!-- 모달창 끝 -->
	

	
	
	
	
	

</div>

<script>
$(document).ready(function() {
    $('#submitBut').on('click', function() {
        var formData = new FormData($('#registForm')[0]);
        
        alert("${resultVO.e_repair_type }");
        
        // CSRF 토큰 값을 메타 태그에서 가져오기
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            url: '/maintenance/detail',
            type: 'POST',
            data: {"equipment_no":"${resultVO.equipment_no }",
            	   "e_repair_type":"${resultVO.e_repair_type }",
            	   "addcount":"${resultVO.addcount }",
            	   "total":"${resultVO.total }"
            	},
            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                alert("승인완료!");
                window.location.href = '/maintenance/equipment';
            },
            error: function(xhr, status, error) {
                alert('등록실패 ' + error);
            }
        });
    });
});
    
    
    
function showReject() {
    //document.getElementById('rejectProjNo').value = proj_no;
    $('#rejectModal').modal('show');
} 
 
 
 //반려내역
$(document).ready(function() {
    $('#rejectBtt').on('click', function() {
        var formData = new FormData($('#registForm')[0]);
        var content = $('#comment2').val();
        
        // CSRF 토큰 값을 메타 태그에서 가져오기
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            url: '/maintenance/detail2',
            type: 'POST',
            data: {"equipment_no":"${resultVO.equipment_no }", equipment_reject :content},
            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                alert("반려되었습니다.");
                window.location.href = '/maintenance/reject';
            },
            error: function(xhr, status, error) {
                alert('등록실패 ' + error);
            }
        });
    });
});

    
    
    
</script>




<%@ include file="../include/footer.jsp"%>
