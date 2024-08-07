<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/empMenu.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!-- 카카오 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script>
function syncJobRank() {
    var jobSelect = document.getElementById("job");
    var jobRankSelect = document.getElementById("job_rank");
    var selectedJob = jobSelect.options[jobSelect.selectedIndex].text;

    if (selectedJob === "관리자") {
        for (var i = 0; i < jobRankSelect.options.length; i++) {
            if (jobRankSelect.options[i].text === "관리자") {
                jobRankSelect.selectedIndex = i;
                jobRankSelect.disabled = true; // 직급 필드를 비활성화
                break;
            }
        }
    } else {
        jobRankSelect.disabled = false; // 직급 필드를 활성화
        var firstNonAdminIndex = 0;
        for (var i = 0; i < jobRankSelect.options.length; i++) {
            if (jobRankSelect.options[i].text === "관리자") {
                jobRankSelect.options[i].disabled = true; // 관리자 직급을 비활성화
            } else {
                if (firstNonAdminIndex === 0) {
                    firstNonAdminIndex = i;
                }
                jobRankSelect.options[i].disabled = false; // 다른 직급을 활성화
            }
        }
        if (jobRankSelect.options[jobRankSelect.selectedIndex].text === "관리자") {
            jobRankSelect.selectedIndex = firstNonAdminIndex; // 첫 번째 활성화된 옵션으로 설정
        }
    }
}

document.addEventListener("DOMContentLoaded", function() {
    var jobSelect = document.getElementById("job");
    var jobRankSelect = document.getElementById("job_rank");

    // '관리자'가 첫 번째 옵션인 경우 다음 옵션으로 변경
    if (jobRankSelect.options[0].text === "관리자") {
        jobRankSelect.selectedIndex = 1;
    }

    // 페이지 로드 시 '관리자'를 비활성화
    for (var i = 0; i < jobRankSelect.options.length; i++) {
        if (jobRankSelect.options[i].text === "관리자") {
            jobRankSelect.options[i].disabled = true;
        }
    }

    syncJobRank(); // 페이지 로드 시 초기화
});
</script>
    	
