<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/memMenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">

	<div class="card cardCustom">

		<div class="cardMargin col-md-10">
		<div class="row d-flex">
						
			<!-- 회원 이름 & 운동 목표 카드-->
			<div class="card">
				<!-- 페이징 처리 -->
	                    <div class="card-tools d-flex justify-content-between align-items-center m-3">
	                    <form action="" method="get" class="inbodyForm">
	                    <div class="form-inline">
	                    <input type="hidden" value="${param.mem_no }" name="mem_no">
	                    <c:if test="${not empty healthInfo.inbody_no }">
	                    <select class="form-control" id="selectInbody" name="pageStart">
	                    	<c:forEach items="${inbodyDate }" var="test" varStatus="i">
							<option value="${i.index }">${test.inbody_date }</option>
						</c:forEach>
	                    </select>
	                    </c:if>
	                    </div>
	                    </form>
							  <div>
							  <c:if test="${not empty healthInfo.inbody_no }">
							  <button class="btn btn-primary" type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
							aria-controls="offcanvasRight">수정하기</button>
							  </c:if>
							  <button class="btn btn-outline-primary" type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight2"
							aria-controls="offcanvasRight">추가하기</button>
							  </div>
	            	    </div>
			
				<div class="card-body">
					
					<h2 style="margin-top: 10px;">${healthInfo.inbody_date}</h2>
					<div class="card" style="margin-top: 20px;">
						<div class="card-body">
							<strong><i class="far fa-file-alt mr-1 cardMy"></i> 운동 목표 </strong>
							<br> <br><div style="white-space:pre;"><c:out value="${healthInfo.exercise_goal}"/></div>
						</div>
					</div>
				</div>
			</div>
			
		 <!-- 좌측 카드 묶음 -->
    <div class="col-md-6 d-flex flex-column">
        <!-- 기본 정보 카드 시작 -->
        <div class="card flex-fill">
            <!-- 기본 정보 카드 헤더 -->
            <div class="card-header border-0 ui-sortable-handle">
                <h3 class="card-title">
                    <i class="fas fa-th mr-1"></i> 기본 정보
                </h3>
            </div>
            <!-- 기본 정보 카드 바디 -->
            <div class="card-body">
                <!-- 기본 정보 출력 -->
                <div class="tab-content p-0 printClassNormal">
                <c:if test="${not empty healthInfo }">
                    키 : ${healthInfo.height}cm<br>
                    체중 : ${healthInfo.weight}kg<br>
                    체지방량 : ${healthInfo.fat}kg<br>
                    골격근량 : ${healthInfo.muscle}kg<br>
                    기초대사량 : ${healthInfo.bmr}kcal<br>
                    복부지방률 : ${healthInfo.belly_fat}
                   </c:if> 
                    <!-- 기본 정보가 없을 경우 출력 -->
                    <c:if test="${empty healthInfo }">
                        <div style="padding: 75px;">
                            값이 없습니데이
                        </div>
                    </c:if>
                </div>
                <!-- 기본 정보 출력 -->
            </div>
        </div>
        <!-- 기본 정보 카드 끝 -->

        <!-- 상담 내용 카드 시작 -->
        <div class="card mt-3 flex-fill">
            <!-- 상담 내용 카드 헤더 -->
            <div class="card-header border-0 ui-sortable-handle">
                <h3 class="card-title">
                    <i class="fas fa-th mr-1"></i> 상담 내용
                </h3>
            </div>
            <!-- 상담 내용 카드 바디 -->
            <div class="card-body">
                <!-- 상담 내용 출력 -->
                <div class="tab-content p-0 printClassRecruit">
                    <c:if test="${not empty healthInfo.consult_content or not empty healthInfo.manager_no}">
                    담당강사 : ${healthInfo.manager_name } <br>
                    ${healthInfo.consult_content }
                    </c:if>
                    <!-- 상담 내용이 없을 경우 출력 -->
                    <c:if test="${empty healthInfo.consult_content }">
                        <div style="padding: 75px;">
                            값이 없습니데이
                        </div>
                    </c:if>
                </div>
                <!-- 상담 내용 출력 -->
            </div>
        </div>
        <!-- 상담 내용 카드 끝 -->
    </div>

    <!-- 골격근 어쩌고 카드 시작 -->
    <div class="card col-md-6 d-flex flex-column">
        <!-- 골격근 어쩌고 카드 헤더 -->
        <div class="card-header border-0 ui-sortable-handle">
            <h3 class="card-title">
                <i class="fas fa-th mr-1"></i>
                골격근.지방분석
            </h3>
        </div>
        <!-- 골격근 어쩌고 카드 바디 -->
        <div class="card-body p-5 flex-fill">
            <!-- 그래프 표 수평정렬 -->
            <div class="charts-container">
                <!-- 체중 그래프 -->
                <div class="tab-content p-0 col-md-3">
                    <div class="chart tab-pane active" id="b-chart" style="position: relative; height: 400px;">
                        <div class="chartjs-size-monitor">
                            <div class="chartjs-size-monitor-expand">
                                <div class=""></div>
                            </div>
                            <div class="chartjs-size-monitor-shrink">
                                <div class=""></div>
                            </div>
                        </div>
                        <canvas id="num-mem-sport-bar-chart" height="400" width="900" class="chartjs-render-monitor canvasChart"></canvas>
                    </div>
                </div>
                <!-- 체중 그래프 -->

                <!-- 골격근률,체지방율,BMI 그래프 -->
                <div class="tab-content col-md-8">
                    <div class="chart tab-pane active" id="b-chart2" style="position: relative; height: 400px;">
                        <div class="chartjs-size-monitor">
                            <div class="chartjs-size-monitor-expand">
                                <div class=""></div>
                            </div>
                            <div class="chartjs-size-monitor-shrink">
                                <div class=""></div>
                            </div>
                        </div>
                        <canvas id="num2-mem-sport-bar-chart" height="400" width="900" class="chartjs-render-monitor canvasChart"></canvas>
                    </div>
                </div>
                <!-- 골격근률,체지방율,BMI 그래프 -->
            </div>
        </div>
    </div>
    <!-- 골격근 어쩌고 카드 끝 -->
		
		</div>
		
			<!-- 신체변화 카드-->
			<div class="card">
			
              <div class="card-header ui-sortable-handle">
                <h3 class="card-title">
                  <i class="fas fa-chart-pie mr-1"></i>
                 	신체변화
                </h3>

              </div><!-- /.card-header -->
              
              <div class="card-body">
              
                <div class="tab-content p-0">
                  <div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 200px;">
                  	
                  	<div class="chartjs-size-monitor">
                  		<div class="chartjs-size-monitor-expand">
                  			<div class="">
                  			</div>
                  		</div>
                  		<div class="chartjs-size-monitor-shrink">
                  			<div class="">
                  			</div>
                  		</div>
                  	</div>
                  	
                      <canvas id="revenue2-chart-canvas" height="200" style="height: 200px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
                   </div>
                   
                  <div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 200px; margin-top: 30px;">
                  	
                  	<div class="chartjs-size-monitor">
                  		<div class="chartjs-size-monitor-expand">
                  			<div class="">
                  			</div>
                  		</div>
                  		<div class="chartjs-size-monitor-shrink">
                  			<div class="">
                  			</div>
                  		</div>
                  	</div>
                  	
                      <canvas id="revenue3-chart-canvas" height="200" style="height: 200px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
                   </div>
                   
                </div>
                
              </div>
              
            </div>      
            
		</div>

	</div>
	
	
	<form id="fm1" name="fm1">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="hidden" name="inbody_no"
			value="${healthInfo.inbody_no}" />
			<input type="hidden" name="manager_no" value="${healthInfo.manager_no}" />
		<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
			aria-labelledby="offcanvasRightLabel">
			<div class="offcanvas-header">
				<h5 id="offcanvasRightLabel">인바디 수정</h5>
				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="offcanvas-body">

				<section class="content">
					<div class="container-fluid">
						<label>키</label> 
						<div class="form-group input-group">
							<input type="number" name="height" id="height"
								value="${healthInfo.height}" class="form-control">
								<span class="input-group-text" id="basic-addon2">cm</span>
						</div>
						<label>체중</label> 
						<div class="form-group input-group">
							<input type="number" name="weight" id="weight"
								value="${healthInfo.weight}" class="form-control" />
								<span class="input-group-text" id="basic-addon2">kg</span>
						</div>
						<label>체지방량</label> 
						<div class="form-group input-group">
							<input type="number" name="fat" id="fat"
								value="${healthInfo.fat}" class="form-control" />
								<span class="input-group-text" id="basic-addon2">kg</span>
						</div>
						<label>체지방률</label> 
						<div class="form-group input-group">
							<input type="number" name="fat_mass" id="fat_mass"
								value="${healthInfo.fat_mass}" class="form-control" />
								<span class="input-group-text" id="basic-addon2">%</span>
						</div>
						<label>골격근량</label> 
						<div class="form-group input-group">
							<input type="number" name="muscle" id="muscle"
								value="${healthInfo.muscle}" class="form-control" />
								<span class="input-group-text" id="basic-addon2">kg</span>
						</div>
						<label>골격근율</label> 
						<div class="form-group input-group">
							<input type="number" name="muscle_mass" id="muscle_mass"
								value="${healthInfo.muscle_mass}" class="form-control" />
								<span class="input-group-text" id="basic-addon2">%</span>
						</div>
						<label>BMI</label> 
						<div class="form-group input-group">
							<input type="number" name="bmi" id="bmi"
								value="${healthInfo.bmi}" class="form-control" />
								<span class="input-group-text" id="basic-addon2"></span>
						</div>
						<label>기초대사량</label> 
						<div class="form-group input-group">
							<input type="number" name="bmr" id="bmr"
								value="${healthInfo.bmr}" class="form-control" />
								<span class="input-group-text" id="basic-addon2">kcal</span>
						</div>
						<label>복부비만율</label> 
						<div class="form-group input-group">
							<input type="number" name="belly_fat" id="belly_fat"
								value="${healthInfo.belly_fat}" class="form-control" />
								<span class="input-group-text" id="basic-addon2"></span>
						</div>
						<label>운동목표</label>
						<div class="form-group input-group">
							<textarea rows="5" cols="38" name="exercise_goal" id="exercise_goal">${healthInfo.exercise_goal}</textarea>
						</div>
						<label>상담내용</label>
						<div class="form-group input-group">
							<textarea rows="5" cols="38" name="consult_content" id="consult_content">${healthInfo.consult_content}</textarea>
						</div>

						<button type="button" class="btn btn-primary" id="updateButt">수정하기</button>

					</div>
				</section>
			</div>
		</div>

	</form>
	
	<form id="fm2" name="fm2">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="hidden" name="mem_no"
			value="${param.mem_no}" />
			<input type="hidden" name="manager_no" value="1" />
		<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight2"
			aria-labelledby="offcanvasRightLabel">
			<div class="offcanvas-header">
				<h5 id="offcanvasRightLabel">인바디 추가</h5>
				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="offcanvas-body">

				<section class="content">
					<div class="container-fluid">
						<label>등록일</label> 
						<div class="form-group input-group">
							<input type="date" name="inbody_date" class="form-control" id="inbody_date2">
						</div>
						<label>키</label> 
						<div class="form-group input-group">
							<input type="number" name="height" class="form-control" id="height2">
								<span class="input-group-text" id="basic-addon2">cm</span>
						</div>
						<label>체중</label> 
						<div class="form-group input-group">
							<input type="number" name="weight" class="form-control" id="weight2" />
								<span class="input-group-text" id="basic-addon2">kg</span>
						</div>
						<label>체지방량</label> 
						<div class="form-group input-group">
							<input type="number" name="fat" class="form-control" id="fat2" />
								<span class="input-group-text" id="basic-addon2">kg</span>
						</div>
						<label>체지방률</label> 
						<div class="form-group input-group">
							<input type="number" name="fat_mass" class="form-control" id="fat_mass2"/>
								<span class="input-group-text" id="basic-addon2">%</span>
						</div>
						<label>골격근량</label> 
						<div class="form-group input-group">
							<input type="number" name="muscle" class="form-control" id="muscle2"/>
								<span class="input-group-text" id="basic-addon2">kg</span>
						</div>
						<label>골격근율</label> 
						<div class="form-group input-group">
							<input type="number" name="muscle_mass" class="form-control" id="muscle_mass2" />
								<span class="input-group-text" id="basic-addon2">%</span>
						</div>
						<label>BMI</label> 
						<div class="form-group input-group">
							<input type="number" name="bmi" class="form-control" id="bmi2"/>
								<span class="input-group-text" id="basic-addon2"></span>
						</div>
						<label>기초대사량</label> 
						<div class="form-group input-group">
							<input type="number" name="bmr" class="form-control" id="bmr2"/>
								<span class="input-group-text" id="basic-addon2">kcal</span>
						</div>
						<label>복부비만율</label> 
						<div class="form-group input-group">
							<input type="number" name="belly_fat" class="form-control" id="belly_fat2" />
								<span class="input-group-text" id="basic-addon2"></span>
						</div>
						<label>운동목표</label>
						<div class="form-group input-group">
							<textarea rows="5" cols="38" name="exercise_goal"></textarea>
						</div>
						<label>상담내용</label>
						<div class="form-group input-group">
							<textarea rows="5" cols="38" name="consult_content"></textarea>
						</div>

						<button type="button" class="btn btn-primary" id="submitButt">추가하기</button>

					</div>
				</section>
			</div>
		</div>

	</form>

