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
 	<h4>신청 휴가 리스트</h4>
 	</div>
		<table id="example1"
			class="table table-bordered table-hover my-2"
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
						aria-label="Browser: activate to sort column ascending">검토</th>
						

				</tr>
			</thead>

 
<%--  ${reqList} --%>


			<tbody>
			<c:forEach var="list" items="${reqList}">
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
                    <td>
                    <form action="/vacation/yVac" method="post" style="display : inline;">
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="empAttend_no" value="${vList.empAttend_no}">
                        <input type="hidden" name="user_no" value="${list.user_no}">
                        <button type="submit" class="btn btn-primary">승인</button>
                    </form>
<!-- 					<button type="button" class="btn btn-primary" id="submitBut">승인</button> -->
			         <button type="button" class="btn btn-primary" data-bs-toggle="modal"
			         data-bs-target="#rejectModal"  data-emp-attend-no="${vList.empAttend_no}">반려</button>
                    </td>
                </tr>
            </c:forEach>
        	</c:forEach>
			</tbody>

		</table>
	</div>
 
 	<!-- 반려사유 입력 모달창 시작 -->
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
               <input type="hidden" id="hiddenEmpAttendNo" name="hiddenEmpAttendNo">
               <h5>반려사유</h5>
               <div class="content">
                  <div class="form-group">
						<textarea id="reject_reason" name="reject_reason" rows="5" cols="55"
							placeholder="입력하세요."></textarea>
					</div>
                 
               </div>
             

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
 
 
 <script>
 
 var rejectModal = document.getElementById('rejectModal');
 rejectModal.addEventListener('show.bs.modal', function (event) {
     // 모달을 트리거한 버튼을 가져옵니다.
     var button = event.relatedTarget;
     // data-emp-attend-no 속성에서 값을 추출합니다.
     var empAttendNo = button.getAttribute('data-emp-attend-no');
     // 히든 필드에 값을 삽입합니다.
     var hiddenEmpAttendNo = rejectModal.querySelector('#hiddenEmpAttendNo');
     hiddenEmpAttendNo.value = empAttendNo;
 });
 
 
 
 //반려
 $(document).ready(function() {
     $('#rejectBtt').on('click', function() {
         var empAttend_no = $('#hiddenEmpAttendNo').val();
         var reject_reason = $('#reject_reason').val();
         
         // CSRF 토큰 값을 메타 태그에서 가져오기
         var token = $("meta[name='_csrf']").attr("content");
         var header = $("meta[name='_csrf_header']").attr("content");
         $.ajax({
             url: '/vacation/vacList',
             type: 'POST',
             data: {empAttend_no : empAttend_no, reject_reason :reject_reason},
             beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                 xhr.setRequestHeader(header, token);
             },
             success: function(response) {
                 alert("반려되었습니다.");
             	 history.go(0);
             },
             error: function(xhr, status, error) {
                 alert('실패 ' + error);
             }
         });
     });
 });
 
 
 </script>
 
 
 
 
 
 
  <%@ include file="../include/footer.jsp"%>