<div class="content-wrapper" style="min-height: 831px;">
<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->
	<form action="" method="get" class='actionForm'>

		<div class="form-inline">
		
			<!-- 검색 -->
			<div class="input-group mb-3">
			
				<!-- 검색 타입 선택 -->
				<div class="input-group-prepend">
					<select name="searchType" id="selectType" class="form-control">
						<option value="searchAll" selected="selected">전체</option>
						<option value="searchName">이름</option>
						<option value="searchPhoneNum">연락처</option>
						<option value="searchEmail">이메일</option>
					</select>
				</div>
				
				<!-- 검색 입력창 -->
				<input class="form-control" type="search" name="keyword"
					value="${param.keyword }" placeholder="Search" aria-label="Search">
				
				<!-- 검색 버튼 -->	
				<div class="input-group-append">
					<button class="btn" type="submit" id="submitBtn"
						onclick="toggleSpinner()">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
				
			</div>
			
		</div>
		<div style="display: inline-block;">
		<!-- 필터 모달창 버튼 -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#filterModal">
				<i class="fas fa-filter fa-fw"></i>
			</button>

			<!-- 필터 지우기 버튼 -->
			<button type="button" class="btn btn-info" id="resetFilters">
				<i class="fas fa-trash fa-fw"></i>
			</button>
		</div>
		
		<!-- 사용자가 선택한 필터를 보여주는 공간 -->
		<div style="padding-left: 10px; display: inline-block;">
		<div class="filter1" style="display: inline-block;">
			<div class="deleteFilter">
				<!-- 사용자가 필터를 사용하여 검색했을 때 선택한 필터를 보여주는 공간 -->
				<c:if test="${not empty param.filter }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="filter" value="${param.filter }">${param.filter }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter2" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.job }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="job" value="${param.job }">${param.job }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter3" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.job_rank }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="job_rank" value="${param.job_rank }">${param.job_rank }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>

		</div>

		<!-- 테이블 커스텀 (정렬 / 행 개수) -->
		<div class="content memListSort">
		
			<div>검색결과 : ${pageVO.totalCount }명</div>
			
			<!-- 정렬 기준 선택 -->
			<div id="sortRight">
				<input type="hidden" name="sortCri"> <input type="hidden"
					name="sortVal"> <input type="radio" value="name"
					class="btn-check chkSort" id="radioName1"> <label
					class="btn" for="radioName1">이름순(오름차순)</label> <input type="radio"
					value="name" class="btn-check chkSort" id="radioName2">
				<label class="btn" for="radioName2">이름순(내림차순)</label> <input
					type="radio" value="emp_date" class="btn-check chkSort"
					id="radioReg"> <label class="btn" for="radioReg">등록순</label>
			</div>
			
			<!-- 행 개수 선택 -->
			<div class="textRight">
				<select name="pageSize" id="selectPage" class="form-control">
					<option value="10">10개씩 보기</option>
					<option value="50">50개씩 보기</option>
					<option value="100">100개씩 보기</option>
				</select>
			</div>
			
		</div>

	</form>
	<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->

	<!-- 필터 모달창 시작 -->
	<div class="modal fade" id="filterModal" tabindex="-1"
		aria-labelledby="filterModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- 필터 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="filterModalLabel">필터하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 필터 모달창 바디(본문) -->
				<div class="modal-body">

					<h5>직무별</h5>
					<div class="content">
						<input type="radio" value="관리자" class="btn-check" name="job"
							id="radioJob1"> <label
							class="btn btn-outline-dark radioField" for="radioJob1">관리자</label>
						<input type="radio" value="시설팀" class="btn-check" name="job"
							id="radioJob2"> <label
							class="btn btn-outline-dark radioField" for="radioJob2">시설팀</label>
						<input type="radio" value="강사팀" class="btn-check" name="job"
							id="radioJob3"> <label
							class="btn btn-outline-dark radioField" for="radioJob3">강사팀</label>
						<input type="radio" value="운영팀" class="btn-check" name="job"
							id="radioJob4"> <label
							class="btn btn-outline-dark radioField" for="radioJob4">운영팀</label>
						<input type="radio" value="안내데스크" class="btn-check" name="job"
							id="radioJob5"> <label
							class="btn btn-outline-dark radioField" for="radioJob5">안내데스크</label>
					</div>
					<hr>
					<h5>직급별</h5>
					<div class="content">
						<input type="radio" value="관리자" class="btn-check" name="job_rank"
							id="radioRank1"> <label
							class="btn btn-outline-dark radioField" for="radioRank1">관리자</label>
						<input type="radio" value="팀장" class="btn-check" name="job_rank"
							id="radioRank2"> <label
							class="btn btn-outline-dark radioField" for="radioRank2">팀장</label>
						<input type="radio" value="사원" class="btn-check" name="job_rank"
							id="radioRank3"> <label
							class="btn btn-outline-dark radioField" for="radioRank3">사원</label>
					</div>
					<hr>
					<h5>출근 여부</h5>
					<div class="content">
						<input type="radio" value="출근" class="btn-check" name="filter"
							id="radioChk1"> <label
							class="btn btn-outline-dark radioField" for="radioChk1">출근 중</label>
					</div>

				</div>

				<!-- 필터 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary filterBtn"
						data-bs-dismiss="modal">필터 추가</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 필터 모달창 끝 -->

<a href="/main/login" class="nav-link">
              <i class="nav-icon fas fa-user"></i>
              <p>
                로그인
              </p>
</a>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>
<%-- ${principal} <br> --%>
<%-- user_id : ${principal.username}<br> --%>
<%-- 권한 : ${principal.authorities}<br> --%>
<%-- 출근상태 : ${checkW } --%>
<%-- ${author } --%>
<!-- <div class="dropdown" id="commute-div"> -->
<%--     <c:choose>   --%>
<%-- 	<c:when test="${checkW eq '출근'}">  --%>
<!--   <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;"> -->
<!-- 		퇴근하기 -->
<!--   </button> -->
<%-- 	</c:when>  --%>
<%-- 	<c:when test="${checkW eq '퇴근'}">  --%>
<!--   <button class="btn btn-success" type="button" id="dropdownMenuButton1" aria-expanded="false" style="width:100px;"> -->
<!-- 		퇴근했어요 -->
<!--   </button> -->
<%-- 	</c:when>  --%>
<%-- 	<c:when test="${checkW eq '외출'}">  --%>
<!--   <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;"> -->
<!-- 		복귀하기 -->
<!--   </button> -->
<%-- 	</c:when>  --%>
<%-- 	<c:otherwise>  --%>
<!--   <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;"> -->
<!-- 		출근하기 -->
<!--   </button> -->
<%-- 	</c:otherwise>  --%>
<%-- </c:choose> --%>
<!--   <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"> -->
<!--     <li><a class="dropdown-item" id="start_work">출근하기</a></li> -->
<!--   </ul> -->
<!-- </div> -->
		
		<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">등록하기</button>
	<div class="col-sm-12">
		<table id="example1" class="table table-bordered table-hover"
			style="background: #fff" aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">직원번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">아이디</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">직무</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">직급</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">전화번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">이메일</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="emp" items="${empList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${emp.user_no }</td>
						<td class="dtr-control" tabindex="0">${emp.user_id }</td>
						<td class=""><a
							href="/employee/empDetail?user_no=${emp.user_no }">${emp.name }</a></td>
						<td>${emp.job }</td>
						<td>${emp.job_rank }</td>
						<td>${emp.phone_no }</td>
						<td>${emp.email }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>
