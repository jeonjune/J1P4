<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/empMenu.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-wrapper" style="min-height: 831px;">
	<div class="card cardCustom">
	
    <div class="col-md-10 mx-auto" style="margin-top: 50px;">

        <div class="card">
            <div class="card-body">
					<div class="card">
            <div style="position: absolute; right: 15px; top:15px;">
						<a href="/employee/empList">
							<button type="button" class="btn btn-light">뒤로가기</button>
						</a>
						<button class="btn btn-primary" type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
							aria-controls="offcanvasRight">수정하기</button>
						<!-- 직원 삭제(퇴사) 버튼 -->
						<button class="btn btn-primary" type="button" id="reEmp">삭제하기</button>
					</div>
                <div class="p-3">
                <c:if test="${empDt.job_rank == '관리자'}">
                    <span class="badge badge-success right"><strong><i class="fas fa-crown"></i> 관리자</strong></span>
                </c:if>
                <c:if test="${empDt.job_rank == '사원'}">
                    <span class="badge badge-success right"><strong><i class="fas fa-seedling"></i> 사원</strong></span>
                </c:if>
                <c:if test="${empDt.job_rank == '팀장'}">
                    <span class="badge badge-success right"><strong><i class="fas fa-user"></i> 팀장</strong></span>
                </c:if>
                <h2 style="margin-top: 10px;">${empDt.name }님
                    <c:if test="${empDt.job_rank == '관리자'}">(${empDt.job })</c:if>
                    <c:if test="${empDt.job_rank == '팀장' || empDt.job_rank == '사원' }">(${empDt.job } ${empDt.job_rank })</c:if>
                </h2>
                </div>
                </div>

                <div class="d-flex flex-wrap align-items-start">
                    <div id="profile" class="me-3 m-3" style="flex: 0 0 200px; width: 200px; height: 270px;">
        <c:if test="${empty fileList}">
        <img src="${pageContext.request.contextPath }/resources/img/default_profile.png" style="width: 100%; height: 100%; object-fit: cover;">
    </c:if>
    <c:if test="${not empty fileList}">
    <c:if test='${not empty fileList.file_name }'>
        <p class="text-muted cardMy">
            <c:set var="tmp" value="${fileList.file_name.substring(fileList.file_name.lastIndexOf('.')) }"/>
            <c:if test="${tmp=='.png' or tmp=='.jpg' or tmp=='.jpeg'}">
                <img src="/download?fileName=${fileList.file_name }" style="width: 100%; height: 100%; object-fit: cover;">
            </c:if>
        </p>
        </c:if>
		<c:if test='${empty fileList.file_name }'>
        <img src="${pageContext.request.contextPath }/resources/img/default_profile.png" style="width: 100%; height: 100%; object-fit: cover;">
		</c:if>
		</c:if>
</div>

                    <div class="d-flex flex-column flex-fill" style="flex: 1; min-width: 0;">
                        <div class="d-flex flex-wrap" style="margin-left: 70px;">
                            <div class="col-md-6" id="detail1">
                                <div class="cardMy">
                                    <strong><i class="fas fa-phone mr-1 cardMx"></i> 연락처 </strong>
                                    <p class="text-muted cardMy">${empDt.phone_no}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="far fa-heart mr-1 cardMx"></i> 생년월일</strong>
                                    <p class="text-muted cardMy">${empDt.birth_date }</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="fas fa-venus-mars mr-1 cardMx"></i> 성별</strong>
                                    <p class="text-muted cardMy">
                                        <c:if test="${empDt.gender == true}">
                                            여자<br>
                                        </c:if>
                                        <c:if test="${empDt.gender == false}">
                                            남자<br>
                                        </c:if>
                                    </p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="far fa-calendar mr-1 cardMx"></i> 입사일</strong>
                                    <p class="text-muted cardMy">${empDt.emp_date}</p>
                                </div>
                            </div>

                            <div class="col-md-6" id="detail2">
                                <div class="cardMy">
                                    <strong><i class="far fa-envelope mr-1 cardMx"></i> 이메일 </strong>
                                    <p class="text-muted cardMy">${empDt.email}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="fas fa-map-marker-alt mr-1 cardMx"></i> 주소</strong>
                                    <p class="text-muted cardMy">${empDt.addr1}${myP.addr2}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="fas fa-star mr-1 cardMx"></i> 직급</strong>
                                    <p class="text-muted cardMy">${empDt.job_rank}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="far fa-file-alt mr-1 cardMx"></i> 직무</strong>
                                    <p class="text-muted cardMy">${empDt.job }</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id='actionForm' action="/employee/reEmp" method='get'>
	<input id="user_id" type='hidden' name='user_id' value='${empDt.user_id}'>
