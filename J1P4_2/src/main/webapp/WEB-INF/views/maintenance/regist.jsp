<%@ page language="java"  contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%-- <%@ include file="../include/equipMenu.jsp"%> --%>



<div class="content-wrapper" style="min-height: 831px;">

<h1>장비신청페이지 - regist</h1>
<form action=""  method="post" id="registForm"  accept-charset="UTF-8" >
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<div>

					
					<div class="form-group">
						<label>담당자</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>작성날짜</label> <input type="date" name="report_date"
							class="form-control" />
					</div>
					
					
					<div class="form-group">
						<label> 장비신청유형 </label> <select id="select_type"
							name="e_repair_type" size="1">
							<option>선택하세요.</option>
							<option value="구입">구입</option>
							<option value="수리">수리</option>
							<option value="폐기">폐기</option>
						</select>
					</div>
					
					<div class="form-group">
                            <label>분야</label>
					<form:form method="post" modelAttribute="EquipManageVO">
                            <form:select path="field" class="form-control">
                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                            </form:select>
                    </form:form>
                    </div>
					
					<div class="form-group">
						<label>신청장비이름</label> <input type="text" name="equipment_name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>제조사</label> <input type="text" name="manufacturer"
							class="form-control" />
					</div>

					<div class="form-group">
						<label>개수</label> <input type="text" name="count"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>가격</label> <input type="text" name="cost"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>총 가격</label> <input type="text" name="total"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>유지보수이유</label><br>
						<textarea id="comment" name="repair_reason" rows="5" cols="100"
							placeholder="입력하세요."></textarea>
					</div>

<!-- 					<div class="form-group"> -->
<!-- 						<label>첨부파일</label> <input type="file" name="file" -->
<!-- 							class="form-control" /> -->
<!-- 					</div> -->

					<button type="button" class="btn btn-primary" id="submitButt">등록</button>
<!-- 					<input type="submit" class="btn btn-primary" id="submitButt" value="등록"/> -->


		</div>
</form>



</div>


<script>
    $(document).ready(function() {
        $('#submitButt').on('click', function() {
            $.ajax({
                url: '/maintenance/regist',
                type: 'POST',
                data: $('#registForm').serialize(),
                success: function(response) {
                    //$('#result').html(response);
                    alert("등록성공!");
                    window.location.href = '/maintenance/list';
           
                },
                error: function(xhr, status, error) {
                    alert('데이터 전송에 실패했습니다: ' + error);
                }
            });
        });
    });
</script>





<%@ include file="../include/footer.jsp"%>