<!-- 페이징 처리 -->
			<ul class="pagination" >
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword and empty param.job and empty param.job_rank and empty param.filter
						and empty param.sortCri and empty param.sortVal}">
							<a
								href="/employee/empList?page=${pageVO.startPage-1 }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword or not empty param.job or not empty param.job_rank or not empty param.filter
						or not empty param.sortCri or not empty param.sortVal}">
							<a
								href="/employee/empList?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&job=${pageVO.cri.job }&job_rank=${pageVO.cri.job_rank }
								&filter=${pageVO.cri.filter }&sortCri=${pageVO.cri.sortCri }&sortVal=${pageVO.cri.sortVal }&page=${i }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if>
					</li>
				</c:if>
				<c:forEach var="i" begin="${pageVO.startPage }"
					end="${pageVO.endPage }" step="1">
					<li
						class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword and empty param.job and empty param.job_rank and empty param.filter
						and empty param.sortCri and empty param.sortVal}">
							<a href="/employee/empList?page=${i }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword or not empty param.job or not empty param.job_rank or not empty param.filter
						or not empty param.sortCri or not empty param.sortVal}">
							<a
								href="/employee/empList?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&job=${pageVO.cri.job }&job_rank=${pageVO.cri.job_rank }
								&filter=${pageVO.cri.filter }&sortCri=${pageVO.cri.sortCri }&sortVal=${pageVO.cri.sortVal }&page=${i }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if>
					</li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword and empty param.job and empty param.job_rank and empty param.filter
						and empty param.sortCri and empty param.sortVal}">
							<a
								href="/employee/empList?page=${pageVO.endPage+1 }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword or not empty param.job or not empty param.job_rank or not empty param.filter
						or not empty param.sortCri or not empty param.sortVal }">
							<a
								href="/employee/empList?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&job=${pageVO.cri.job }&job_rank=${pageVO.cri.job_rank }
								&filter=${pageVO.cri.filter }&sortCri=${pageVO.cri.sortCri }&sortVal=${pageVO.cri.sortVal }&page=${i }&pageSize=${pageVO.cri.pageSize}"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if>
					</li>
				</c:if>
		</ul>	

</div>


<form action="" method="post" id="fm1" name="fm1">
	
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">직원등록</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
	 

            <section class="content">
                <div class="container-fluid">
                  
                        <div class="form-group">
                            <label>아이디</label>
                            <input type="text" name="user_id" class="form-control" id="user_id">
                            <span id="check" style="font-size: 14px;"></span>
                        </div>
                        
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" name="name"  class="form-control" >
                        </div>

                        <div class="form-group" >
                            <label>비밀번호</label>
                            <input type="text" name="user_pw" class="pass form-control" id="pw1">
                        </div>
                        <span id="checkpass2" style="font-size: 14px;"></span>
                        <div class="form-group" >
                            <label>비밀번호 확인</label>
                            <input type="text" class="pass form-control" id="pw2">
                        </div>
                        <span id="checkpass" style="font-size: 14px;"></span>
                       
                        <form:form method="post" modelAttribute="employee">
                        <div class="form-group">
                            <label>직무</label>
                            <form:select path="job" class="form-control" id="job" name="job" onchange="syncJobRank()">
                                <form:options items="${job}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                        </div>
                        
                        <div class="form-group">
                            <label>직급</label>
                            <form:select path="job_rank" class="form-control" id="job_rank" name="job_rank">
                                <form:options items="${job_rank}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                        </div>
                        </form:form>
                     
						<div class="form-group">
							<label>입사일</label> <input type="date" name="emp_date"
								class="form-control" />
						</div>
						
						<div class="form-group">
							<label>생일</label> <input type="date" name="birth_date"
								class="form-control" />
						</div>
                      
                        <div class="form-group">
                            <label>성별</label><br>
                            <input type="radio" name="gender" value="0" >남 
                			<input type="radio" name="gender" value="1" >여
                        </div>
 
                        <div class="form-group">
                            <label>전화번호</label>
                            <input type="text" name="phone_no"  class="form-control"  maxlength="13" oninput="formatPhoneNumber(this)">
                        </div>
                      
                        <div class="form-group">
                            <label>이메일</label>
                            <input type="text" name="email"  class="form-control" >
                        </div>
                       
                        <div class="form-group">
                            <label>우편번호</label>
                            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-dark btn-sm">
                            <input type="text" id="sample6_postcode" placeholder="우편번호" name="zip_code"  class="form-control" >
                        </div>
                        <div class="form-group">
                            <label>주소</label>
                            <input type="text" id="sample6_address" placeholder="주소" name="addr1"  class="form-control" >
                        </div>
                        <div class="form-group">
                            <label>상세주소</label>
                            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addr2"  class="form-control" >
                        </div>
                        <div class="form-group">
                            <label>사진업로드</label>
                            <input type="file" name="file" accept="image/jpg, image/jpeg, image/png" class="form-control" >
                        </div>
                        
                        
                        <button type="button" class="btn btn-primary" id="submitButt">등록</button>
                    
                </div>
            </section>
		</div>
	</div>
	
		</form>



