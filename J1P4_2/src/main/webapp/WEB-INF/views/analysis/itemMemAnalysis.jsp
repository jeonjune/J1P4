<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/mainHeader.jsp" %>
<%@ include file="../include/sidemenu.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	<!--     Left navbar links -->
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link"
			href="/analysis/totalMemAnalysis"
			role="button"><i class="fas">전체 회원 분석</i></a></li>
		<li class="nav-item"><a class="nav-link"
			href="/analysis/writeReport"
			role="button"><i class="fas"> 보고서 작성</i></a></li>
	</ul>

</nav>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="min-height: 831px;">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">항목별 회원분석</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/main/home">Home</a></li>
              <li class="breadcrumb-item active"><a href="/analysis/totalMemAnalysis">전체 회원분석</a></li>
              <li class="breadcrumb-item active">항목별 회원분석</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
       
		<!-- 전월 대비 등록 회원 변화 -->       
		<section class="col-lg-12 connectedSortable ui-sortable">
			<div class="card">
				<div class="card-header ui-sortable-handle" style="cursor: move;">
					<h2 class="card-title">
						<i class="fas fa-chart-pie mr-1"></i>
						전월 대비 등록 회원 변화
					</h2>
					<div class="card-tools">
						<button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
							<i class="fas fa-minus"></i>
						</button>
						<button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
							<i class="fas fa-times"></i>
						</button>
					</div>
				</div> <!-- .card-header  -->
				<div class="card-body">
					<div class="tab-content p-0">
						<div class="row">
							<div class="col-lg-3 col-6">
								<div class="small-box bg-success">
									<div class="inner">
										<h3>80<sup style="font-size: 20px">%</sup></h3>
										<p>회원 재등록률</p>
									</div>
									<div class="icon">
										<i class="fa fa-users"></i>
									</div>
									<div class="small-box-footer"></div>
								</div>
							</div>	
							<div class="col-lg-3 col-6">
								<div class="small-box bg-danger">
									<div class="inner">
										<h3>10<sup style="font-size: 20px">%</sup></h3>
										<p>회원 미등록률</p>
									</div>
									<div class="icon">
										<i class="fa fa-user-times"></i>
									</div>
									<div class="small-box-footer"></div>
								</div>
							</div>	
							<div class="col-lg-3 col-6">
								<div class="small-box bg-info">
									<div class="inner">
										<h3>10<sup style="font-size: 20px">%</sup></h3>
										<p>신규 등록 회원비율</p>
									</div>
									<div class="icon">
										<i class="fa fa-user-plus"></i>
									</div>
									<div class="small-box-footer"></div>
								</div>
							</div>	
							<div class="col-lg-3 col-6">
								<div class="small-box bg-warning">
									<div class="inner">
										<h3>102<sup style="font-size: 20px">%</sup></h3>
										<p>전월 대비 등록 회원</p>
									</div>
									<div class="icon">
										<i class="fa fa-address-card"></i>
									</div>
									<div class="small-box-footer"></div>
								</div>
							</div>	
						</div>					
					</div>
				</div>
			</div>
			    
       </section>
       
        
        <!-- Main row -->
        <div class="row">
          <!-- Left col -->
          <section class="col-lg-7 connectedSortable ui-sortable">
          
           <!-- solid sales graph -->
            <div class="card">
              <div class="card-header border-0 ui-sortable-handle" style="cursor: move;">
                <h3 class="card-title">
                  <i class="fas fa-th mr-1"></i>
                 	프로그램별 출석률
                </h3>
	                <div class="card-tools">
					  <input type="date" id="date-picker" class="btn bg-info btn-sm" style="border: none;">
	                  <button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
	                    <i class="fas fa-minus"></i>
	                  </button>
	                  <button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
	                    <i class="fas fa-times"></i>
	                  </button>
	                </div>
              </div>
              <div class="card-body">
              <div class="tab-content p-0">
              	<div class="chart"  style="position: relative; height: 500px;">
              		<div class="chartjs-size-monitor">
              			<div class="chartjs-size-monitor-expand">
              				<div class=""></div>
              			</div>
              			<div class="chartjs-size-monitor-shrink">
              				<div class=""></div>
              			</div>
              		</div>
                <canvas id="item-second-chart" height="500" style="height: 500px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
              </div>
            </div>
         </div>              
       <!-- /.card-body -->
       <div class="card-footer" style="text-align: center;">
       	(최저 출석률) 에어로빅F 에어로빅D 피트니스F
       </div>
     </div>
     <!-- /.card -->               
          
          
            <!-- Custom tabs (Charts with tabs)-->
            <div class="card">
              <div class="card-header ui-sortable-handle" style="cursor: move;">
                <h3 class="card-title">
                  <i class="fas fa-chart-pie mr-1"></i>
                  월 별 회원수 변화-2
                </h3>
                
                <div class="card-tools">
                  <button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content p-0">
                  <!-- Morris chart - Sales -->
                  <div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 300px;">
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
                      <canvas id="revenue2-chart-canvas" height="300" style="height: 300px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
                   </div>
                </div>
              </div><!-- /.card-body -->
            </div>
            <!-- /.card -->
            
            <!-- Custom tabs (Charts with tabs)-->
            <div class="card">
              <div class="card-header ui-sortable-handle" style="cursor: move;">
                <h3 class="card-title">
                  <i class="fas fa-chart-pie mr-1"></i>
                  성별 종목 비율
                </h3>
                
                <div class="card-tools">
                  <button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content p-0">
                  <!-- Morris chart - Sales -->
                  <div class="chart" id="revenue-chart" style="position: relative; height: 400px;">
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
                      <canvas id="male-chart" height="400" style="height: 300px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
                   </div>
                </div>
              </div><!-- /.card-body -->
            </div>
            <!-- /.card -->
          </section>
          <!-- /.Left col -->
 <!-- ---------------------------------------------------------------------------------------------------------- -->         
          <!-- right col (We are only adding the ID to make the widgets sortable)-->
          <section class="col-lg-5 connectedSortable ui-sortable">
          
           <!-- solid sales graph -->
            <div class="card">
              <div class="card-header border-0 ui-sortable-handle" style="cursor: move;">
                <h3 class="card-title">
                  <i class="fas fa-th mr-1"></i>
                 	전월 대비 종목별 회원 재등록률 
                </h3>
	                <div class="card-tools">
	                  <button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
	                    <i class="fas fa-minus"></i>
	                  </button>
	                  <button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
	                    <i class="fas fa-times"></i>
	                  </button>
	                </div>
              </div>
              <div class="card-body">
              <div class="tab-content p-0">
              	<div class="chart"  style="position: relative; height: 400px;">
              		<div class="chartjs-size-monitor">
              			<div class="chartjs-size-monitor-expand">
              				<div class=""></div>
              			</div>
              			<div class="chartjs-size-monitor-shrink">
              				<div class=""></div>
              			</div>
              		</div>
                <canvas id="item-first-chart" height="400" style="height: 400px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
              </div>
            </div>
         </div>              
       <!-- /.card-body -->
     </div>
     <!-- /.card --> 

           <!-- solid sales graph -->
            <div class="card">
              <div class="card-header border-0 ui-sortable-handle" style="cursor: move;">
                <h3 class="card-title">
                  <i class="fas fa-th mr-1"></i>
                  시간대별 회원 비율
                </h3>
	                <div class="card-tools">
	                  <button type="button" class="btn bg-info btn-sm" data-card-widget="collapse">
	                    <i class="fas fa-minus"></i>
	                  </button>
	                  <button type="button" class="btn bg-info btn-sm" data-card-widget="remove">
	                    <i class="fas fa-times"></i>
	                  </button>
	                </div>
              </div>
              <div class="card-body">
              <div class="tab-content p-0">
              	<div class="chart"  style="position: relative; height: 400px;">
              		<div class="chartjs-size-monitor">
              			<div class="chartjs-size-monitor-expand">
              				<div class=""></div>
              			</div>
              			<div class="chartjs-size-monitor-shrink">
              				<div class=""></div>
              			</div>
              		</div>
                <canvas id="tp-chart" height="400" style="height: 400px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
              </div>
            </div>
         </div>              
       <!-- /.card-body -->
     </div>
     <!-- /.card -->     
          
           <!-- solid sales graph -->
            <div class="card">
              <div class="card-header border-0 ui-sortable-handle" style="cursor: move;">
                <h3 class="card-title">
                  <i class="fas fa-th mr-1"></i>
                  종목별 회원수 
                </h3>
                <div class="card-tools">
                  <ul class="nav nav-pills ml-auto">
                    <li class="nav-item">
                      <a class="nav-link active" href="#b-chart" data-toggle="tab">Bar</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="#d-chart" data-toggle="tab">Donut</a>
                    </li>
                  </ul>
                </div>

              </div>
              <div class="card-body">
              <div class="tab-content p-0">
              	<div class="chart tab-pane active" id="b-chart" style="position: relative; height: 400px;">
              		<div class="chartjs-size-monitor">
              			<div class="chartjs-size-monitor-expand">
              				<div class=""></div>
              			</div>
              			<div class="chartjs-size-monitor-shrink">
              				<div class=""></div>
              			</div>
              		</div>
                <canvas id="num-mem-sport-bar-chart" height="400" style="height: 400px; display: block; width: 900px;" width="900" class="chartjs-render-monitor"></canvas>
              </div>
              <div class="chart tab-pane" id="d-chart" style="position: relative; height: 400px;">
                <canvas id="num-mem-sport-doughnut-chart" height="0" style="height: 0px; display: block; width: 0px;" class="chartjs-render-monitor" width="0"></canvas>
              </div>
            </div>
         </div>              
       <!-- /.card-body -->
     </div>
     <!-- /.card -->
     

     
    
