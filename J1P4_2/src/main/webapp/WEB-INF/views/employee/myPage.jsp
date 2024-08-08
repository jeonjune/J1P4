<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/myMenu.jsp"%>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script>
function syncJobRank() {
    var jobSelect = document.getElementById("jobSelect");
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
 <style>
     #passwordFields {
         display: none;
     }
 </style>
 
<div class="content-wrapper" style="min-height: 831px;">

	<div class="card cardCustom">
    <div class="col-md-10 mx-auto" style="margin-top: 50px;">

        <div class="card">
            <div class="card-body">
            <div class="card">
                <div style="position: absolute; right: 15px; top:15px;">
                    <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">수정하기</button>
                </div>
                <div class="p-3">
                <c:if test="${myP.job_rank == '관리자'}">
                    <span class="badge badge-success right"><strong><i class="fas fa-crown"></i> 관리자</strong></span>
                </c:if>
                <c:if test="${myP.job_rank == '사원'}">
                    <span class="badge badge-success right"><strong><i class="fas fa-seedling"></i> 사원</strong></span>
                </c:if>
                <c:if test="${myP.job_rank == '팀장'}">
                    <span class="badge badge-success right"><strong><i class="fas fa-user"></i> 팀장</strong></span>
                </c:if>
                <h2 style="margin-top: 10px;">${myP.name }님
                    <c:if test="${myP.job_rank == '관리자'}">(${myP.job })</c:if>
                    <c:if test="${myP.job_rank == '팀장' || myP.job_rank == '사원' }">(${myP.job } ${myP.job_rank })</c:if>
                </h2>
                </div>
                </div>

                <div class="d-flex flex-wrap align-items-start">
                    <div id="profile" class="me-3 m-3" style="flex: 0 0 200px; width: 200px; height: 270px;">
    <c:if test="${fileList.file_name.equals('no') }">
        <img src="${pageContext.request.contextPath }/resources/img/default_profile.png" style="width: 100%; height: 100%; object-fit: cover; margin-bottom: 10px;">
    </c:if>
    <c:if test="${!fileList.file_name.equals('no') }">
        <p class="text-muted cardMy">
            <c:set var="tmp" value="${fileList.file_name.substring(fileList.file_name.lastIndexOf('.')) }"/>
            <c:if test="${tmp=='.png' or tmp=='.jpg' or tmp=='.jpeg'}">
                <img src="/download?fileName=${fileList.file_name }" style="width: 100%; height: 100%; object-fit: cover;">
            </c:if>
        </p>
        </c:if>
		<div  style="position: absolute; left: 65px;">
    <button type="button" class="btn btn-warning btn-sm"
    data-bs-toggle="modal" data-bs-target="#profileModal">사진변경
    </button>
    <button type="button" class="btn btn-outline-danger btn-sm fileDelete"
						style="color: #000;" data-bs-dismiss="modal">사진삭제</button>
		</div>
</div>

                    <div class="d-flex flex-column flex-fill" style="flex: 1; min-width: 0;">
                        <div class="d-flex flex-wrap" style="margin-left: 30px;">
                            <div class="col-md-6" id="detail1">
                                <div class="cardMy">
                                    <strong><i class="fas fa-phone mr-1 cardMx"></i> 연락처 </strong>
                                    <p class="text-muted cardMy">${myP.phone_no}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="far fa-heart mr-1 cardMx"></i> 생년월일</strong>
                                    <p class="text-muted cardMy">${myP.birth_date }</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="fas fa-venus-mars mr-1 cardMx"></i> 성별</strong>
                                    <p class="text-muted cardMy">
                                        <c:if test="${myP.gender == true}">
                                            여자<br>
                                        </c:if>
                                        <c:if test="${myP.gender == false}">
                                            남자<br>
                                        </c:if>
                                    </p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="far fa-calendar mr-1 cardMx"></i> 입사일</strong>
                                    <p class="text-muted cardMy">${myP.emp_date}</p>
                                </div>
                            </div>

                            <div class="col-md-6" id="detail2">
                                <div class="cardMy">
                                    <strong><i class="far fa-envelope mr-1 cardMx"></i> 이메일 </strong>
                                    <p class="text-muted cardMy">${myP.email}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="fas fa-map-marker-alt mr-1 cardMx"></i> 주소</strong>
                                    <p class="text-muted cardMy">${myP.addr1}${myP.addr2}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="fas fa-star mr-1 cardMx"></i> 직급</strong>
                                    <p class="text-muted cardMy">${myP.job_rank}</p>
                                </div>
                                <hr>
                                <div class="cardMy">
                                    <strong><i class="far fa-file-alt mr-1 cardMx"></i> 직무</strong>
                                    <p class="text-muted cardMy">${myP.job }</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


	</div>
	
	<!-- 사진 업로드 모달창 시작 -->
