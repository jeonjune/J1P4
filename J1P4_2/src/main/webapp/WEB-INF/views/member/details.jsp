<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/memMenu.jsp"%>


<div class="content-wrapper" style="min-height: 831px;">

<%-- 	<c:forEach items="${vo }" var="vo"> --%>
<%-- 		<c:set var="count" value="${vo.class_count }" /> --%>

<%-- 횟수 : ${vo.class_count }번 --%>
<%-- ${vo.classScheduleList[0].classList[0].fieldCode} --%>
<%-- 	${vo } --%>
<%-- </c:forEach> --%>

	<div class="card cardCustom">
    <div class="col-md-10"
         style="margin-left: 150px; margin-top: 30px; margin-bottom: 10px;">
        <div class="row">
            <!-- 수강 분포 카드 -->
            <div class="card col-md-6">
                <div class="card-header border-0 ui-sortable-handle">
                    <h3 class="card-title">
                        <i class="fas fa-chart-pie mr-1"></i> 수강 분포
                    </h3>
                </div>
                <div class="card-body">
                    <div class="tab-content p-4" >
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
                            <canvas id="age-chart" height="400"
                                    style="height: 400px; display: block; width: 100%;" width="900"
                                    class="chartjs-render-monitor"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 현재 수강중인 강의 카드 -->
            <div class="card col-md-6">
                <div class="card-header border-0 ui-sortable-handle">
                    <h3 class="card-title">
                        <i class="fas fa-th mr-1"></i> 현재 수강중인 강의
                    </h3>
                </div>
                <div class="card-body">
                    <div class="tab-content p-0">
                    </div>
                </div>
            </div>
        </div>

        <!-- 수강 상세내용 카드 -->
                    <div class="printDetails">
                    </div>
       
    </div>
</div>


</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

//서버에서 전달된 JSON 문자열을 `new6MemCountJson` 변수에 저장
var classCountJson = '<c:out value="${vo}" escapeXml="false"/>';
console.log("(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)Raw JSON: ", classCountJson);
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
	    					mem_no : memNo
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
	                        
                       		// RegistrationVO에 접근
	                        data.forEach(registration => {
	                        	
                            	registrationDate.push(registration.registration_date);
                        		
                            	// RegistrationVO의 classScheduleList에 접근
	                            registration.classScheduleList.forEach(classScheduleList => {
	                            	
	                            	// RegistrationVO의 classScheduleList의 classList에 접근
	                                classScheduleList.classList.forEach(classList => {
	                                	
	                                	descriptionCodes.push(classList.description);
	                                	fieldCodes.push(classList.fieldCode);
	                                	level.push(classList.levelCode);
	                                	
	                                });
	                            });
	                        });
	                        
							var temp = "";
							
	                        for(var i=0;i<descriptionCodes.length;i++){
								temp += descriptionCodes[i]+" "+fieldCodes[i]+" "+
	                    		convertTimestampToDate(registrationDate[i])+" "+level[i]+"<br>";
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
	                
	                function convertTimestampToDate(timestamp) {
	                    // 밀리초 단위의 타임스탬프를 Date 객체로 변환
	                    var date = new Date(timestamp);
	                    
	                    // 날짜를 사람이 읽을 수 있는 형식으로 변환
	                    var formattedDate = date.toLocaleDateString();
	                    
	                    return formattedDate;
	                }
	                
	            }
	        }// onClick
	        
	    }// options
	    
	}); // new Chart
	
	
</script>

<%@ include file="../include/footer.jsp"%>