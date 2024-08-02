<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>


<div class="content-wrapper" style="min-height: 831px;">


<h1>반려내역 페이지 - reject</h1>


<!-- 	<button class="btn btn-primary" type="button" -->
<!-- 		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" -->
<!-- 		aria-controls="offcanvasRight">버튼</button> -->

	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">장비번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">분야</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">장비보수유형</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">장비이름</th>
				
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">반려사유</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="rList" items="${rList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${rList.equipment_no }</td>
						<td>${rList.field}</td>
						<td>${rList.e_repair_type}</td>
						<td>${rList.equipment_name}</td>
						<td>${rList.name }</td>
<%-- 						<td>${rList.equipment_reject }</td> --%>
					 <td>
					 <c:if test="${rList.status == '반려'}">
					 	<input type="hidden" id="eqno" value="${rList.equipment_no }">
                     	<button type="button" class="btn btn-warning" onclick="showRejectReason(${rList.equipment_no})">반려 사유 확인</button>
                     </c:if>
                     </td> 						
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>



	<!-- 반려사유 가져오는 모달창 시작 -->
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
<!-- 					<input type="text" name="name"  -->
<%-- 					class="form-control" value="${resultVO.name}" readonly="readonly"/> --%>
				<p id="rejectNameText"></p>
				</div>
               
               <h5>반려사유</h5>
               <div class="content">
                  <div class="form-group">
						 <p id="rejectReasonText"></p>
					</div>
                 
               </div>
             
               <hr>

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
	
<script type="text/javascript">

//반려사유 가져오는 함수
function showRejectReason(equipment_no){
	$.ajax({
		url: '/maintenance/getReject',
        method: 'GET',
        data: {equipment_no : equipment_no},
        success: function(response) {
            document.getElementById('rejectReasonText').innerText = response.equipment_reject;
            document.getElementById('rejectNameText').innerText = response.name;
            
            $('#rejectModal').modal('show');
        },
        error: function() {
            alert('반려 사유를 가져오는데 실패했습니다.');
        }
	});
}

</script>



<%@ include file="../include/footer.jsp"%>