<script>


$(function() {
	$("#submitButt").click(function() {
		const token = $("meta[name='_csrf']").attr("content")
		const header = $("meta[name='_csrf_header']").attr("content");
		
		var formData = new FormData($("#fm1")[0]);
		
		$.ajax({
			url : "/employee/empList",
			type : "POST",
			data : formData,
			contentType: false, //필수
            processData: false, //필수
            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
                xhr.setRequestHeader(header, token);
            },
			success : function(data) {
				alert("직원이 등록 되었습니다.");
				
				history.go(0);

				
			},
			error : function() {
				alert("오류발생");
			}
		});
	});
});

</script>

<!-- 카카오우편번호api -->
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<script type="text/javascript">
	// 아이디 입력값을 가져오고, 입력값을 서버로 전송하고-> 똑같은 아이디가 있는지 체크한 후
	// 사용 가능 여부를 아이디 입력창 아래에 표시

	$(document)
			.ready(
					function() {

						$('#user_id')
								.keyup(
										function() {
											var user_id = $('#user_id').val();
											//alert(user_id);
											$
													.ajax({
														url : "/employee/idcheck",
														type : "get",
														data : {
															user_id : user_id
														},
														success : function(res) {

															let input_id = document.fm1.user_id.value; //name=user_id값
															console.log(input_id);

															//아이디 유효성검사
															let check_id = /^[a-z0-9_-]{5,12}$/;
															let memberid = $(
																	'#user_id')
																	.val();

															if (input_id.length == 0) { //아무것도 입력안한상태
																$('#check')
																		.html(
																				'아이디는 6~12자리 영어,숫자만 사용 가능합니다.')
																		.css(
																				'color',
																				'black')
															} else if ((res == 1)
																	|| (!check_id
																			.test(memberid))) { // 사용불가
																$('#check')
																		.html(
																				'중복된 아이디거나, 조건에 맞지 않습니다.')
																		.css(
																				'color',
																				'red')
															} else if (res != 1) {//사용가능
																$('#check')
																		.html(
																				'사용 가능한 아이디입니다.')
																		.css(
																				'color',
																				'green')
															}

														},
														error : function(
																request, error) {
															alert("에러");
														}
													});

										});

						//비밀번호 유효성검사 , 비밀번호 재확인
						$('.pass')
								.keyup(
										function() {

											let check_pw = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/;
											let memberpw = $('#pw1').val();

											var pass1 = $('#pw1').val();
											var pass2 = $('#pw2').val();

											//비밀번호 조건 일치/불일치
											if (!check_pw.test(memberpw)) {
												$('#checkpass2')
														.html(
																'8~20자리의 영어,숫자,특수문자 조합으로 입력해주세요.')
														.css('color', 'red');
											} else {
												$('#checkpass2').html(
														'비밀번호가 조건에 일치합니다.')
														.css('color', 'green');
											}

											//비밀번호 재확인
											if (check_pw.test(memberpw)) {
												if (!pass1 == ""
														|| !pass2 == "") {
													if (pass1 == pass2) {
														$('#checkpass')
																.html(
																		'비밀번호가 일치합니다.')
																.css('color',
																		'green')
													} else if (pass1 != pass2) {
														$('#checkpass')
																.html(
																		'비밀번호를 다시 확인해주세요.')
																.css('color',
																		'red');
													}

												}
											}


										});

					});

	//회원가입 공백 처리
	$('#insertMember').click(function() {
		var useremail = document.form_join.user_email.value;
		var username = document.form_join.name.value;
		var user_id = document.form_join.user_id.value;
		var userpw = document.form_join.user_pw.value;
		var userpw2 = document.form_join.user_pw2.value;

		if (useremail == "") {
			alert("모든 칸을 입력해주세요");
			return;
		}
		if (username == "") {
			alert("모든 칸을 입력해주세요");
			return;
		}
		if (user_id == "") {
			alert("모든 칸을 입력해주세요");
			return;
		}
		if (userpw == "") {
			alert("모든 칸을 입력해주세요");
			return;
		}
		if (userpw2 == "") {
			alert("모든 칸을 입력해주세요");
			return;
		}
		$('#insertMember').attr("type", "submit");
		location.href = '/member/insert';

	});
