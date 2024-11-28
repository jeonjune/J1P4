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
//                           $('#start_time').val('');
//                           $('#end_time').val('');
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
//                  	$('#start_time2').val(info.event.extendedProps.start_time);
//                  	$('#end_time2').val(info.event.extendedProps.end_time);
                 	$('#facility_name2').val(info.event.extendedProps.facility_name);
                 	$('#field2').val(info.event.extendedProps.field);
                 	$('#count_people2').val(info.event.extendedProps.count_people);
                 	$('#rsv_phone2').val(info.event.extendedProps.rsv_phone);
                },
                
            //시설예약 현황 폼
            dateClick: function(info) {
            // 날짜에 대한 정보를 폼에 미리 채워 넣을 수 있습니다.
            $('#rsv_date').val(info.dateStr); // 선택한 날짜를 폼에 넣음
            const newVaModal = new bootstrap.Modal('#vaModal', {});
            newVaModal.show();
        }
          
        });
        calendar.render();
        calendar.setOption('contentHeight', 650);
      });


    </script>
    
    <div class="content-wrapper" style="min-height: 831px;">
    <div id='calendar' style="background: #fff;"></div>
    
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
<%--  					<input type="hidden" name="faReservation_no" value="${param.faReservation_no }"> --%>
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
							<option value="">선택하세요.</option>
							<option value="월요일">월요일</option>
							<option value="화요일">화요일</option>
							<option value="수요일">수요일</option>
							<option value="목요일">목요일</option>
							<option value="금요일">금요일</option>
							<option value="토요일">토요일</option>
						</select>
					</div>		
                      <br>
                      
                     <div class="textRight">
					 	<label style="text-align: left; display: block;">예약시설</label>
						<select name="facility_no" id="facility_no" class="form-control">
							<option value="">선택하세요.</option>
							<option value="7">수영장</option>
							<option value="2">다목적체육관</option>
							<option value="3">다목적강의실A</option>
							<option value="4">다목적강의실B</option>
							<option value="5">다목적강의실C</option>
						</select>
					</div>
					<br>       
                            
                         <div class="form-group">
							<label>이용 시간</label> <input type="text" name="time1" id="time"
							class="form-control" />
					     </div>
					     
					     <div class="form-group">
							<label>회차</label> <input type="text" name="round" id="round"
							class="form-control" />
					     </div>
					
					
					<div class="form-group">
                            <label>분야</label>
                            <form:select path="field" class="form-control" id="field"> 
                            	<form:option value="">선택하세요.</form:option>
                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                    </div>
					
					</div>
					
					<div class="form-group">
						<label>인원 수</label> <input type="number" name="count_people" id="count_people"
							class="form-control" />
					</div>
					
					 <div class="form-group">
							<label>총 시간</label> <input type="number" name="total_time" id="total_time"
							class="form-control" />
					  </div>
					
					<div class="form-group">
						<label>결제 금액</label> <input type="number" name="total_price" id="total_price"
							class="form-control" readonly="readonly"/>
					</div>
					
					<div class="form-group">
							<label>연락처</label> <input type="number" name="rsv_phone" id="rsv_phone"
							class="form-control" maxlength="13" > 
						</div>
					 <span id="checkModal" style="font-size: 14px;"></span>	
				</div>
				</div>
				</form:form>
				</form>
				<!-- 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary vaSendBtn2"
						>입력완료</button>
					<button type="button" class="btn btn-primary vaSendBtn"
						>예약하기</button>
				</div>
						

			</div>
		</div>
	</div>
	<!-- 시설예약 모달창 끝 -->
	
	<!-- 시설현황 11/11 -->
	<!-- 두 번째 모달창 시작 -->
<div class="modal fade" id="timeSlotModal" tabindex="-1" aria-labelledby="timeSlotModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- 모달창 헤더 -->
            <div class="modal-header">
                <h5 class="modal-title" id="timeSlotModalLabel">시간대 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- 모달창 바디 -->
            <div class="modal-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>회차</th>
                            <th>시간</th>
                            <th>예약상태</th>
                        </tr>
                    </thead>
                    <tbody id="timeSlotTableBody">
                        <!-- JavaScript로 동적 시간대 로드 -->
                    </tbody>
                </table>
            </div>

            <!-- 모달창 푸터 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="confirmTimeSlot">선택 완료</button>
            </div>
        </div>
    </div>
