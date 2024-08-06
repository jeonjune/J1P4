<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/memMenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="card cardCustom">
	
    	<div class="cardMargin col-md-10">
        <div class="row d-flex align-items-stretch">
    <!-- 좌측 카드 -->
    <!-- 수강 분포 카드 시작 -->
    <div class="card col-md-6 d-flex flex-column">
        <!-- 수강 분포 카드 헤더 -->
        <div class="card-header border-0 ui-sortable-handle">
            <h3 class="card-title">
                <i class="fas fa-chart-pie mr-1"></i> 수강 분포
            </h3>
        </div>

        <!-- 수강 분포 카드 바디 -->
        <div class="card-body flex-fill">
            <!-- 분포 그래프 -->
            <div class="tab-content p-4">
                <!-- 값이 없는 회원(신규회원)에게 출력될 안내문구 -->
                <div class='ifNull'></div>
                
                <div class="chart" style="position: relative; height: 400px;">
                    <div class="chartjs-size-monitor">
                        <div class="chartjs-size-monitor-expand">
                            <div class=""></div>
                        </div>
                        <div class="chartjs-size-monitor-shrink">
                            <div class=""></div>
                        </div>
                    </div>
                    <canvas id="age-chart" height="400" style="height: 400px; display: block; width: 100%;" width="900" class="chartjs-render-monitor"></canvas>
                </div>
            </div>
            <!-- 분포 그래프 -->
            
            <!-- 수강 상세내용 출력 -->
            <div class="printDetails"></div>
        </div>
    </div>
    <!-- 수강 분포 카드 끝 -->

    <!-- 우측 카드 묶음 -->
    <div class="col-md-6 d-flex flex-column">
        <!-- 현재 수강중인 강의 카드 시작 -->
        <div class="card flex-fill">
            <!-- 현재 수강중인 강의 카드 헤더 -->
            <div class="card-header border-0 ui-sortable-handle">
                <h3 class="card-title">
                    <i class="fas fa-th mr-1"></i> 현재 수강중인 강의
                </h3>
                
                <!-- 페이징 처리 -->
                <div class="card-tools">
                    <!-- 수강중인 강의가 2개 이상부터 페이징처리 시작 -->
                    <c:if test="${normalCount > 1}">
                        <ul class="pagination pagination-sm">
                            <!-- 이전버튼 -->
                            <li class="page-item prevButt"></li>
                            <!-- 다음버튼 -->
                            <li class="page-item nextButt">
                                <a href="#" class="page-link">»</a>
                            </li>
                        </ul>
                    </c:if>
                </div>
            </div>

            <!-- 현재 수강중인 강의 카드 바디 -->
            <div class="card-body flex-fill">
                <!-- 현재 수강중인 강의 출력 -->
                <div class="tab-content p-0 printClassNormal">
                    <c:forEach items="${statusNormal }" var="normal">
                        <c:forEach items="${normal.classScheduleList }" var="classList">
                            <c:forEach items="${classList.classList }" var="classDetail">
                                <img alt="${classDetail.fieldCode }" width="70px;" src="${pageContext.request.contextPath }/resources/img/${classDetail.fieldCode }.png">
                                강의명: ${classDetail.className }<br>
                                상세내용: ${classDetail.description }<br>
                                강의코드: ${classDetail.fieldCode }<br>
                                강의수준: ${classDetail.divisionCode }<br>
                                강의레벨: ${classDetail.levelCode }<br>
                                최대인원: ${classDetail.maxCapacity }<br>
                                최소인원: ${classDetail.minCapacity }<br>
                                강사: <c:forEach items="${normal.empList }" var="empList">
                        		${empList.name }</c:forEach><br>
                            </c:forEach>
                            기간 : ${classList.startDate } ~ ${classList.endDate }<br>
                            매주 ${classList.recurrenceDays }<br>
                            시간 : ${classList.startTimeCode }~ ${classList.endTimeCode }<br>
                        </c:forEach>
                        
                        등록일 : ${normal.registration_date }<br>
                    </c:forEach>

                    <!-- 수강중인 강의가 없을 경우 출력 -->
                    <c:if test="${empty statusNormal }">
                        <div style="padding: 75px;">
                            값이 없습니데이
                        </div>
                    </c:if>
                </div>
                <!-- 현재 수강중인 강의 출력 -->
            </div>
        </div>
        <!-- 현재 수강중인 강의 카드 끝 -->

        <!-- 수강 신청 목록 카드 시작 -->
        <div class="card mt-3 flex-fill">
            <!-- 수강 신청 목록 카드 헤더 -->
            <div class="card-header border-0 ui-sortable-handle">
                <h3 class="card-title">
                    <i class="fas fa-th mr-1"></i> 수강 신청 목록
                </h3>
                
                <!-- 페이징 처리 -->
                <div class="card-tools">
                    <!-- 수강신청한 강의가 2개 이상부터 페이징처리 시작 -->
                    <c:if test="${recruitCount > 1}">
                        <ul class="pagination pagination-sm">
                            <!-- 이전버튼 -->
                            <li class="page-item prevRecruitButt"></li>
                            <!-- 다음버튼 -->
                            <li class="page-item nextRecruitButt">
                                <a href="#" class="page-link">»</a>
                            </li>
                        </ul>
                    </c:if>
                </div>
            </div>

            <!-- 수강 신청 목록 카드 바디 -->
            <div class="card-body flex-fill">
                <!-- 수강 신청 목록 출력 -->
                <div class="tab-content p-0 printClassRecruit">
                    <c:forEach items="${statusRecruit }" var="recruit">
                        <c:forEach items="${recruit.classScheduleList }" var="classList">
                            <c:forEach items="${classList.classList }" var="classDetail">
                                <img alt="${classDetail.fieldCode }" width="70px;" src="${pageContext.request.contextPath }/resources/img/${classDetail.fieldCode }.png">
                                강의명: ${classDetail.className }<br>
                                상세내용: ${classDetail.description }<br>
                                강의코드: ${classDetail.fieldCode }<br>
                                강의수준: ${classDetail.divisionCode }<br>
                                강의레벨: ${classDetail.levelCode }<br>
                                최대인원: ${classDetail.maxCapacity }<br>
                                최소인원: ${classDetail.minCapacity }<br>
                                강사: <c:forEach items="${recruit.empList }" var="empList">
                        		${empList.name }</c:forEach><br>
                            </c:forEach>
                            기간 : ${classList.startDate } ~ ${classList.endDate }<br>
                            매주 ${classList.recurrenceDays }<br>
                            시간 : ${classList.startTimeCode }~ ${classList.endTimeCode }<br>
                        </c:forEach>
                        등록일 : ${recruit.registration_date }<br>
                    </c:forEach>

                    <!-- 수강 신청 목록이 없을 경우 출력 -->
                    <c:if test="${empty statusRecruit }">
                        <div style="padding: 75px;">
                            값이 없습니데이
                        </div>
                    </c:if>
                </div>
                <!-- 수강 신청 목록 출력 -->
            </div>
        </div>
        <!-- 수강 신청 목록 카드 끝 -->
    </div>
    <!-- 우측 카드 묶음 -->