<form action="" method="post" id="fm2" name="fm2">	
	<div class="modal fade" id="profileModal" tabindex="-1"
		aria-labelledby="profileModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- 사진 업로드 필터 모달창 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="profileModalLabel">사진변경</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 사진 업로드 모달창 바디(본문) -->
				<div class="modal-body">
				<input type="hidden" name="user_id" class="form-control" id="user_id" value="${myP.user_id }">
					<input type="file" name="file" class="form-control" id="fileInput" accept="image/jpg, image/jpeg, image/png">
					<img id="preview" alt="미리보기" src="">	
				</div>

				<!-- 사진 업로드 모달창 푸터 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary fileUpdate"
						data-bs-dismiss="modal">변경하기</button>
					
				</div>

			</div>
		</div>
	</div>
</form>	
	<!-- 사진 업로드 모달창 끝 -->

<!-- 정보 수정창 (모달) -->
<form action="" method="post" id="fm1" name="fm1">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasRightLabel">내 정보 수정</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
	 

            <section class="content">
                <div class="container-fluid">
                  <!-- 수정가능한것 : 직무, 직급, 전화번호, 이메일, 주소 -->
                        <div class="form-group">
                            <label>아이디</label>
                            <input type="text" name="user_id" class="form-control" id="user_id" value="${myP.user_id }" readonly>
                            <span id="check" style="font-size: 14px;"></span>
                        </div>
                        
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" name="name"  class="form-control" value="${myP.name }" readonly>
                        </div>
                        
                         <div class="form-group">
			            <label>
			                <input type="checkbox" name="changePassword" id="changePassword" onclick="togglePasswordFields()"> 비밀번호 변경
			            </label>
        				</div>
				        <div id="passwordFields">
				            <div class="form-group">
				                <label>새 비밀번호</label>
				                <input type="text" name="user_pw" class="pass form-control" id="pw1">
				            </div>
				            <span id="checkpass2" style="font-size: 14px;"></span>
				            <div class="form-group">
				                <label>새 비밀번호 확인</label>
				                <input type="text" class="pass form-control" id="pw2">
				            </div>
	                        <span id="checkpass" style="font-size: 14px;"></span>
				        </div>

                       
                        <div class="form-group">
                            <label>직무</label>
                            <form:select path="job" class="form-control" name="job" id="jobSelect" onchange="syncJobRank()">
                            	<form:option selected="true" value="${myP.job}">${myP.job}</form:option>
                                <form:options items="${job}" itemValue="codeValue" itemLabel="codeValueName"/>
                                
                            </form:select>
                        </div>
                        
                        <div class="form-group">
                            <label>직급</label>
                            <form:select path="job_rank" class="form-control" id="job_rank" name="job_rank">
                            	<form:option selected="true" value="${myP.job_rank}">${myP.job_rank}</form:option>
                                <form:options items="${job_rank}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                        </div>
 
                        <div class="form-group">
                            <label>전화번호</label>
                            <input type="text" name="phone_no"  maxlength="13" oninput="formatPhoneNumber(this)" class="form-control" value="${myP.phone_no }">
                        </div>
                      
                        <div class="form-group">
                            <label>이메일</label>
                            <input type="text" name="email"  class="form-control" value="${myP.email }">
                        </div>
                       
                        <div class="form-group">
                            <label>우편번호</label>
                            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-dark btn-sm">
                            <input type="text" id="sample6_postcode" placeholder="우편번호" name="zip_code"  class="form-control" value="${myP.zip_code }">
                        </div>
                        <div class="form-group">
                            <label>주소</label>
                            <input type="text" id="sample6_address" placeholder="주소" name="addr1"  class="form-control" value="${myP.addr1 }">
                        </div>
                        <div class="form-group">
                            <label>상세주소</label>
                            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addr2"  class="form-control" value="${myP.addr2 }">
                        </div>
                        
                        
                        <button type="button" class="btn btn-primary" id="submitButt">수정하기</button>

                    
                </div>
            </section>
		</div>
	</div>
	
		</form>