</div>
<!-- 두 번째 모달창 끝 -->
	<!-- 시설현황 끝 11/11 -->
	
    
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
    

  <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>  
   <script>
   //스크립트시작
 $(document).ready(function () {
   const csrfToken = $('meta[name="_csrf"]').attr('content');
   const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
   
    IMP.init('imp45738827'); // 고객사 식별 코드를 입력합니다.
   
	     $('.vaSendBtn2').click(function(){ //입력완료 버튼 누르면 결제금액 나타남.
	    	
	   // 결제금액 계산 코드--------------------------------
	     function calculateValues() {
	          var countPeople = parseInt($('#count_people').val()) || 0;
	          var totalTime =  $('#total_time').val(); //총시간
	          const pricePerPerson = 5000;


             // 결제 금액 계산 (5000원 * 인원 수 * 이용 시간)
             var totalPrice = totalTime * countPeople * pricePerPerson;
             $('#total_price').val(totalPrice); // 결제 금액을 콤마 포함하여 표시

	      }
	   
	     $('#start_time, #end_time, #count_people').on('input', calculateValues);
	    	 calculateValues();
	     });
	     
	     
	   //---------------------------------------------
	   
	   
		$('.vaSendBtn').click(function(){ //예약하기 버튼
			
			//빈칸검사
		    var rsv_name = $('#rsv_name').val();
	        var rsv_date = $('#rsv_date').val();
	        var count_people = $('#count_people').val();
	        var rsv_phone = $('#rsv_phone').val();
        
		        if (rsv_name == "" || rsv_date == "" || count_people == "" || rsv_phone == "") {
		            //alert("빈칸을 모두 입력해주세요.");
		            $('#checkModal')
					.html(
							'빈칸을 모두 입력해주세요.')
					.css('color', 'red');
		            return;
		        }else {
		        	 $('#varModal').modal('hide');
		        }
		       
		        if($('#end_time ').val() == "" || $('#rsv_day').val() == "" || $('#start_time').val() == "" ||
		        		$('#facility_name').val() == "" || $('#field').val() == ""){
		        	   //alert("선택하지 않은 필드를 선택해주세요.");
		        	 $('#checkModal')
					.html(
							'선택하지 않은 필드를 선택해주세요.')
					.css('color', 'red');
		            return;
		           } else {
		        	   $('#varModal').modal('hide');
		           }
			
		    //시설예약 결제시작
		    const classPrice =  $('#total_price').val();
		    		    
		     IMP.request_pay({
                pg: 'kakaopay',
                pay_method: 'card',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: 'J1P4 Sports 시설예약',
                amount: classPrice,
                buyer_email: 'buyer@example.com',
                buyer_name: '구매자 이름',
                buyer_tel: '010-1234-5678',
                buyer_addr: '서울특별시 강남구 삼성동',
                buyer_postcode: '123-456'
            }, function (rsp) {
                if (rsp.success) {
                	 const formDataArray = $('#fm1').serializeArray(); 
                	 console.table(formDataArray);
                	 
                	 formDataArray.forEach((item, index) => {
                		    console.log(`Item ${index + 1}:`, item);
                		});
                	 //폼 데이터를 JSON 형식으로 변환: $("#fm1").serialize()는 URL-encoded 데이터를 생성하므로, 
                	 //이를 JSON으로 변환해야 합니다. serializeArray()를 사용하여 폼 데이터를 배열로 만든 뒤 JSON 형식으로 변환할 수 있습니다.
                     const reservation = {};
                     $.each(formDataArray, function(index, field) {
                         reservation[field.name] = field.value;
                     }); // 여기까지가 json으로 변환한 것.
                     
                    const paymentInfo = {
                        amount: rsp.paid_amount,
                        paymentStatus: 'Paid',
                        paymentMethod: rsp.pay_method,
                        transactionId: rsp.imp_uid,
                        merchantId: rsp.merchant_uid
                    };

                    const requestData = {
                    	reservation: reservation,
                        paymentInfo: paymentInfo
                    };

                    console.log("Sending request data: ", requestData); 
                 
                    $.ajax({
                        url: '/maintenance/reservation',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(requestData),
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(response) {
                            alert('결제가 성공적으로 완료되었습니다.');
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            alert('결제 처리 중 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
			
		    //----------------------------------------------------

		}); //결제api, 시설등록 insert완료
	
   

		$('.vaDeleteBtn').click(function(){ //예약취소
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

   
//    $(document).ready(function(){
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
// 	}); // 시설 예약 수정
   
  
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
   }); // 회원 이름 검색
   
   
   
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
       
   }); // 회원검색 모달창
   
   
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
   }); // 회원 이름 검색
  
  
  
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
       
   }); // 수정모달 회원 찾기
   
   
   
  	//시설현황 11/11

    // 시설 선택 시 시간대 조회
    $('#facility_no').change(function () {
	const facNo = parseInt($(this).val(), 10); // 문자열을 정수로 변환
	let facName = ""; 
        //const facNo = $('#facility_no').val();
        alert(facNo);

        // facility_name 값을 설정
        switch (facNo) {
            case 7:
            	facName = "수영장";
                break;
            case 2:
            	facName = "다목적체육관";
                break;
            case 3:
            	facName = "다목적강의실A";
                break;
            case 4:
            	facName = "다목적강의실B";
                break;
            case 5:
            	facName = "다목적강의실C";
                break;
            default:
            	facName = "";
                break;
        } // switch
    
 		
        const rsvDate = $('#rsv_date').val(); //날짜 선택
        
        if(!rsvDate){
        	alert('예약날짜를 선택해주세요.');
        	return;
        }

        // Ajax 요청을 통해 시간대 데이터를 가져옴
        $.ajax({
            url: '/maintenance/timeSelect',
            type: 'GET',
            data: { facility_no: facNo, rsv_date: rsvDate},
            success: function (data) {
                const tableBody = $('#timeSlotTableBody'); // tbody 부분
                tableBody.empty(); // 기존 데이터를 초기화

                // 가져온 데이터를 테이블에 추가
                data.forEach(function (item) {
                	console.log(item);
                    const statusText = item.status_no == 0 ? '예약가능' : '<span style="color: red;">예약완료</span>';
                    const isDisabled = item.status_no != 0; // 예약완료 상태면 비활성화
                    $('#timeSlotTableBody').append(
                            "<tr>" +
                            "<td><input type='checkbox' name='imeSlot' " + (isDisabled ? "disabled" : "") + "></td>" +
                            "<td>" + item.round + "</td>" +
                            "<td>" + item.time + "</td>" +
                            "<td>" + statusText + "</td>" +
                            "</tr>"
                        );
                });
                // 두 번째 모달창 표시
                $('#timeSlotModal').modal('show');
            },
            error: function (error) {
                console.error("시간대 데이터를 가져오는 중 오류 발생:", error);
            }
        });
    }); //시설현황


     
    //1.연속된 체크박스만 선택할 수 있도록 2.체크박스는 최대 3개 선택 가능하도록 제한
    $(document).ready(function () {
    let lastCheckedIndex = -1; // 마지막으로 선택된 체크박스의 인덱스

    // 체크박스 선택 시 동작
    $(document).on('change', 'input[name="imeSlot"]', function () {
        const allCheckboxes = $('input[name="imeSlot"]'); // 모든 체크박스
        const checkedCheckboxes = $('input[name="imeSlot"]:checked'); // 선택된 체크박스
        const currentCheckedIndex = allCheckboxes.index(this); // 현재 선택된 체크박스의 인덱스

        // 첫 번째 체크박스 선택은 항상 허용
        if (lastCheckedIndex === -1) {
            lastCheckedIndex = currentCheckedIndex;
            return;
        }

        // 연속된 체크박스인지 확인
        let isValid = true;
        checkedCheckboxes.each(function (index, checkbox) {
            const currentIndex = allCheckboxes.index(checkbox);

            // 체크된 체크박스가 연속되지 않았는지 확인
            if (index > 0) {
                const prevIndex = allCheckboxes.index(checkedCheckboxes.get(index - 1));
                if (currentIndex !== prevIndex + 1) {
                    isValid = false;
                    return false; // 반복문 종료
                }
            }
        });

        if (!isValid) {
            alert('연속된 시간대만 선택할 수 있습니다.');
            $(this).prop('checked', false); // 현재 선택된 체크박스 선택 해제
            return;
        }

        // 마지막 선택된 체크박스의 인덱스 업데이트
        lastCheckedIndex = currentCheckedIndex;

        // 체크박스 최대 3개 선택 가능
        if (checkedCheckboxes.length > 3) {
            alert('최대 3개의 시간대만 선택할 수 있습니다.');
            $(this).prop('checked', false); // 현재 선택된 체크박스 선택 해제
            return;
        }
    }); // 선택 체크박스
	}); // 체크박스 선택

    

    // 선택 완료 버튼 클릭 이벤트
    $('#confirmTimeSlot').on('click', function (event) {
        event.preventDefault(); // 기본 동작 방지

        const selectedBoxes = $('input[name="imeSlot"]:checked');
        if (selectedBoxes.length === 0) {
            alert('시간을 선택해주세요.');
            return;
        }

        if (selectedBoxes.length > 3) {
            alert('최대 3개까지만 선택 가능합니다.');
            return;
        }

        const times = []; // 선택된 시간대를 저장할 배열
        const rounds = []; // 선택된 회차를 저장할 배열

        selectedBoxes.each(function () {
            const selectTime = $(this).closest('tr').find('td:nth-child(3)').text();
            const selectRound = $(this).closest('tr').find('td:nth-child(2)').text();
            times.push(selectTime.trim()); // 선택된 시간 추가
            rounds.push(selectRound.trim()); // 선택된 회차 추가
        });

        // 쉼표로 구분하여 한 줄에 입력
        $('#time').val(times.join(',')); // 전체 시간대를 쉼표로 구분하여 저장
        $('#round').val(rounds.join(',')); // 전체 회차를 쉼표로 구분하여 저장
        
        //회차차배열길이로 총시간 구하기 -------------------------------11/21
        const roundInput = document.getElementById("round"); //회차입력칸
        const totalTime = document.getElementById("total_time"); //총시간입력칸
        alert(roundInput.value); //회차값 확인
  
        
        function updateTotalTime() {
            // 회차 입력칸 값 가져오기
            const rounds = roundInput.value;

            if (rounds.trim() === "") {
                // 입력값이 없으면 총시간을 0으로 설정
                totalTime.value = 0;
                return;
            }

            // 쉼표로 분리하여 개수 계산
            const roundArray = rounds.split(","); // 쉼표로 문자열 분리
            totalTime.value = roundArray.length; // 배열 길이 = 총시간
        }
			
        updateTotalTime(); // 총시간계산 함수 업데이트
        
        //---------------------------------11/21 끝
        

        // 숨겨진 필드를 동적으로 추가하거나 값을 나눠 저장
        const form = $('#fm1'); // 첫 번째 모달창 폼
        form.find('.dynamic-time').remove();  // 동적으로 추가된 숨겨진 필드만 제거

        // 동적으로 숨겨진 필드 추가 (input태크에 class="dynamic-time" 추가)
        form.append('<input type="hidden" class="dynamic-time" name="time1" value="' + (times[0] || '') + '">');
        if (times[1]) {
            form.append('<input type="hidden" class="dynamic-time" name="time2" value="' + times[1] + '">');
        }
        if (times[2]) {
            form.append('<input type="hidden" class="dynamic-time" name="time3" value="' + times[2] + '">');
        }

        $('#timeSlotModal').modal('hide');

        $('#timeSlotModal').on('hidden.bs.modal', function () {
            if ($('.modal:visible').length) { // 열려 있는 모달이 있는지 확인
                $('body').addClass('modal-open'); // 'modal-open' 클래스를 다시 추가
            }
        });
    }); // 선택 완료
  
});
</script> 

    
    
  
    
 <%@ include file="../include/footer.jsp"%>  