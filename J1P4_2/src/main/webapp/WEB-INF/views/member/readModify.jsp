<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>

<div class="content-wrapper" style="min-height: 831px;">
<h3>회원 기본정보</h3>
회원등급 :${readMem.mem_rank}<br>
회원번호 : ${readMem.mem_no }<br>
이름 : ${readMem.mem_name }<br>
생년월일 : ${readMem.mem_birth }<br>
성별 : 
<c:if test="${readMem.mem_gender == 1}">
여자<br>
</c:if>
<c:if test="${readMem.mem_gender == 0}">
남자<br>
</c:if>
주소 : ${readMem.mem_addr1} ${readMem.mem_addr2}<br>
휴대폰번호 : ${readMem.mem_phone}<br>
메시지 수신동의 :
<c:if test="${readMem.sms_opt == 1}">
동의<br>
</c:if>
<c:if test="${readMem.sms_opt == 0}">
미동의<br>
</c:if>
이메일 : ${readMem.mem_email}<br>
이메일 수신동의 :
<c:if test="${readMem.email_opt == 1}">
동의<br>
</c:if>
<c:if test="${readMem.email_opt == 0}">
미동의<br>
</c:if>
수강상태 :
<c:if test="${readMem.class_status == 1}">
미수강<br>
</c:if>
<c:if test="${readMem.class_status == 0}">
수강중<br>
</c:if>
수강 누적시간 : ${readMem.class_time}시간<br>
특이사항 : ${readMem.mem_note}<br>
등록일 : ${readMem.reg_date}<br>

</div>

<%@ include file="../include/footer.jsp"%>