</div>
  	  </div>
    
	</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	//서버에서 전달된 JSON 문자열을 `classCountJson` 변수에 저장
	var classCountJson = '<c:out value="${vo}" escapeXml="false"/>';
	console.log("(❁´◡`❁) Raw JSON: ", classCountJson);
	var data = JSON.parse(classCountJson);
	
	// alert(classCountJson.trim()=='[]');
	if(classCountJson.trim()=='[]'){
		$('.ifNull').html("아무 값도 없습니다"+'<i class="fas fa-circle-xmark mr-1"></i>');
	}
	
	var field_code = data.map(function(item) { return item.field_code; });
	var class_count = data.map(function(item) { return item.class_count; });
	console.log("field_code: ", field_code);
	console.log("class_count: ", class_count);

	var ageCtx = document.getElementById('age-chart').getContext('2d');

	var ageChart = new Chart(ageCtx, {
	    type: 'doughnut',
	    data: {
	        labels: field_code,
	        datasets: [{
	            data: class_count,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)', // 에어로빅 - 파스텔 레드
	                'rgba(75, 192, 192, 0.2)', // 배드민턴 - 파스텔 청록색
	                'rgba(255, 206, 86, 0.2)', // 피트니스 - 파스텔 노랑
	                'rgba(54, 162, 235, 0.2)', // 필라테스 - 파스텔 파랑
	                'rgba(153, 102, 255, 0.2)', // 수영 - 파스텔 보라
	                'rgba(201, 203, 207, 0.2)', // 탁구 - 파스텔 회색
	                'rgba(255, 159, 64, 0.2)', // 배구 - 파스텔 주황
	                'rgba(144, 238, 144, 0.2)'  // 요가 - 파스텔 연두
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)', // 에어로빅 - 진한 레드
	                'rgba(75, 192, 192, 1)', // 배드민턴 - 진한 청록색
	                'rgba(255, 206, 86, 1)', // 피트니스 - 진한 노랑
	                'rgba(54, 162, 235, 1)', // 필라테스 - 진한 파랑
	                'rgba(153, 102, 255, 1)', // 수영 - 진한 보라
	                'rgba(201, 203, 207, 1)', // 탁구 - 진한 회색
	                'rgba(255, 159, 64, 1)', // 배구 - 진한 주황
	                'rgba(144, 238, 144, 1)'  // 요가 - 진한 연두
	            ],
	            borderWidth: 1
	        }]
	    }, //data
	    
	    options: {
	        maintainAspectRatio: false,
	        responsive: true,
	        plugins: {
	            legend: {
	                display: true,
	                position: 'top'
	            }
	        },
	        onClick: function (e) {
	            // 클릭된 위치의 데이터 인덱스를 가져옵니다
	            var activePoints = ageChart.getElementsAtEventForMode(e, 'nearest', { intersect: true }, true);
	            
	            if (activePoints.length) {
	                var index = activePoints[0].index;
	                var label = ageChart.data.labels[index];
	                var value = ageChart.data.datasets[0].data[index];
	                var memNo = ${param.mem_no};
	                
	                // 클릭된 데이터 항목에 대한 상세 정보 출력
	                console.log('선택 항목:', label);
	                console.log('선택 항목 타입:', typeof label);
	                console.log('멤버번호:', memNo);
	                console.log('횟수:', value);
	                
	                const token = $("meta[name='_csrf']").attr("content");
	    			const header = $("meta[name='_csrf_header']").attr("content");

	                $.ajax({
	    				url : '/member/detailClass',
	    				method : 'GET',
	    				data : {
	    					fieldCode : label,
	    					mem_no : memNo,
	    					status : '종료'
	    				},
// 	    				dataType: "application/json",
	    				beforeSend : function(xhr) {
	    					xhr.setRequestHeader(header, token);
	    				},
	    				success : function(data) {
	    					let descriptionCodes = [];
	    					let fieldCodes = [];
	    					let level = [];
	    					let registrationDate = [];
	    					let className = [];
	    					let divisionCodes = [];
	    					let maxCapacity = [];
	    					let minCapacity = [];
	    					let instructor = [];
	    					let startDate = [];
	    					let endDate = [];
	    					let recurrenceDays = [];
	    					let startTimeCode = [];
	    					let EndTimeCode = [];
	                        
                       		// RegistrationVO에 접근
	                        data.forEach(registration => {
	                        	
                            	registrationDate.push(registration.registration_date);
                            	
                            	// RegistrationVO의 empList에 접근
                            	registration.empList.forEach(empList => {
	                            	
                            		instructor.push(empList.name);

	                            });
                            	
                        		
                            	// RegistrationVO의 classScheduleList에 접근
	                            registration.classScheduleList.forEach(classScheduleList => {
	                            	
	                            	startDate.push(classScheduleList.startDate);
	                            	endDate.push(classScheduleList.endDate);
	                            	recurrenceDays.push(classScheduleList.recurrenceDays);
	                            	startTimeCode.push(classScheduleList.startTimeCode);
	                            	EndTimeCode.push(classScheduleList.endTimeCode);	                            	
	                            	
	                            	// RegistrationVO의 classScheduleList의 classList에 접근
	                                classScheduleList.classList.forEach(classList => {
	                                	
	                                	descriptionCodes.push(classList.description);
	                                	fieldCodes.push(classList.fieldCode);
	                                	level.push(classList.levelCode);
	                                	className.push(classList.className);
	                                	divisionCodes.push(classList.divisionCode);
	                                	maxCapacity.push(classList.maxCapacity);
	                                	minCapacity.push(classList.minCapacity);
	                                	
	                                });
	                            });
	                        });
	                        
							var temp = "";
							
	                        for(var i=0;i<descriptionCodes.length;i++){
								temp += descriptionCodes[i]+" "+fieldCodes[i]+" "+
	                    		convertTimestampToDate(registrationDate[i])+" 레벨 : "+level[i]+" 강의명 : "+
	                    		className[i]+" 강의 수준 : "+divisionCodes[i]+" 최대 인원 : "+maxCapacity[i]+
	                    		 " 최소 인원: "+minCapacity[i]+" 강사이름 : "+instructor[i]+" 수강기간 : "+convertTimestampToDate(startDate[i])+
	                    		 " ~ "+convertTimestampToDate(endDate[i])+" 매주 "+recurrenceDays[i]+
	                    		 " 시간 : "+TimeCodeChange(startTimeCode[i])+" ~ "+TimeCodeChange(EndTimeCode[i])+"<br>";
	                        }
	                        
	                        $('.printDetails').html( '<div class="card col-md-12" style="margin-top: 10px;">'+
	                        '<div class="card-header border-0 ui-sortable-handle">'+
	                        '<h3 class="card-title"><i class="fas fa-th mr-1"></i> 수강 상세내용</h3></div>'+
	                    	'<div class="card-body"><div class="tab-content p-0">'+
	                        temp+'</div> </div></div>');
	                        	
	    				},
	    				error : function(error) {
	    					alert('오류 발생');
	    					console.log(error);
	    				}
	    			});
	                
	            }
	        }// onClick
	        
	    }// options
	    
	}); // new Chart
	
    
	$(document).ready(function() {
		
	    var url = '/member/detailsAjax';
	    var mem_no = '${param.mem_no}';
	    var status = '정상';
		let page = 0;
	
		  $(document).on('click', '.nextButt', function(event) {
		    event.preventDefault(); 
		    
		    page += 1;

		    $.ajax({
		      url: url,
		      type: 'GET',
		      data: {
		        mem_no: mem_no,
		        page: 1,
		        pageNormal: page,
		        status : status,
		        pageRecruit: 0
		      },
		      success: function(data) {
		    	  
		    	  console.log(data);
		    	  console.log(data.classScheduleList);
		    	  
                  $('.printClassNormal').html(
                		  '<img alt='+data.classScheduleList[0].classList[0].fieldCode+' width="70px;" src="${pageContext.request.contextPath }/resources/img/'+data.classScheduleList[0].classList[0].fieldCode+'.png">'+
                       	 '강의명: '+data.classScheduleList[0].classList[0].className+'<br>'+
                       		'상세내용: '+data.classScheduleList[0].classList[0].description+'<br>'+
                       		'강의코드: '+data.classScheduleList[0].classList[0].fieldCode+'<br>'+
                       		'강의수준: '+data.classScheduleList[0].classList[0].divisionCode+'<br>'+
                       		'강의레벨: '+data.classScheduleList[0].classList[0].levelCode+'<br>'+
                       		'최대인원: '+data.classScheduleList[0].classList[0].maxCapacity+'<br>'+
                       		'최소인원: '+data.classScheduleList[0].classList[0].minCapacity+'<br>'+
                       		'강사: '+data.empList[0].name+'<br>'+
                       		'기간 : '+convertTimestampToDate(data.classScheduleList[0].startDate)+' ~ '+
                       		convertTimestampToDate(data.classScheduleList[0].endDate)+'<br>'+
 	                        '매주 '+data.classScheduleList[0].recurrenceDays+'<br>'+
 	                        '시간 : '+TimeCodeChange(data.classScheduleList[0].startTimeCode)+' ~ '+
 	                        TimeCodeChange(data.classScheduleList[0].endTimeCode)+'<br>등록일 : '+
 	                        convertTimestampToDate(data.registration_date)+'<br>'   		
                  );
		    	  
		    	  $('.prevButt').html('<a href="#" class="page-link">«</a>');
		    	  
		    	  $.ajax({
				      url: '/member/countAjax',
				      type: 'GET',
				      data: {
				        mem_no: mem_no,
				        status: status
				      },
				      success: function(data) {
				    	  if((data-1)==page){
				    		  $('.nextButt').html('');
				    	  }
				    	  
				      },
				      error: function(error) {
					        alert('에에에에러.');
					        console.log(error);
				      }
		    	  });
		    	  
                 
		      },
		      error: function() {
		        alert('Error loading page.');
		      }
		    });
		    
		   
            
		  });
		  
		  $(document).on('click', '.prevButt', function(event) {
		    event.preventDefault();
			
		    page -= 1;

		    $.ajax({
		      url: url,
		      type: 'GET',
		      data: {
		        mem_no: mem_no,
		        page: 1,
		        pageNormal: page,
		        status : status,
		        pageRecruit: 0,
		      },
		      success: function(data) {
		    	  
		    	  $('.printClassNormal').html(
                		  '<img alt='+data.classScheduleList[0].classList[0].fieldCode+' width="70px;" src="${pageContext.request.contextPath }/resources/img/'+data.classScheduleList[0].classList[0].fieldCode+'.png">'+
                       	 '강의명: '+data.classScheduleList[0].classList[0].className+'<br>'+
                       		'상세내용: '+data.classScheduleList[0].classList[0].description+'<br>'+
                       		'강의코드: '+data.classScheduleList[0].classList[0].fieldCode+'<br>'+
                       		'강의수준: '+data.classScheduleList[0].classList[0].divisionCode+'<br>'+
                       		'강의레벨: '+data.classScheduleList[0].classList[0].levelCode+'<br>'+
                       		'최대인원: '+data.classScheduleList[0].classList[0].maxCapacity+'<br>'+
                       		'최소인원: '+data.classScheduleList[0].classList[0].minCapacity+'<br>'+
                       		'강사: '+data.empList[0].name+'<br>'+
                       		'기간 : '+convertTimestampToDate(data.classScheduleList[0].startDate)+' ~ '+
                       		convertTimestampToDate(data.classScheduleList[0].endDate)+'<br>'+
 	                        '매주 '+data.classScheduleList[0].recurrenceDays+'<br>'+
 	                        '시간 : '+TimeCodeChange(data.classScheduleList[0].startTimeCode)+' ~ '+
 	                        TimeCodeChange(data.classScheduleList[0].endTimeCode)+'<br>등록일 : '+
 	                        convertTimestampToDate(data.registration_date)+'<br>'   		
                  );
		    	  
		    	  $('.nextButt').html('<a href="#" class="page-link">»</a>');
		    	  
		    	  if((page)==0){
		    		  $('.prevButt').html('');
		    	  }

		      },
		      error: function() {
		        alert('Error loading page.');
		      }
		    });
		    
            
		});
	
	});
	
	$(document).ready(function() {
		
	    var url = '/member/detailsAjax';
	    var mem_no = '${param.mem_no}';
	    var status = '모집';
		let page = 0;
	
		  $(document).on('click', '.nextRecruitButt', function(event) {
		    event.preventDefault(); 
		    
		    page += 1;

		    $.ajax({
		      url: url,
		      type: 'GET',
		      data: {
		        mem_no: mem_no,
		        page: 1,
		        pageRecruit: page,
		        status : status,
		        pageNormal: 0
		      },
		      success: function(data) {
		    	  
		    	  console.log(data);
                  $('.printClassRecruit').html(
                		  '<img alt='+data.classScheduleList[0].classList[0].fieldCode+' width="70px;" src="${pageContext.request.contextPath }/resources/img/'+data.classScheduleList[0].classList[0].fieldCode+'.png">'+
                       	 '강의명: '+data.classScheduleList[0].classList[0].className+'<br>'+
                       		'상세내용: '+data.classScheduleList[0].classList[0].description+'<br>'+
                       		'강의코드: '+data.classScheduleList[0].classList[0].fieldCode+'<br>'+
                       		'강의수준: '+data.classScheduleList[0].classList[0].divisionCode+'<br>'+
                       		'강의레벨: '+data.classScheduleList[0].classList[0].levelCode+'<br>'+
                       		'최대인원: '+data.classScheduleList[0].classList[0].maxCapacity+'<br>'+
                       		'최소인원: '+data.classScheduleList[0].classList[0].minCapacity+'<br>'+
                       		'강사: '+data.empList[0].name+'<br>'+
                       		'기간 : '+convertTimestampToDate(data.classScheduleList[0].startDate)+' ~ '+
                       		convertTimestampToDate(data.classScheduleList[0].endDate)+'<br>'+
 	                        '매주 '+data.classScheduleList[0].recurrenceDays+'<br>'+
 	                        '시간 : '+TimeCodeChange(data.classScheduleList[0].startTimeCode)+' ~ '+
 	                        TimeCodeChange(data.classScheduleList[0].endTimeCode)+'<br>등록일 : '+
 	                        convertTimestampToDate(data.registration_date)+'<br>'   		
                  );
		    	  
		    	  $('.prevRecruitButt').html('<a href="#" class="page-link">«</a>');
		    	  
		    	  $.ajax({
				      url: '/member/countAjax',
				      type: 'GET',
				      data: {
				        mem_no: mem_no,
				        status: status
				      },
				      success: function(data) {
				    	  if((data-1)==page){
				    		  $('.nextRecruitButt').html('');
				    	  }
				    	  
				      },
				      error: function(error) {
					        alert('에에에에러.');
					        console.log(error);
				      }
		    	  });
		    	  
                 
		      },
		      error: function(error) {
		        alert('Error loading page.');
		        console.log(error);
		      }
		    });
		    
		   
            
		  });
		  
		  $(document).on('click', '.prevRecruitButt', function(event) {
		    event.preventDefault();
			
		    page -= 1;

		    $.ajax({
		      url: url,
		      type: 'GET',
		      data: {
		        mem_no: mem_no,
		        page: 1,
		        pageRecruit: page,
		        status : status,
		        pageNormal: 0
		      },
		      success: function(data) {
		    	  
		    	  $('.printClassRecruit').html(
                		  '<img alt='+data.classScheduleList[0].classList[0].fieldCode+' width="70px;" src="${pageContext.request.contextPath }/resources/img/'+data.classScheduleList[0].classList[0].fieldCode+'.png">'+
                       	 '강의명: '+data.classScheduleList[0].classList[0].className+'<br>'+
                       		'상세내용: '+data.classScheduleList[0].classList[0].description+'<br>'+
                       		'강의코드: '+data.classScheduleList[0].classList[0].fieldCode+'<br>'+
                       		'강의수준: '+data.classScheduleList[0].classList[0].divisionCode+'<br>'+
                       		'강의레벨: '+data.classScheduleList[0].classList[0].levelCode+'<br>'+
                       		'최대인원: '+data.classScheduleList[0].classList[0].maxCapacity+'<br>'+
                       		'최소인원: '+data.classScheduleList[0].classList[0].minCapacity+'<br>'+
                       		'강사: '+data.empList[0].name+'<br>'+
                       		'기간 : '+convertTimestampToDate(data.classScheduleList[0].startDate)+' ~ '+
                       		convertTimestampToDate(data.classScheduleList[0].endDate)+'<br>'+
 	                        '매주 '+data.classScheduleList[0].recurrenceDays+'<br>'+
 	                        '시간 : '+TimeCodeChange(data.classScheduleList[0].startTimeCode)+' ~ '+
 	                        TimeCodeChange(data.classScheduleList[0].endTimeCode)+'<br>등록일 : '+
 	                        convertTimestampToDate(data.registration_date)+'<br>'   		
                  );
		    	  
		    	  $('.nextRecruitButt').html('<a href="#" class="page-link">»</a>');
		    	  
		    	  if((page)==0){
		    		  $('.prevRecruitButt').html('');
		    	  }

		      },
		      error: function() {
		        alert('Error loading page.');
		      }
		    });
		    
            
		});
	
	});
	
	
	function convertTimestampToDate(timestamp) {
        // 밀리초 단위의 타임스탬프를 Date 객체로 변환
        var date = new Date(timestamp);
        
        // 날짜를 사람이 읽을 수 있는 형식으로 변환
        var formattedDate = date.toLocaleDateString();
        
        return formattedDate;
    }
    
    function TimeCodeChange(code) {
    	if(code=='T09') return '09:00';
    	if(code=='T10') return '10:00';
    	if(code=='T11') return '11:00';
    	if(code=='T12') return '12:00';
    	if(code=='T13') return '13:00';
    	if(code=='T14') return '14:00';
    	if(code=='T15') return '15:00';
    	if(code=='T16') return '16:00';
    	if(code=='T17') return '17:00';
    	if(code=='T18') return '18:00';
    	if(code=='T19') return '19:00';
    	if(code=='T20') return '20:00';
    	if(code=='T21') return '21:00';
    	if(code=='T22') return '22:00';
    }
	
</script>

<%@ include file="../include/footer.jsp"%>