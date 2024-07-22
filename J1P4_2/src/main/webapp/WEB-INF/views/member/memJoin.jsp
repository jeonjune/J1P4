<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<!-- 카카오 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<div class="content-wrapper" style="min-height: 831px;">

	<button class="btn btn-primary" type="button"
		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
		aria-controls="offcanvasRight">등록하기</button>
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
                  <!-- mem_name, mem_birth, mem_gender, mem_phone, sms_opt, mem_email, email_opt, mem_note, mem_addr1, mem_addr2
                   -->
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" name="mem_name"  class="form-control" >
                        </div>
                      
						<div class="form-group">
							<label>생일</label>
							<input type="date" name="mem_birth" class="form-control" />
						</div>
                      
                        <div class="form-group">
                            <label>성별</label><br>
                            <input type="radio" name="mem_gender" value="0" >남 
                			<input type="radio" name="mem_gender" value="1" >여
                        </div>
 
                        <div class="form-group">
                            <label>전화번호</label>
                            sms 수신동의<input type="radio" name="sms_opt" value="1" >
                            <input type="text" name="mem_phone"  class="form-control" >
                        </div>
                      
                        <div class="form-group">
                            <label>이메일</label>
                            이메일 수신동의<input type="radio" name="email_opt" value="1" >
                            <input type="text" name="mem_email"  class="form-control" >
                        </div>                       
						<div class="form-group">
							<label>메모</label>
							<input type="text" name="mem_note" class="form-control" />
						</div>
                        <div class="form-group">
                            <label>주소</label>
                            <input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기" class="btn btn-dark btn-sm">
                            <input type="text" id="sample6_address" placeholder="주소" name="mem_addr1"  class="form-control" >
                        </div>
                        <div class="form-group">
                            <label>상세주소</label>
                            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="mem_addr2"  class="form-control" >
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
			url : "/member/memJoin",
			type : "POST",
			data : $("#fm1").serialize(),
			success : function(data) {
				alert("회원이 등록 되었습니다.");
				
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
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<%@ include file="../include/footer.jsp"%>