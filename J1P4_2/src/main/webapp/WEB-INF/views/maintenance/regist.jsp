<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%-- <%@ include file="../include/equipMenu.jsp"%> --%>


<div class="content-wrapper" style="min-height: 831px;">


<h1>장비신청페이지 - regist</h1>

	<div class="offcanvas-body">

			<section class="content">
				<div class="container-fluid">
					
					<div class="form-group">
						<label>담당자</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>작성날짜</label> <input type="date" name="repair_date"
							class="form-control" />
					</div>
					
					
					<div class="form-group">
						<label> 장비신청유형 </label> <select id="select_type"
							name="repair_type" size="1">
							<option>선택하세요.</option>
							<option value="구입">구입</option>
							<option value="수리">수리</option>
							<option value="폐기">폐기</option>
						</select>
					</div>
					
					<div class="form-group">
						<label>분야</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>신청장비이름</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>제조사</label> <input type="text" name="name"
							class="form-control" />
					</div>

					<div class="form-group">
						<label>개수</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>가격</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>총 가격</label> <input type="text" name="name"
							class="form-control" />
					</div>
					
					<div class="form-group">
						<label>유지보수이유</label><br>
						<textarea id="comment" name="repair_status" rows="5" cols="100"
							placeholder="입력하세요."></textarea>
					</div>

					<div class="form-group">
						<label>첨부파일</label> <input type="text" name="name"
							class="form-control" />
					</div>

					<button type="button" class="btn btn-primary" id="submitButt">등록</button>

				</div>
			</section>

		</div>










</div>



<%@ include file="../include/footer.jsp"%>