<script>
	$(function() {
		$("#submitButt").click(function() {
			// 유효성 검사
		if (validateForm()) {
			
			$.ajax({
				url : "/employee/myUpdate",
				type : "POST",
				data : $("#fm1").serialize(),
				success : function(data) {
					alert("내 정보가 수정되었습니다.");

					history.go(0);

				},
				error : function() {
					alert("오류발생");
				}
			});
		}
			
		});
	});
	
	$(function() {
		$(".fileUpdate").click(function(event) {
			
			const token = $("meta[name='_csrf']").attr("content")
			const header = $("meta[name='_csrf_header']").attr("content");
						
			var formData = new FormData($("#fm2")[0]);
			
			$.ajax({
				url : "/file/upload",
				type : "POST",
				data : formData,
				contentType: false, //필수
	            processData: false, //필수
	            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
	                xhr.setRequestHeader(header, token);
	            },
				success : function(data) {
					alert("사진이 수정 되었습니다.");

					history.go(0);

				},
				error : function() {
					alert("오류발생");
				}
			});
		});
	});
	$(function() {
		$(".fileDelete").click(function(event) {
			
			const token = $("meta[name='_csrf']").attr("content")
			const header = $("meta[name='_csrf_header']").attr("content");
						
			var formData = new FormData($("#fm2")[0]);
			
			if(confirm("등록된 사진을 삭제하시겠습니까?")){
			$.ajax({
				url : "/file/delete",
				type : "POST",
				data : formData,
				contentType: false, //필수
	            processData: false, //필수
	            beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
	                xhr.setRequestHeader(header, token);
	            },
				success : function(data) {

					history.go(0);

				},
				error : function() {
					alert("오류발생");
				}
			});
			alert("삭제되었습니다.");
			
			}else{
				alert("취소되었습니다.");
			}
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

	 $(document).ready(function() {
         // 비밀번호 유효성 검사 및 비밀번호 재확인
         $('.pass').keyup(function() {
             let check_pw = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/;
             let memberpw = $('#pw1').val();

             var pass1 = $('#pw1').val();
             var pass2 = $('#pw2').val();

             // 비밀번호 조건 일치/불일치
             if (memberpw === "") {
                 $('#checkpass2').html('8~20자리의 영어,숫자,특수문자 조합으로 입력해주세요.').css('color', 'red');
             } else if (!check_pw.test(memberpw)) {
                 $('#checkpass2').html('8~20자리의 영어,숫자,특수문자 조합으로 입력해주세요.').css('color', 'red');
             } else {
                 $('#checkpass2').html('비밀번호가 조건에 일치합니다.').css('color', 'green');
             }

             // 비밀번호 재확인
             if (check_pw.test(memberpw)) {
                 if (pass1 !== "" || pass2 !== "") {
                     if (pass1 === pass2) {
                         $('#checkpass').html('비밀번호가 일치합니다.').css('color', 'green');
                     } else {
                         $('#checkpass').html('비밀번호를 다시 확인해주세요.').css('color', 'red');
                     }
                 }
             }
         });

         // 페이지 로드 시 기본 메시지 표시
         $('#checkpass2').html('8~20자리의 영어,숫자,특수문자 조합으로 입력해주세요.').css('color', 'red');
     });

     function togglePasswordFields() {
         var changePasswordCheckbox = document.getElementById('changePassword');
         var passwordFields = document.getElementById('passwordFields');

         if (changePasswordCheckbox.checked) {
             passwordFields.style.display = 'block';
         } else {
             passwordFields.style.display = 'none';
             // 비밀번호 입력란이 숨겨질 때 메시지 초기화
             $('#checkpass2').html('8~20자리의 영어,숫자,특수문자 조합으로 입력해주세요.').css('color', 'red');
             $('#checkpass').html('');
             $('#pw1').val('');
             $('#pw2').val('');
         }
     }

     function validateForm() {
         var changePasswordCheckbox = document.getElementById('changePassword');

         if (changePasswordCheckbox.checked) {
             var pass1 = $('#pw1').val();
             var pass2 = $('#pw2').val();
             let check_pw = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/;

             if (!check_pw.test(pass1)) {
                 alert('비밀번호는 8~20자리의 영어, 숫자, 특수문자 조합으로 입력해주세요.');
                 return false;
             }

             if (pass1 !== pass2) {
                 alert('비밀번호가 일치하지 않습니다.');
                 return false;
             }
         }else {
             // 비밀번호 변경 체크박스가 선택되지 않은 경우 비밀번호 필드 비활성화
             $('#pw1').prop('disabled', true);
             $('#pw2').prop('disabled', true);
         }

         return true;
     }
	
	  
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
	
		$(document).ready(function() {
            $('#fileInput').on('change', function(event) {
                const file = event.target.files[0];
                const reader = new FileReader();

                reader.onload = function(e) {
                    $('#preview').attr('src', e.target.result).show();
                };

                if (file) {
                    reader.readAsDataURL(file);
                }
            });
        });
		
	  
	  
</script>


<%@ include file="../include/footer.jsp"%>