</form>

<!-- 직원 수정창 (모달) -->
<form action="" method="post" id="fm1" name="fm1">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">직원수정</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
	 

            <section class="content">
                <div class="container-fluid">
                  <!-- 수정가능한것 : 직무, 직급, 전화번호, 이메일, 주소 -->
                        <div class="form-group">
                            <label>아이디</label>
                            <input type="text" name="user_id" class="form-control" id="user_id" value="${empDt.user_id }" readonly>
                            <span id="check" style="font-size: 14px;"></span>
                        </div>
                        
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" name="name"  class="form-control" value="${empDt.name }" readonly>
                        </div>

                        <span id="checkpass" style="font-size: 14px;"></span>
                       
                        <div class="form-group">
                            <label>직무</label>
                            <form:select path="job" class="form-control" name="job" id="jobSelect">
                            	<form:option selected="true" value="${empDt.job}">${empDt.job}</form:option>
                                <form:options items="${job}" itemValue="codeValue" itemLabel="codeValueName"/>
                                
                            </form:select>
                        </div>
                        
                        <div class="form-group">
                            <label>직급</label>
                            <form:select path="job_rank" class="form-control" name="job_rank">
                            	<form:option selected="true" value="${empDt.job_rank}">${empDt.job_rank}</form:option>
                                <form:options items="${job_rank}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                        </div>
 
                        <div class="form-group">
                            <label>전화번호</label>
                            <input type="text" name="phone_no"  class="form-control" value="${empDt.phone_no }">
                        </div>
                      
                        <div class="form-group">
                            <label>이메일</label>
                            <input type="text" name="email"  class="form-control" value="${empDt.email }">
                        </div>
                       
                        <div class="form-group">
                            <label>우편번호</label>
                            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-dark btn-sm">
                            <input type="text" id="sample6_postcode" placeholder="우편번호" name="zip_code"  class="form-control" value="${empDt.zip_code }">
                        </div>
                        <div class="form-group">
                            <label>주소</label>
                            <input type="text" id="sample6_address" placeholder="주소" name="addr1"  class="form-control" value="${empDt.addr1 }">
                        </div>
                        <div class="form-group">
                            <label>상세주소</label>
                            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addr2"  class="form-control" value="${empDt.addr2 }">
                        </div>
                        
                        
                        <button type="button" class="btn btn-primary" id="submitButt">수정하기</button>

                    
                </div>
            </section>
		</div>
	</div>
	
		</form>

</div>

<script>
	$(function() {
		$("#submitButt").click(function() {
			
			$.ajax({
				url : "/employee/empUpdate",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					alert("직원정보가 수정되었습니다.");

					history.go(0);

				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});

	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
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
				document.getElementById("sample6_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("sample6_detailAddress").focus();
			}
		}).open();
	}
	$(document).ready(function(){
		
	var actionForm = $("#actionForm");
	  /* 삭제 버튼 클릭 */
	  $("#reEmp").on("click", function(e) {
		e.preventDefault();  //전송을 막음
		console.log('click');
		
		actionForm.submit();
	  });
	});  
</script>


<%@ include file="../include/footer.jsp"%>