<!-- ----------------------------------------------------------------------------------------------------------------------------------------- -->
            
          </section>
          <!-- right col -->
        </div>
        <!-- /.row (main row) -->
      </div><!-- /.container-fluid -->
      ${new6MemCount}
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

      <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
    
    // 현재 날짜를 기준으로 달 레이블 생성
    function getMonthLabels() {
//         var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        var months2 = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
        var currentMonth = new Date().getMonth();
        var labels = [];

        for (var i = 5; i >= 0; i--) {
            labels.push(months2[(currentMonth - i + 12) % 12]);
        }
        return labels;
    }    	
    
 	// 서버에서 전달된 JSON 문자열을 `new6MemCountJson` 변수에 저장
    var new6MemCountJson = '<c:out value="${new6MemCount}" escapeXml="false"/>';
    console.log("(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)(❁´◡`❁)Raw JSON: ", new6MemCountJson);

 	// JSON 문자열을 JavaScript 객체로 변환하고`new6MemCount` 변수에 파싱된 데이터를 저장
    var new6MemCount = JSON.parse(new6MemCountJson);
 	
	 // `new6MemCount` 배열의 각 요소에서 속성 값을 추출하여 새로운 배열을 만들고 변수에 추출된 월 데이터를 저장
    var yearMonth = new6MemCount.map(function(item) { return item.month; });
    var new_members = new6MemCount.map(function(item) { return item.new_members; });
        
        var ctx = document.getElementById('revenue2-chart-canvas').getContext('2d');
        var revenueChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: yearMonth,
                datasets: [{
                    label: '이번달 신규 회원',
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    pointRadius: false,
                    pointColor: 'rgba(54, 162, 235, 1)',
                    pointStrokeColor: 'rgba(60,141,188,1)',
                    pointHighlightFill: '#fff',
                    pointHighlightStroke: 'rgba(60,141,188,1)',
                    data: new_members,
                    fill: true
                },
                {
                  label: '이번달 등록 회원',
                  backgroundColor: 'rgba(255, 99, 132, 0.2)',
                  borderColor: 'rgba(255, 99, 132, 1)',
                  pointRadius: false,
                  pointColor: 'rgba(255, 99, 132, 1)',
                  pointStrokeColor: '#c1c7d1',
                  pointHighlightFill: '#fff',
                  pointHighlightStroke: 'rgba(220,220,220,1)',
                  data: [65, 70, 80, 75, 80, 90],
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
                },
                scales: {
                    xAxes: [{
                        gridLines: {
                            display: false
                        }
                    }],
                    yAxes: [{
                        gridLines: {
                            display: false
                        }
                    }]
                }
            }
        });

        var malectx = document.getElementById('male-chart').getContext('2d');
        var maleChart = new Chart(malectx, { 
            type: 'doughnut',
            data: {
                labels: ['에어로빅', '배드민턴', '피트니스', '필라테스', '수영', '탁구', '배구', '요가'],
                datasets: [{
                    data: [30, 20, 50, 40, 25, 35, 45, 28],  
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',  // 에어로빅 - 파스텔 레드
                        'rgba(75, 192, 192, 0.2)',  // 배드민턴 - 파스텔 청록색
                        'rgba(255, 206, 86, 0.2)',  // 피트니스 - 파스텔 노랑
                        'rgba(54, 162, 235, 0.2)',  // 필라테스 - 파스텔 파랑
                        'rgba(153, 102, 255, 0.2)', // 수영 - 파스텔 보라
                        'rgba(201, 203, 207, 0.2)', // 탁구 - 파스텔 회색
                        'rgba(255, 159, 64, 0.2)',  // 배구 - 파스텔 주황
                        'rgba(144, 238, 144, 0.2)'  // 요가 - 파스텔 연두
                    ]
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
        

        var nmsbCtx = document.getElementById('num-mem-sport-bar-chart').getContext('2d');
        var nmsbChart = new Chart(nmsbCtx, {
            type: 'bar',
            data: {
                labels: ['에어로빅', '배드민턴', '피트니스', '필라테스', '수영', '탁구', '배구', '요가'],
                datasets: [{
                	label: "종목별 등록 회원 수",
                    data: [30, 20, 50, 40, 25, 35, 45, 28],  // labels에 맞게 data 값을 추가
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',  // 에어로빅 - 파스텔 레드
                        'rgba(75, 192, 192, 0.2)',  // 배드민턴 - 파스텔 청록색
                        'rgba(255, 206, 86, 0.2)',  // 피트니스 - 파스텔 노랑
                        'rgba(54, 162, 235, 0.2)',  // 필라테스 - 파스텔 파랑
                        'rgba(153, 102, 255, 0.2)', // 수영 - 파스텔 보라
                        'rgba(201, 203, 207, 0.2)', // 탁구 - 파스텔 회색
                        'rgba(255, 159, 64, 0.2)',  // 배구 - 파스텔 주황
                        'rgba(144, 238, 144, 0.2)'  // 요가 - 파스텔 연두
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',    // 에어로빅 - 진한 레드
                        'rgba(75, 192, 192, 1)',    // 배드민턴 - 진한 청록색
                        'rgba(255, 206, 86, 1)',    // 피트니스 - 진한 노랑
                        'rgba(54, 162, 235, 1)',    // 필라테스 - 진한 파랑
                        'rgba(153, 102, 255, 1)',   // 수영 - 진한 보라
                        'rgba(201, 203, 207, 1)',   // 탁구 - 진한 회색
                        'rgba(255, 159, 64, 1)',    // 배구 - 진한 주황
                        'rgba(144, 238, 144, 1)'    // 요가 - 진한 연두
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
        
        var nmsdCtx = document.getElementById('num-mem-sport-doughnut-chart').getContext('2d');
        var nmsdChart = new Chart(nmsdCtx, {
            type: 'doughnut',
            data: {
                labels: ['에어로빅', '배드민턴', '피트니스', '필라테스', '수영', '탁구', '배구', '요가'],
                datasets: [{
                    data: [30, 20, 50, 40, 25, 35, 45, 28],  
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',  // 에어로빅 - 파스텔 레드
                        'rgba(75, 192, 192, 0.2)',  // 배드민턴 - 파스텔 청록색
                        'rgba(255, 206, 86, 0.2)',  // 피트니스 - 파스텔 노랑
                        'rgba(54, 162, 235, 0.2)',  // 필라테스 - 파스텔 파랑
                        'rgba(153, 102, 255, 0.2)', // 수영 - 파스텔 보라
                        'rgba(201, 203, 207, 0.2)', // 탁구 - 파스텔 회색
                        'rgba(255, 159, 64, 0.2)',  // 배구 - 파스텔 주황
                        'rgba(144, 238, 144, 0.2)'  // 요가 - 파스텔 연두
                    ]
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

        var tpCtx = document.getElementById('tp-chart').getContext('2d');
        var tpChart = new Chart(tpCtx, {
            type: 'doughnut',
            data: {
                labels: ['오전', '오후', '저녁'],
                datasets: [{
                    data: [168, 187 , 246],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.6)',
                        'rgba(54, 162, 235, 0.6)',
                        'rgba(255, 206, 86, 0.6)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                maintainAspectRatio: false,
                responsive: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        });
        
		// 전월 대비 종목별 재등록 회원 비율
        var ifCtx = document.getElementById('item-first-chart').getContext('2d');
        var ifChart = new Chart(ifCtx, {
            type: 'bar',
            data: {
                labels: ['에어로빅', '배드민턴', '피트니스', '필라테스', '수영', '탁구', '배구', '요가'],
                datasets: [{
                	label: "종목별 재등록 회원 비율",
                    data: [80, 70, 90, 50, 85, 45, 25, 60],  // labels에 맞게 data 값을 추가
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',  // 에어로빅 - 파스텔 레드
                        'rgba(75, 192, 192, 0.2)',  // 배드민턴 - 파스텔 청록색
                        'rgba(255, 206, 86, 0.2)',  // 피트니스 - 파스텔 노랑
                        'rgba(54, 162, 235, 0.2)',  // 필라테스 - 파스텔 파랑
                        'rgba(153, 102, 255, 0.2)', // 수영 - 파스텔 보라
                        'rgba(201, 203, 207, 0.2)', // 탁구 - 파스텔 회색
                        'rgba(255, 159, 64, 0.2)',  // 배구 - 파스텔 주황
                        'rgba(144, 238, 144, 0.2)'  // 요가 - 파스텔 연두
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',    // 에어로빅 - 진한 레드
                        'rgba(75, 192, 192, 1)',    // 배드민턴 - 진한 청록색
                        'rgba(255, 206, 86, 1)',    // 피트니스 - 진한 노랑
                        'rgba(54, 162, 235, 1)',    // 필라테스 - 진한 파랑
                        'rgba(153, 102, 255, 1)',   // 수영 - 진한 보라
                        'rgba(201, 203, 207, 1)',   // 탁구 - 진한 회색
                        'rgba(255, 159, 64, 1)',    // 배구 - 진한 주황
                        'rgba(144, 238, 144, 1)'    // 요가 - 진한 연두
                    ],
                    borderWidth: 2
                },
                {
                    data: [20, 30, 10, 50, 15, 55, 75, 40],  
                    backgroundColor: 'rgba(201, 203, 207, 0.8)',
                    borderColor: 'rgba(201, 203, 207, 1)',
                    borderWidth: 2
                }]
            },
            options: {
                maintainAspectRatio: false,
                responsive: true,
                legend: {
                    display: false
                },
                scales: {
                	x: {
                		stacked: true,
                	},
                    y: {
                    	stacked: true,
                        beginAtZero: true,
                        max: 100 // Y축 최대값을 100으로 설정
                    }
                }                
            }
        });         
     
        // 날짜 선택기의 초기 값을 현재 날짜로 설정합니다.
        var datePicker = document.getElementById('date-picker');
        var currentDate = new Date();
        datePicker.valueAsDate = currentDate;       
        
        // 날짜 선택기 클릭 시 버튼 전체가 반응하도록 합니다.
        document.getElementById('date-picker').addEventListener('click', function() {
            this.showPicker();
        });        
        
		// 프로그램별 출석률
        var isCtx = document.getElementById('item-second-chart').getContext('2d');
        var isChart = new Chart(isCtx, {
            type: 'bar',
            data: {
                labels: [
                    '에어로빅A', '에어로빅B', '에어로빅C', '에어로빅D', '에어로빅E', '에어로빅F', 
                    '배드민턴A', '배드민턴B', '배드민턴C', '배드민턴D', '배드민턴E', '배드민턴F',
                    '피트니스A', '피트니스B', '피트니스C', '피트니스D', '피트니스E', '피트니스F',
                    '필라테스A', '필라테스B', '필라테스C', '필라테스D', '필라테스E', '필라테스F',
                    '수영A', '수영B', '수영C', '수영D', '수영E', '수영F',
                    '탁구A', '탁구B', '탁구C', '탁구D', '탁구E', '탁구F',
                    '배구A', '배구B', '배구C', '배구D', '배구E', '배구F',
                    '요가A', '요가B', '요가C', '요가D', '요가E', '요가F'
                ],
                datasets: [{
                    label: '프로그램별 출석률',
                    data: [
                        80, 75, 90, 50, 85, 45, 
                        85, 70, 75, 95, 80, 90, 
                        90, 75, 85, 90, 70, 80,
                        75, 85, 90, 80, 70, 90,
                        70, 85, 95, 75, 80, 70,
                        80, 90, 75, 85, 90, 95,
                        80, 85, 90, 75, 70, 85, 
                        90, 95, 80, 75, 85, 90                        
                    ],  
                    backgroundColor: 'rgba(255, 99, 132, 0.4)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 2
                }]
            },
            options: {
                maintainAspectRatio: false,
                indexAxis: 'y',
                responsive: true,
                legend: {
                    display: true
                },
                scales: {
                	x: {
                        beginAtZero: true,
                        max: 100
                        
                	}
                }                
            }
        });         

     
    </script>

<%@ include file="../include/mainFooter.jsp" %>