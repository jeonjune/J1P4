<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/empMenu.jsp"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@page import="com.itwillbs.domain.EmpAttendanceVO"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
    <script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        
        var calendar = new FullCalendar.Calendar(calendarEl, {
        	
       	dateClick: function(info) {
//        	    alert('Date: ' + info.dateStr);
       	 	const vaModal = new bootstrap.Modal('#vaModal', {});
   			vaModal.show();
   			$('#vacation_start').val(info.dateStr);
       	  },
        
       	 headerToolbar: {
       	      right: 'custom1 today prev,next'
       	    },
          	initialView: 'dayGridMonth',
          	customButtons: {
                custom1: {
                  text: '휴가신청',
                  click: function() {
                	  const vaModal = new bootstrap.Modal('#vaModal', {});
                	  vaModal.show();
                	  $('#vacation_start').val('');
//                 	  $('#vaModal').modal(); 
                  }
                }
              },
          	locale : 'ko',
     	  	selectable : true,
     	  	droppable : true,
     	  	editable : true,
     	  	events : [ 
     	      	    <%List<EmpAttendanceVO> calendarList = (List<EmpAttendanceVO>) request.getAttribute("calendarList");%>
     	              <%if (calendarList != null) {%>
     	              <%for (EmpAttendanceVO vo : calendarList) {%>
     	              {
     	              	title : '<%=vo.getV_name()%>-<%=vo.getVacation_status()%>',
     	                  start : '<%=vo.getVacation_start()%>',
     	                  end : '<%=vo.getVacation_end()%>',
     	                  color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
     	               },
     	  	<%}
     	  }%>
     	  				]
     	  	
        });
        calendar.render();
//         calendar.setOption('height', 700);
        calendar.setOption('contentHeight', 650);

      });

      
      // 휴가시작 종료일 반차일때 같은날로 고정하기
 		function syncAndLockDate(status) {
            var startDate = document.getElementById("vacation_start").value;
            if (startDate) {
                var start = new Date(startDate);
                if (status === "오후반차") {
                    start.setDate(start.getDate() + 1); // 오후 반차인 경우 하루를 더함
                }
                var endDate = document.getElementById("vacation_end");
                endDate.value = start.toISOString().split('T')[0]; // 날짜를 YYYY-MM-DD 형식으로 설정
                endDate.readOnly = true;
            }
        }

        // 휴가 상태를 확인하고 날짜를 동기화 및 고정하는 함수
        function checkVacationStatus() {
            var status = document.getElementById("vacation_status").value;
            if (status === "오전반차" || status === "오후반차") {
                syncAndLockDate(status);
            } else {
                var endDate = document.getElementById("vacation_end");
                endDate.value = "";
                endDate.readOnly = false;
            }
        }


    </script>
  <div class="content-wrapper" style="min-height: 831px;">
  
    <div id='calendar' style="background: #fff"></div>
    
    
    <!-- 휴가 모달창 시작 -->
	<div class="modal fade" id="vaModal" tabindex="-1"
		aria-labelledby="vaModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="vaModalLabel">휴가 신청서</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 모달창 바디(본문) -->
				<form action="" method="post" id="fm1" name="fm1">
 					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="modal-body">
					<div class="m-2">
					<div class="accordion-item">
					<div class="textRight">
						<select name="vacation_status" id="vacation_status" class="form-control" onchange="checkVacationStatus()">
							<option value="휴가">휴가</option>
							<option value="오전반차">오전 반차</option>
							<option value="오후반차">오후 반차</option>
							<option value="기타">기타 휴가</option>
						</select>
					</div>
					</div>
					<div class="form-group">
						<label>휴가 시작일</label> 
						<input type="date" name="vacation_start" class="form-control" id="vacation_start"  onchange="checkVacationStatus()" />
					</div>
					<div class="form-group">
						<label>휴가 종료일(출근일)</label>
						<input type="date" name="vacation_end" class="form-control" id="vacation_end" />
					</div>
					<p><span id="length">0</span> / 500자<p>
					<textarea rows="20" cols="200" name="vacation_reason" id="vacation_reason" 
					class="form-control" onkeyup="up()" placeholder="휴가 사유를 입력하세요."></textarea>
					</div>

				</div>
				</form>

				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary vaSendBtn"
						data-bs-dismiss="modal">전송하기</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 휴가 신청 모달창 끝 -->
    
  </div>
  
<script>
$(document).ready(function(){
	$('.vaSendBtn').click(function(){
		
		function getCurrentYear() {
		    const date = new Date();
		    return date.getFullYear();
		}
		
		var year = getCurrentYear();
				
		$.ajax({
			url : "/vacation/vacation",
			type : "POST",
			data : $("#fm1").serialize(),
			success : function(data) {
				console.log(data);
				if(data === "endVa"){
				Swal.fire({
					  icon: "error",
					  title: "휴가소진",
					  text: "올해 휴가를 다 썼군요!",
					});
// 				alert("남은 휴가가 없습니다.");					
				}else if(data === "overVa"){
				Swal.fire({
					  icon: "error",
					  title: "휴가부족",
					  text: "남은 휴가보다 많이 신청했습니다!",
					});
// 				alert("남은 휴가보다 많이 신청했습니다.");
					
				}else {					
				alert("휴가 신청완료 되었습니다.");
				window.location.href = '/employee/myVacation?date='+year;
				}
			},
			error : function() {
				alert("오류발생");
			}
		});
	});
});

/* 메시지 입력 내용 글자수 제한 */
function up(){
	var com = document.getElementById("vacation_reason");
	var len = document.getElementById("length");
	var val = com.value;
	//글자수 세기
	len.textContent = val.length;
	
	//글자수 제한
	if(val.length>500){
		com.value = val.substring(0,500);
		len.textContent = 500; //제한 후 글자수 업데이트
	}
}

</script>
  
  
  
 <%@ include file="../include/footer.jsp"%>