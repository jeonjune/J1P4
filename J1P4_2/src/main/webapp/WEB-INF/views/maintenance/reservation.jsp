<%@page import="com.itwillbs.domain.FacilityReservationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/facMenu.jsp"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>

    
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
    <script>


    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          
        	  headerToolbar: {
           	      right: 'custom1 today prev,next'
           	    },
              	initialView: 'dayGridMonth',
              	customButtons: {
                    custom1: {
                      text: '시설예약',
                      click: function() {
                    	  $('#faReservation_no').val('');
                    	  $('#rsv_name').val('');
                          $('#rsv_date').val('');
                          $('#rsv_day').val('');
                          $('#start_time').val('');
                          $('#end_time').val('');
                          $('#facility_name').val('');
                          $('#field').val('');
                          $('#count_people').val('');
                          $('#rsv_phone').val('');
                          $('.vaSendBtn').text('예약하기');
                    	  const vaModal = new bootstrap.Modal('#vaModal', {});
                    	  vaModal.show();
//                     	  $('#vaModal').modal(); 
                      }
                    }
                  },
              	locale : 'ko',
         	  	selectable : true,
         	  	droppable : true,
         	  	editable : true,
         	  	events: [
                    <% List<FacilityReservationVO> calendarList = (List<FacilityReservationVO>) request.getAttribute("calendarList"); %>
                    <% if (calendarList != null) { %>
                    <% for (FacilityReservationVO vo : calendarList) { %>
                    {
                        title: '<%= vo.getRsv_status() %>'+"-"+'<%=vo.getRsv_name() %>',  // 이벤트의 제목을 설정합니다.
                        start: '<%= vo.getRsv_date() %>',  // 이벤트의 시작 날짜를 설정합니다.
                        end: '<%= vo.getRsv_date() %>',  // 이벤트의 종료 날짜를 설정합니다.
                        color: '#' + Math.round(Math.random() * 0xffffff).toString(16),  // 이벤트의 색상을 랜덤으로 설정합니다.
                        rsv_name:'<%=vo.getRsv_name() %>',
                        rsv_date:'<%=vo.getRsv_date() %>',
                        rsv_day:'<%=vo.getRsv_day() %>',
                        start_time:'<%=vo.getStart_time() %>',
                        end_time:'<%=vo.getEnd_time() %>',
                        facility_name:'<%=vo.getFacility_name() %>',
                        field:'<%=vo.getField() %>',
                        count_people:'<%=vo.getCount_people() %>',
                        rsv_phone:'<%=vo.getRsv_phone() %>',
                        faReservation_no:'<%=vo.getFaReservation_no() %>'
                    },
                    
                    <% } %>
                    <% } %>
                ],
                eventClick: function(info){
                	const vaModal = new bootstrap.Modal('#vaModal2', {});
                	vaModal.show();
                 	$('#faReservation_no2').val(info.event.extendedProps.faReservation_no);
                 	$('#rsv_name2').val(info.event.extendedProps.rsv_name);
                 	$('#rsv_date2').val(info.event.extendedProps.rsv_date);
                 	$('#rsv_day2').val(info.event.extendedProps.rsv_day);
                 	$('#start_time2').val(info.event.extendedProps.start_time);
                 	$('#end_time2').val(info.event.extendedProps.end_time);
                 	$('#facility_name2').val(info.event.extendedProps.facility_name);
                 	$('#field2').val(info.event.extendedProps.field);
                 	$('#count_people2').val(info.event.extendedProps.count_people);
                 	$('#rsv_phone2').val(info.event.extendedProps.rsv_phone);
                }
          
        });
        calendar.render();
      });


    </script>
    
    <div class="content-wrapper" style="min-height: 831px;">
    <h1>시설예약</h1>
    <div id='calendar'></div>
    
      <!--시설예약 모달창 시작 -->
	<div class="modal fade" id="vaModal" tabindex="-1"
		aria-labelledby="vaModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="vaModalLabel">시설 예약</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 모달창 바디(본문) -->
				<form action="" method="post" id="fm1" name="fm1">
					 <form:form method="post" modelAttribute="FacilityReservationVO">
 					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="modal-body">
					<div class="m-2">
					<div class="accordion-item">
					
					<div class="form-group">
						<label>예약자</label> <input type="text" name="rsv_name" id="rsv_name"
							class="form-control" />
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#instructorModal">회원검색</button>	
					</div>
					
					   		<div class="form-group">
							<label>예약 날짜</label> 
							<input type="date" name="rsv_date" id="rsv_date" class="form-control" />
							</div>
                            
                      
                     <div class="textRight">
					 	<label style="text-align: left; display: block;">요일</label>
						<select name="rsv_day" id="rsv_day" class="form-control">
							<option value="월요일">월요일</option>
							<option value="화요일">화요일</option>
							<option value="수요일">수요일</option>
							<option value="목요일">목요일</option>
							<option value="금요일">금요일</option>
							<option value="토요일">토요일</option>
						</select>
					</div>
                            
                          <br>
					
					 	<div class="mb-3">
                                <label for="startTime" class="form-label">시작 시간</label>
                                <form:select path="start_time" id="start_time" class="form-control">
                                    <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                                   
                            </div>
                           
                            <div class="mb-3">
                                <label for="endTime" class="form-label">종료 시간</label>
                                <form:select path="end_time" id="end_time" class="form-control">
                                    <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                            </div>
					
					
					<div class="textRight">
					 	<label style="text-align: left; display: block;">예약시설</label>
						<select name="facility_name" id="facility_name" class="form-control">
							<option value="수영장">수영장</option>
							<option value="다목적체육관">다목적체육관</option>
							<option value="다목적강의실A">다목적강의실A</option>
							<option value="다목적강의실B">다목적강의실B</option>
							<option value="다목적강의실C">다목적강의실C</option>
						</select>
					</div>
					<br>
					<div class="form-group">
                            <label>분야</label>
                            <form:select path="field" class="form-control" id="field"> 
                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                    </div>
					
					</div>
					
					<div class="form-group">
						<label>인원 수</label> <input type="text" name="count_people" id="count_people"
							class="form-control" />
					</div>
					
					<div class="form-group">
							<label>연락처</label> <input type="text" name="rsv_phone" id="rsv_phone"
							class="form-control" maxlength="13" > 
						</div>

				</div>
				</div>
				</form:form>
				</form>
				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary vaSendBtn"
						data-bs-dismiss="modal">예약등록</button>
				</div>
						

			</div>
		</div>
	</div>
	<!-- 시설예약 모달창 끝 -->
	
    
    <!-- 회원검색 모달 -->
   <div class="modal fade" id="instructorModal" tabindex="-1" aria-labelledby="instructorModalLabel" aria-hidden="true" style="z-index:1060;">
       <div class="modal-dialog modal-lg"> <!-- modal-lg 클래스로 크기 조정 -->
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title" id="instructorModalLabel">회원 찾기</h5>
                   <input type="hidden" id="instructorNo" name="mem_no">
                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                   <div class="mb-3">
                       <label for="instructorSearch" class="form-label">이름을 입력해주세요.</label>
                       <input type="text" class="form-control" id="instructorSearch" placeholder="Enter instructor name">
                   </div>
                   <table class="table table-bordered">
                       <thead>
                           <tr>
                               <th></th>
                               <th>회원번호</th>
                               <th>이름</th>
                               <th>연락처</th>
                           </tr>
                       </thead>
                       <tbody id="instructorTableBody">
                           <!-- 강사 검색 시 동적으로 생성된 강사 목록을 표시하기 위함.(서버에서 데이터를 받아 이곳에 삽입) -->
                       </tbody>
                   </table>
                   <button type="button" class="btn btn-primary" id="selectInstructorButton">선택</button>
               </div>
           </div>
       </div>
   </div>
    <!-- 회원검색 모달 끝 -->
    
    
    
 	
 	  <!------시설예약 수정/삭제 모달창 시작------------------------------------------ -->
 	  
	<div class="modal fade" id="vaModal2" tabindex="-1"
		aria-labelledby="vaModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="vaModalLabel">시설 예약</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 모달창 바디(본문) -->
				<form action="" method="post" id="fm2" name="fm2">
				 <form:form method="post" modelAttribute="FacilityReservationVO">
				<input type="hidden" name="faReservation_no" id="faReservation_no2">
					
 					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="modal-body">
					<div class="m-2">
					<div class="accordion-item">
					
					<div class="form-group">
						<label>예약자</label> <input type="text" name="rsv_name" id="rsv_name2"
							class="form-control" />
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#instructorModal2">회원검색</button>	
					</div>
					
					   		<div class="form-group">
							<label>예약 날짜</label> 
							<input type="date" name="rsv_date" id="rsv_date2" class="form-control" />
							</div>
                            
                      
                     <div class="textRight">
					 	<label style="text-align: left; display: block;">요일</label>
						<select name="rsv_day" id="rsv_day2" class="form-control">
							<option value="월요일">월요일</option>
							<option value="화요일">화요일</option>
							<option value="수요일">수요일</option>
							<option value="목요일">목요일</option>
							<option value="금요일">금요일</option>
							<option value="토요일">토요일</option>
						</select>
					</div>
                            
                          <br>
					
					 	<div class="mb-3">
                                <label for="startTime" class="form-label">시작 시간</label>
                                
                                <form:select path="start_time" id="start_time2" class="form-control">
                                    <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                                 
                            </div>
                           
                            <div class="mb-3">
                                <label for="endTime" class="form-label">종료 시간</label>
                               
                                <form:select path="end_time" id="end_time2" class="form-control">
                                    <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                               
                            </div>
					
					
					<div class="textRight">
					 	<label style="text-align: left; display: block;">예약시설</label>
						<select name="facility_name" id="facility_name2" class="form-control">
							<option value="수영장">수영장</option>
							<option value="다목적체육관">다목적체육관</option>
							<option value="다목적강의실A">다목적강의실A</option>
							<option value="다목적강의실B">다목적강의실B</option>
							<option value="다목적강의실C">다목적강의실C</option>
						</select>
					</div>
					<br>
					<div class="form-group">
                            <label>분야</label>
					
                            <form:select path="field" class="form-control" id="field2"> 
                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                    </div>
					
					</div>
					
					<div class="form-group">
						<label>인원 수</label> <input type="text" name="count_people" id="count_people2"
							class="form-control" />
					</div>
					
					<div class="form-group">
							<label>연락처</label> <input type="text" name="rsv_phone" id="rsv_phone2"
							class="form-control" maxlength="13" > 
						</div>

				</div>
				</div>
				</form:form>
				</form>
				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary vaUpdateBtn"
						data-bs-dismiss="modal">예약수정</button>
					<button type="button" class="btn btn-primary vaDeleteBtn"
						data-bs-dismiss="modal">예약삭제</button>
				</div>
						

			</div>
		</div>
	</div>
	 <!--시설예약 수정/삭제 모달창 시작 -->
    
    
    
     <!-- 수정모달 회원검색 모달 -->
   <div class="modal fade" id="instructorModal2" tabindex="-1" aria-labelledby="instructorModalLabel" aria-hidden="true" style="z-index:1060;">
       <div class="modal-dialog modal-lg"> <!-- modal-lg 클래스로 크기 조정 -->
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title" id="instructorModalLabel">회원 찾기</h5>
                   <input type="hidden" id="instructorNo" name="mem_no">
                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                   <div class="mb-3">
                       <label for="instructorSearch2" class="form-label">이름을 입력해주세요.</label>
                       <input type="text" class="form-control" id="instructorSearch2" placeholder="Enter instructor name">
                   </div>
                   <table class="table table-bordered">
                       <thead>
                           <tr>
                               <th></th>
                               <th>회원번호</th>
                               <th>이름</th>
                               <th>연락처</th>
                           </tr>
                       </thead>
                       <tbody id="instructorTableBody2">
                           <!-- 강사 검색 시 동적으로 생성된 강사 목록을 표시하기 위함.(서버에서 데이터를 받아 이곳에 삽입) -->
                       </tbody>
                   </table>
                   <button type="button" class="btn btn-primary" id="selectInstructorButton2">선택</button>
               </div>
           </div>
       </div>
   </div>
    <!-- 수정모달 회원검색 모달 끝 -->
    
    
 	
    
  </div>
    

    
   <script>
   //스크립트시작
   const csrfToken = $('meta[name="_csrf"]').attr('content');
   const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
   
   
   $(document).ready(function(){
		$('.vaSendBtn').click(function(){
			
			$.ajax({
				url : "/maintenance/reservation",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					alert("시설예약이 완료되었습니다.");
					history.go(0);
				
				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});
   
  
   $(document).ready(function(){
		$('.vaDeleteBtn').click(function(){
			$.ajax({
				url : "/maintenance/rsvDelete",
				type : "POST",
				data : $("#fm2").serialize(),
				success : function(data) {
					alert("시설예약이 취소되었습니다.");
					history.go(0);
				
				},
				error : function() {
					alert("오오류류");
				}
			});
		});
	});
   
   $(document).ready(function(){
		$('.vaUpdateBtn').click(function(){
			$.ajax({
				url : "/maintenance/rsvUpdate",
				type : "POST",
				data : $("#fm2").serialize(),
				success : function(data) {
					alert("시설예약이 수정되었습니다.");
					history.go(0);
				
				},
				error : function() {
					alert("오류오류");
				}
			});
		});
	});
   
  
   //--------------------------------------------------------------------------------시설예약 - 회원검색
   
   //회원이름 검색하는 입력창
   $('#instructorSearch').on('input', function() {
	   //alert("입력");
       const keyword = $(this).val();
       if (keyword.length > 0) {
           $.ajax({
               url: '/maintenance/memSearch',
               method: 'GET',
               data: { keyword: keyword },
               beforeSend: function(xhr) {
                   xhr.setRequestHeader(csrfHeader, csrfToken);
               },
               success: function(data) {
                   const instructorTableBody = $('#instructorTableBody');
                   instructorTableBody.empty(); // 이전 검색결과 비우기
                   data.forEach(function(member) {//검색결과값들
                       const row = '<tr>' +
                                   '<td><input type="checkbox" name="instructorCheckbox" value="' + member.mem_no + '"></td>' +
                                   '<td>' + member.mem_no + '</td>' +
                                   '<td>' + member.mem_name + '</td>' +
                                   '<td>' + member.mem_phone + '</td>' +
                                '</tr>';
                       instructorTableBody.append(row);
                   });
               },
               error: function(error) {
                   alert('오류');
               }
           });
       }
   });
   
   
   
   $('#selectInstructorButton').on('click', function(event) { //회원검색 모달창 <선택>버튼
	  
       event.preventDefault(); //호출하여 버튼 클릭 시 발생할 수 있는 기본 동작(예: 폼 제출)을 방지
       const selectedInstructor = $('input[name="instructorCheckbox"]:checked').val(); //체크된 체크박스 정보를 담는 변수
       const selectedMemName = $('input[name="instructorCheckbox"]:checked').closest('tr').find('td:nth-child(3)').text();
       const selectedMemPhone = $('input[name="instructorCheckbox"]:checked').closest('tr').find('td:nth-child(4)').text();

       if (!selectedInstructor) {
           alert('Please select an instructor.');
           return;
       }

       $('#instructorNo').val(selectedInstructor);
       $('#rsv_name').val(selectedMemName);
       $('#rsv_phone').val(selectedMemPhone);
       $('#instructorModal').modal('hide');
       
       $('#instructorModal').on('hidden.bs.modal', function () { //2번모달창 끄면 1번모달창 안 움직임 해결
    	    if ($('.modal:visible').length) { // 열려 있는 모달이 있는지 확인
    	        $('body').addClass('modal-open'); // 'modal-open' 클래스를 다시 추가
    	    }
    	});
       
   });
   
   
  //----------------------------------------캘린더클릭-수정모달창 시작-------------------------------------------------------
  	
  
  	 //회원이름 검색하는 입력창
   $('#instructorSearch2').on('input', function() {
	   //alert("입력");
       const keyword = $(this).val();
       if (keyword.length > 0) {
           $.ajax({
               url: '/maintenance/memSearch',
               method: 'GET',
               data: { keyword: keyword },
               beforeSend: function(xhr) {
                   xhr.setRequestHeader(csrfHeader, csrfToken);
               },
               success: function(data) {
                   const instructorTableBody = $('#instructorTableBody2');
                   instructorTableBody.empty(); // 이전 검색결과 비우기
                   data.forEach(function(member) {//검색결과값들
                       const row = '<tr>' +
                                   '<td><input type="checkbox" name="instructorCheckbox" value="' + member.mem_no + '"></td>' +
                                   '<td>' + member.mem_no + '</td>' +
                                   '<td>' + member.mem_name + '</td>' +
                                   '<td>' + member.mem_phone + '</td>' +
                                '</tr>';
                       instructorTableBody.append(row);
                   });
               },
               error: function(error) {
                   alert('오류');
               }
           });
       }
   });
  
  
  
   //수정모달 회원찾기
    $('#selectInstructorButton2').on('click', function(event) { //회원검색 모달창 <선택>버튼
       event.preventDefault(); //호출하여 버튼 클릭 시 발생할 수 있는 기본 동작(예: 폼 제출)을 방지
       const selectedInstructor = $('input[name="instructorCheckbox"]:checked').val(); //체크된 체크박스 정보를 담는 변수
       const selectedMemName = $('input[name="instructorCheckbox"]:checked').closest('tr').find('td:nth-child(3)').text();
       const selectedMemPhone = $('input[name="instructorCheckbox"]:checked').closest('tr').find('td:nth-child(4)').text();

       if (!selectedInstructor) {
           alert('Please select an instructor.');
           return;
       }

       $('#instructorNo').val(selectedInstructor);
       $('#rsv_name2').val(selectedMemName);
       $('#rsv_phone2').val(selectedMemPhone);
       $('#instructorModal2').modal('hide');
       
       $('#instructorModal2').on('hidden.bs.modal', function () { //2번모달창 끄면 1번모달창 안 움직임 해결
    	    if ($('.modal:visible').length) { // 열려 있는 모달이 있는지 확인
    	        $('body').addClass('modal-open'); // 'modal-open' 클래스를 다시 추가
    	    }
    	});
       
   });
   
   
   
   </script> 

    
    
  
    
 <%@ include file="../include/footer.jsp"%>  