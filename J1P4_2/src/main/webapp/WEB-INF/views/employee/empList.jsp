<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<!-- 카카오 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="content-wrapper" style="min-height: 831px;">


<h1>empList </h1>
<a href="/customLogin" class="nav-link">
              <i class="nav-icon fas fa-user"></i>
              <p>
                로그인
              </p>
</a>

		
		<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">등록하기</button>
	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-striped dataTable dtr-inline"
			aria-describedby="example1_info">
			<thead>
				<tr>
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
						<td class="dtr-control" tabindex="0">${emp.user_id }</td>
						<td class=""><a
							href="#">${emp.name }</a></td>
						<td>${emp.job }</td>
						<td>${emp.job_rank }</td>
						<td>${emp.phone_no }</td>
						<td>${emp.email }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

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
                       
                        <div class="form-group">
                            <label>직무</label>
                            <form:select path="job" class="form-control" name="job">
                                <form:options items="${job}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                        </div>
                        
                        <div class="form-group">
                            <label>직급</label>
                            <form:select path="job_rank" class="form-control" name="job_rank">
                                <form:options items="${job_rank}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                        </div>
                     
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
                            <input type="text" name="phone_no"  class="form-control" >
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
                        
                        
                        <button type="button" class="btn btn-primary" id="submitButt">등록</button>
                    
                </div>
            </section>
		</div>
	</div>
	
		</form>



<script>


$(function() {
	$("#submitButt").click(function() {
		$.ajax({
			url : "/employee/empList",
			type : "POST",
			data : $("#fm1").serialize(),
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


<%@ include file="../include/footer.jsp"%>