</script>
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
	
	
	/* 사용자가 선택한 필터 출력 */
	$(function() {
		$('.filterBtn')
				.click(
						function() {

							let filter = $('input[name=filter]:checked').val();
							let job = $('input[name=job]:checked').val();
							let job_rank = $('input[name=job_rank]:checked')
									.val();

							/* 출근여부 필터를 선택했을 때 */
							if (filter != undefined) {
								$('.filter1')
										.html(
												'<div class="deleteFilter"><h5><span class="badge badge-warning p-2" style="color: #000;">'
														+ '<input type="hidden" name="filter" value="'+filter+'">'
														+ filter
														+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
														+ '</button></span></h5></div>');
							}

							/* 직무 선택했을 때 */
							if (job != undefined) {
								$('.filter2')
										.html(
												'<div class="deleteFilter"><h5><span class="badge badge-warning p-2" style="color: #000;">'
														+ '<input type="hidden" name="job" value="'+job+'">'
														+ job
														+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
														+ '</button></span></h5></div>');
							}

							/* 직급 선택했을 때 */
							if (job_rank != null) {

								$('.filter3')
										.html(
												'<div class="deleteFilter"><h5><span class="badge badge-warning p-2" style="color: #000;">'
														+ '<input type="hidden" name="job_rank" value="'+job_rank+'">'
														+ job_rank
														+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
														+ '</button></span></h5></div>');
							}

						});

	});

	/* 선택한 필터 개별 삭제 */
	$(document).on('click', '.removeFi', function() {
		$(this).parent().remove()
	});

	/* 선택한 필터 전체 삭제 */
	$(document).ready(function() {
		$('#resetFilters').click(function() {
			if (confirm("필터를 삭제하시겠습니까?")) {
				$('.deleteFilter').empty();
			}
		});
	});

	if ('${param.searchType}' == '${pageVO.cri.searchType}'
			&& '${pageVO.cri.searchType}' != '') {
		$("#selectType").val("${param.searchType}");
	}

	$("#selectPage").val("${pageVO.cri.pageSize }");
	
	$("#selectPage").change(function() {

		$('input[name="sortVal"]').val('${param.sortVal}');
		$('input[name="sortCri"]').val('${param.sortCri}');

		$(".actionForm").submit();
	});
	
	$(document).ready(function() {
		$('.chkSort').on('change', function() {
			var selectedVal = $(this).val();
			var sortCriValue;

			if ($(this).attr('id') === 'radioName1') {
				sortCriValue = 'asc'; // 오름차순
			} else if ($(this).attr('id') === 'radioName2') {
				sortCriValue = 'desc'; // 내림차순
			} else if ($(this).attr('id') === 'radioReg') {
				sortCriValue = 'asc'; // 등록순
			}

			// sortCri, sortVal 업데이트
			$('input[name="sortVal"]').val(selectedVal);
			$('input[name="sortCri"]').val(sortCriValue);

			// 확인을 위해 콘솔에 출력
			console.log('Selected sortCri:', sortCriValue);

			$(".actionForm").submit();

		});
	});

	// 연락처 입력 시 자동으로 하이픈 추가
	function formatPhoneNumber(input) {
		let value = input.value.replace(/\D/g, ''); // 숫자 이외의 문자 제거
        let formattedValue = '';
        
        if (value.length <= 3) {
            formattedValue = value;
        } else if (value.length <= 7) {
            formattedValue = value.replace(/(\d{3})(\d{0,4})/, '$1-$2');
        } else {
            formattedValue = value.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
        }
        
        input.value = formattedValue;
    }
	

</script>


<%@ include file="../include/footer.jsp"%>