</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
	var weight = '${healthInfo.weight}'
	var fat_mass = '${healthInfo.fat_mass}'
	var muscle_mass = '${healthInfo.muscle_mass}'
	var bmi = '${healthInfo.bmi}'
	
	var nmsbCtx = document.getElementById('num-mem-sport-bar-chart').getContext('2d');
	var nmsbChart = new Chart(nmsbCtx, {
	    type: 'bar',
	    data: {
	        labels: ['체중'],
	        datasets: [{
	        	label: "KG",
	            data: [weight,120],
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)'
	            ],
	            borderWidth: 2
	        }]
	    },
	    options: {
	        maintainAspectRatio: false,
	        responsive: true,
	        legend: {
	            display: false
	        }
	    }
	});     
	var nmsbCtx2 = document.getElementById('num2-mem-sport-bar-chart').getContext('2d');
	var nmsbChart2 = new Chart(nmsbCtx2, {
	    type: 'bar',
	    data: {
	        labels: ['골격근률','체지방율','BMI'],
	        datasets: [{
	        	label: "%",
	            data: [muscle_mass,fat_mass,bmi,50],
	            backgroundColor: [
	            	'rgba(75, 192, 192, 0.2)',
	            	'rgba(255, 206, 86, 0.2)',
	            	'rgba(54, 162, 235, 0.2)'
	            ],
	            borderColor: [
	            	'rgba(75, 192, 192, 1)',
	            	'rgba(255, 206, 86, 1)',
	            	'rgba(54, 162, 235, 1)'
	            ],
	            borderWidth: 2
	        }]
	    },
	    options: {
	        maintainAspectRatio: false,
	        responsive: true,
	        legend: {
	            display: false
	        }
	    }
	});     
	
	//서버에서 전달된 JSON 문자열을 `classCountJson` 변수에 저장
	var bodyDataJson = '<c:out value="${bodyDataJSON}" escapeXml="false"/>';
	var data = JSON.parse(bodyDataJson);
		
	var inbody_date = data.map(function(item) { return item.inbody_date; });
	var weight = data.map(function(item) { return item.weight; });
	var muscle = data.map(function(item) { return item.muscle; });
	var fat = data.map(function(item) { return item.fat; });
	
	console.log("inbody_date: ", inbody_date);
	console.log("weight: ", weight);
	console.log("muscle: ", muscle);
	console.log("fat: ", fat);
	
	var ctx = document.getElementById('revenue2-chart-canvas').getContext('2d');
    var revenueChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: inbody_date,
            datasets: [
            {
              label: '골격근량',
              backgroundColor: 'rgba(255, 99, 132, 0)',
              borderColor: 'rgba(255, 99, 132, 1)',
              pointRadius: false,
              pointColor: 'rgba(255, 99, 132, 1)',
              pointStrokeColor: '#c1c7d1',
              pointHighlightFill: '#fff',
              pointHighlightStroke: 'rgba(220,220,220,1)',
              data: muscle,
              fill: true
            },
            {
                label: '체지방량',
                backgroundColor: 'rgba(255, 99, 132, 0)',
                borderColor: 'rgba(75, 192, 192, 1)',
                pointRadius: false,
                pointColor: 'rgba(75, 192, 192, 1)',
                pointStrokeColor: '#c1c7d1',
                pointHighlightFill: '#fff',
                pointHighlightStroke: 'rgba(220,220,220,1)',
                data: fat,
                fill: true
              }
            ]
        },
        options: {
            maintainAspectRatio: false,
            responsive: true,
            legend: {
                display: true
            },
            elements: {
                point: {
                    hitRadius: 40
                }
            }
        }
    });
	var ctx = document.getElementById('revenue3-chart-canvas').getContext('2d');
    var revenueChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: inbody_date,
            datasets: [
            {
              label: '체중',
              backgroundColor: 'rgba(75, 192, 192, 0)',
              borderColor: 'rgba(54, 162, 235, 1)',
              pointRadius: false,
              pointColor: 'rgba(54, 162, 235, 1)',
              pointStrokeColor: '#c1c7d1',
              pointHighlightFill: '#fff',
              pointHighlightStroke: 'rgba(220,220,220,1)',
              data: weight,
              fill: true
            }
            ]
        },
        options: {
            maintainAspectRatio: false,
            responsive: true,
            legend: {
                display: true
            },
            elements: {
                point: {
                    hitRadius: 40
                }
            }
        }
    });
    
    $("#selectInbody").change(function() {

		$(".inbodyForm").submit();
	});
    $("#selectInbody").val("${param.pageStart }");
    
    $(function() {
		$("#updateButt").click(function() {
			
			//빈칸검사
			var inbody_date = $('#inbody_date').val();
			var height = $('#height').val();
			var weight = $('#weight').val();
			var fat = $('#fat').val();
			var fat_mass = $('#fat_mass').val();
			var muscle = $('#muscle').val();
			var muscle_mass = $('#muscle_mass').val();
			var bmi = $('#bmi').val();
			var bmr = $('#bmr').val();
			var belly_fat = $('#belly_fat').val();
			
			if (inbody_date == "" || height == "" || weight == "" || fat == "" || fat_mass == "" ||
			    muscle == "" || muscle_mass == "" || bmi == "" || bmr == "" || belly_fat == "") {
			    alert("인바디 정보를 모두 입력해주세요.");
			    return;
			}
			
			$.ajax({
				url : "/member/updateInbody",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					alert("인바디 정보가 수정되었습니다.");

					history.go(0);
				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});
    
    $(function() {
		$("#submitButt").click(function() {
				
			//빈칸검사
			var inbody_date = $('#inbody_date2').val();
			var height = $('#height2').val();
			var weight = $('#weight2').val();
			var fat = $('#fat2').val();
			var fat_mass = $('#fat_mass2').val();
			var muscle = $('#muscle2').val();
			var muscle_mass = $('#muscle_mass2').val();
			var bmi = $('#bmi2').val();
			var bmr = $('#bmr2').val();
			var belly_fat = $('#belly_fat2').val();
			
			if (inbody_date == "" || height == "" || weight == "" || fat == "" || fat_mass == "" ||
			    muscle == "" || muscle_mass == "" || bmi == "" || bmr == "" || belly_fat == "") {
			    alert("인바디 정보를 모두 입력해주세요.");
			    return;
			}
			
			$.ajax({
				url : "/member/insertInbody",
				type : "POST",
				data : $("#fm2").serialize(),
				success : function(data) {
					alert("인바디 정보가 등록되었습니다.");

					window.location.href = '/member/monitoring?mem_no=${param.mem_no }&pageStart=0';
				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});
</script>


<%@ include file="../include/footer.jsp"%>