<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- 알림 배지 -->
<!-- <span class="badge badge-info right">2</span> -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

<script type="text/javascript">


	$(document).ready(function(){
		
		check_commute()
		
		// 출근하기 버튼 클릭이벤트 시작
		
		$(document).on("click","#start_work",function(){
			//alert('asd')
			Swal.fire({
				   title: '출근하시겠습니까?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
					   let html = "";
				   
					   $.ajax({
						   url:"/employee/workStart",
						   type:"POST",
						   data:{"user_id":"${principal.username}",
							   "${_csrf.parameterName}":"${_csrf.token}"},
						   success:function(data){
							   if(data == 1) {
								   Swal.fire('출근처리가 완료되었습니다.','출근완료','success');
								   
								   
								   html += "<button class='btn btn-success dropdown-toggle' type='button' id='dropdownMenuButton1' data-bs-toggle='dropdown' aria-expanded='false'>"+
								    		   "퇴근하기</button>"+
									  	   "<ul class='dropdown-menu' aria-labelledby='dropdownMenuButton1'>"+
									  	   "<li><a class='dropdown-item' id='endWork' value='퇴근'>퇴근하기</a></li>"+
									  	   "<li><a class='dropdown-item' id='outWork' value='외출'>외출하기</a></li>"+
									    	   "</ul>"+
									  	   "</div>"

									$("#commute-div").html(html);  	   
							   }
						   },
						   error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					       }
					   })
				   
				   }
				});
		})
		
		// 출근하기 버튼 클릭이벤트 끝 ------------------------------------------------------------------------------------------
		
		
		// 퇴근하기 버튼 클릭이벤트 
		$(document).on("click","#endWork", function(){
			
			Swal.fire({
				   title: '퇴근하시겠습니까?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
					   let html = "";
					   
				   
					  $.ajax({
						   url:"/employee/endWork",
						   type:"POST",
						   data:{"user_id":"${principal.username}",
							   "${_csrf.parameterName}":"${_csrf.token}"},
						   success:function(data){
							   console.log("퇴근완료");
							   if(data == 1) {
								   html += "<button class='btn btn-success' type='button' id='dropdownMenuButton1' aria-expanded='false'>"+
					    		   "퇴근했어요</button>"+
						  	   
						  	   "</div>"
					
								$("#commute-div").html(html);	   
							   }
						   },
						   error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					       }
					  }) 
					   
				      Swal.fire('다음에 또 만나요.',' 퇴근완료','success');
				   }
				});
			
		});
		
		// 외출하기 버튼 클릭이벤트 
		$(document).on("click","#outWork", function(){
			
			Swal.fire({
				   title: '외출하시겠습니까?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
					   let html = "";
					   
				   
					  $.ajax({
						   url:"/employee/outWork",
						   type:"POST",
						   data:{"user_id":"${principal.username}",
							   "${_csrf.parameterName}":"${_csrf.token}"},
						   success:function(data){
							   console.log("외출중");
							   if(data == 1) {
								html += "<button class='btn btn-success dropdown-toggle' type='button' id='dropdownMenuButton1' data-bs-toggle='dropdown' aria-expanded='false'>"+
					    		"복귀하기</button>"+
						  	   "<ul class='dropdown-menu' aria-labelledby='dropdownMenuButton1'>"+
						  	   "<li><a class='dropdown-item' id='inWork' value='복귀'>복귀하기</a></li>"+
						    	   "</ul>"+
						  	   "</div>"

						$("#commute-div").html(html);  	  
							   }
						   },
						   error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					       }
					  }) 
					   
				      Swal.fire('복귀시 복귀버튼 필수!',' 외출완료','success');
				   }
				});
			
		});// 외출끝----------------------------------------------------------
		
		// 복귀하기 버튼 클릭이벤트 
		$(document).on("click","#inWork", function(){
			
			Swal.fire({
				   title: '복귀하시겠습니까?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
					   let html = "";
					   
				   
					  $.ajax({
						   url:"/employee/inWork",
						   type:"POST",
						   data:{"user_id":"${principal.username}",
							   "${_csrf.parameterName}":"${_csrf.token}"},
						   success:function(data){
							   console.log("복귀");
							   if(data == 1) {
								   html += "<button class='btn btn-success dropdown-toggle' type='button' id='dropdownMenuButton1' data-bs-toggle='dropdown' aria-expanded='false'>"+
					    		   "퇴근하기</button>"+
						  	   "<ul class='dropdown-menu' aria-labelledby='dropdownMenuButton1'>"+
						  	   "<li><a class='dropdown-item' id='endWork' value='퇴근'>퇴근하기</a></li>"+
						  	   "<li><a class='dropdown-item' id='outWork' value='외출'>외출하기</a></li>"+
						    	   "</ul>"+
						  	   "</div>"

						$("#commute-div").html(html);  		  
							   }
						   },
						   error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					       }
					  }) 
					   
				      Swal.fire('다시 일합시다!',' 복귀완료','success');
				   }
				});
			
		});
		
	}); // end of ready
	

	
	
	
	function check_commute() { // 오늘 출근을 했는지 확인하는 메소드
		
		$.ajax({
			url:"/employee/checkWork",
			data:{"user_id":"${principal.username}",
				   "${_csrf.parameterName}":"${_csrf.token}"},
			success:function(data) {
				
				let html = "";
				console.log("data"+data);
				if(data == 1) {	// 오늘날짜로 출근한 데이터가 있다면
					
					
				html += "<button class='btn btn-success dropdown-toggle' type='button' id='dropdownMenuButton1' data-bs-toggle='dropdown' aria-expanded='false'>"+
			    		   " 퇴근하기 </button>"+
				  	   "<ul class='dropdown-menu' aria-labelledby='dropdownMenuButton1'>"+
				  	   "<li><a class='dropdown-item' id='endWork' value='퇴근'>퇴근하기</a></li>"+
				  	   "<li><a class='dropdown-item' id='outWork' value='외출'>외출하기</a></li>"+
				    	   "</ul>"+
				  	   "</div>"
			
				$("#commute-div").html(html);
					  	    
				   
				}else if(data==2){
					
					html += "<button class='btn btn-success' type='button' id='dropdownMenuButton1' aria-expanded='false'>"+
		    		   " 퇴근했어요 </button>"+
			  	   
			  	   "</div>"
		
					$("#commute-div").html(html);
				}else if(data==3){
					
					html += "<button class='btn btn-success dropdown-toggle' type='button' id='dropdownMenuButton1' data-bs-toggle='dropdown' aria-expanded='false'>"+
		    		" 복귀하기 </button>"+
			  	   "<ul class='dropdown-menu' aria-labelledby='dropdownMenuButton1'>"+
			  	   "<li><a class='dropdown-item' id='inWork' value='복귀'>복귀하기</a></li>"+
			    	   "</ul>"+
			  	   "</div>"

			$("#commute-div").html(html);  	  
				}
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});// end of $.ajax -----------------------------
		
	}// end of function check_commute() {} --------------------------------
	


</script>
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-light-primary elevation-4 sidebar-no-expand">
    <!-- Brand Logo -->
    <a href="/main/home" class="brand-link">
      <img src="${pageContext.request.contextPath }/resources/dist/img/j1p4.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-1" style="opacity: .8">
      <span class="brand-text font-weight-light">J1P4 Sports</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar os-host os-theme-light os-host-overflow os-host-overflow-y os-host-resize-disabled os-host-scrollbar-horizontal-hidden os-host-transition"><div class="os-resize-observer-host observed"><div class="os-resize-observer" style="left: 0px; right: auto;"></div></div><div class="os-size-auto-observer observed" style="height: calc(100% + 1px); float: left;"><div class="os-resize-observer"></div></div><div class="os-content-glue" style="margin: 0px -8px;"></div><div class="os-padding"><div class="os-viewport os-viewport-native-scrollbars-invisible" style="overflow-y: scroll;"><div class="os-content" style="padding: 0px 8px; height: 100%; width: 100%;">
<!--       Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
<%--         ${sess_pic } --%>
        <c:if test="${!sess_pic.equals('no') }">
        <c:set var="tmp" value="${sess_pic.substring(sess_pic.lastIndexOf('.')) }"/>
            <c:if test="${tmp=='.png' or tmp=='.jpg' or tmp=='.jpeg'}">
                <a href="/employee/myPage" class="d-block"><img src="/download?fileName=${sess_pic }" class="img-circle elevation-2" alt="User Image"></a>
            </c:if>
        </c:if>
        <c:if test="${sess_pic.equals('no') }">
          <a href="/employee/myPage" class="d-block"><img src="${pageContext.request.contextPath }/resources/img/default_profile.png" class="img-circle elevation-2" alt="User Image"></a>
        </c:if>
        </div>
        <div class="info">
          <a href="/employee/myPage" class="d-block">${sess_name }</a>
        </div>
        
      </div>
<!-- 			  <div class="dropdown" id="commute-div"> -->
<%-- 			    <c:choose>   --%>
<%-- 				<c:when test="${checkW eq '출근'}">  --%>
<!-- 			  <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;"> -->
<!-- 					퇴근하기 -->
<!-- 			  </button> -->
<%-- 				</c:when>  --%>
<%-- 				<c:when test="${checkW eq '퇴근'}">  --%>
<!-- 			  <button class="btn btn-success" type="button" id="dropdownMenuButton1" aria-expanded="false" style="width:100px;"> -->
<!-- 					퇴근했어요 -->
<!-- 			  </button> -->
<%-- 				</c:when>  --%>
<%-- 				<c:when test="${checkW eq '외출'}">  --%>
<!-- 			  <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;"> -->
<!-- 					복귀하기 -->
<!-- 			  </button> -->
<%-- 				</c:when>  --%>
<%-- 				<c:otherwise>  --%>
<!-- 			  <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;"> -->
<!-- 					출근하기 -->
<!-- 			  </button> -->
<%-- 				</c:otherwise>  --%>
<%-- 			</c:choose> --%>
<!-- 			  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"> -->
<!-- 			    <li><a class="dropdown-item" id="start_work">출근하기</a></li> -->
<!-- 			  </ul> -->
<!-- 			</div> -->
  
  

<!--       SidebarSearch Form -->
<!--       <div class="form-inline"> -->
<!--         <div class="input-group" data-widget="sidebar-search"> -->
<!--           <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search"> -->
<!--           <div class="input-group-append"> -->
<!--             <button class="btn btn-sidebar"> -->
<!--               <i class="fas fa-search fa-fw"></i> -->
<!--             </button> -->
<!--           </div> -->
<!--         </div><div class="sidebar-search-results"><div class="list-group"><a href="#" class="list-group-item"><div class="search-title"><strong class="text-light"></strong>N<strong class="text-light"></strong>o<strong class="text-light"></strong> <strong class="text-light"></strong>e<strong class="text-light"></strong>l<strong class="text-light"></strong>e<strong class="text-light"></strong>m<strong class="text-light"></strong>e<strong class="text-light"></strong>n<strong class="text-light"></strong>t<strong class="text-light"></strong> <strong class="text-light"></strong>f<strong class="text-light"></strong>o<strong class="text-light"></strong>u<strong class="text-light"></strong>n<strong class="text-light"></strong>d<strong class="text-light"></strong>!<strong class="text-light"></strong></div><div class="search-path"></div></a></div></div> -->
<!--       </div> -->

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
         <li class="nav-header">Main</li>
          <li class="nav-item">
            <a href="/main/home" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
          </li>
         <li class="nav-header">Management</li>
          <li class="nav-item"> 
            <a href="/vacation/vacation" class="nav-link">
              <i class="nav-icon fas fa-user"></i>
              <p>
                직원 관리
<!--                 <span class="right badge badge-danger">New</span> -->
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="/member/list" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                회원 관리
<!--                 <span class="badge badge-info right">6</span> -->
              </p>
            </a>
          </li>
          <li class="nav-item" id="centerLi">
            <a href="#" class="nav-link" id="center">
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                센터 관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/maintenance/facility" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>시설 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/maintenance/equipment" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>장비 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/member/message" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>디지털 마케팅</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/analysis/totalMemAnalysis" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>분석</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-book"></i>
              <p>
                수강 관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/classes/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>강의등록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/attendance/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>출석관리</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>
                공지사항
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="pages/forms/general.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>명규씨도</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/forms/advanced.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>알아서</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/forms/editors.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>채우십</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/forms/validation.html" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>쇼</p>
                </a>
              </li>
            </ul>
          </li>
         
</ul>
<!-- 		<div style="border: solid;">@@@@@@@@@@@@@</div> -->
      </nav>
      <!-- /.sidebar-menu -->
    </div></div></div><div class="os-scrollbar os-scrollbar-horizontal os-scrollbar-unusable os-scrollbar-auto-hidden"><div class="os-scrollbar-track"><div class="os-scrollbar-handle" style="width: 100%; transform: translate(0px, 0px);"></div></div></div><div class="os-scrollbar os-scrollbar-vertical os-scrollbar-auto-hidden"><div class="os-scrollbar-track"><div class="os-scrollbar-handle" style="height: 65.3422%; transform: translate(0px, 0px);"></div></div></div><div class="os-scrollbar-corner"></div></div>
    <!-- /.sidebar -->
  </aside>