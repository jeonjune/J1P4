<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<div class="content-wrapper" style="min-height: 831px;">


<h1>empList </h1>
	

		
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
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="emp" items="${empList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${emp.user_id }</td>
						<td class=""><a
							href="#">${emp.name }</a></td>
						<td>${emp.job }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>


<form action="" method="post" id="fm1">
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
                  
<!--                         <div class="form-group"> -->
<!--                             <label>시설번호</label> -->
<%--                             <input type="text" name="facility_no" value="${vo.facility_no}" class="form-control" required /> --%>
<!--                         </div> -->
                        
                        <div class="form-group">
                            <label>아이디</label>
                            <input type="text" name="user_id" class="form-control">
                        </div>
                        
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" name="name"  class="form-control" >
                        </div>

                        <div class="form-group">
                            <label>비밀번호</label>
                            <input type="text" name="user_pw" class="form-control">
                        </div>
                       
                        <div class="form-group">
                            <label>직무</label>
                            <input type="text" name="job" class="form-control">
                        </div>
                     
                        <div class="form-group">
                            <label>직급</label>
                            <input type="text" name="job_rank" class="form-control">
                        </div>
                      <!-- user_id,user_pw,job_rank,job,name,birth_date,gender,phone_no,email,zip_code,addr1,addr2 -->
                      
<!--                         <div class="form-group"> -->
<!--                             <label>생일(임시 날짜형식으로 넣을 것)</label> -->
<!--                             <input type="text" name="birth_date"  class="form-control" > -->
<!--                         </div> -->
                      
                        <div class="form-group">
                            <label>성별(임시 0,1)</label>
                            <input type="text" name="gender"  class="form-control" >
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
                            <label>주소 우편번호(임시 숫자)</label>
                            <input type="text" name="zip_code"  class="form-control" >
                        </div>
                        <div class="form-group">
                            <label>주소1(임시)</label>
                            <input type="text" name="addr1"  class="form-control" >
                        </div>
                        <div class="form-group">
                            <label>주소2(임시)</label>
                            <input type="text" name="addr2"  class="form-control" >
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
			url : "/employee/emp",
			type : "POST",
			data : $("#fm1").serialize(),
			success : function(data) {
				alert("시설이 등록 되었습니다.");
//					console.log(data);
				
				history.go(0);
//					$.each(data,function(){
					
//						$("#facility_name").value(data.ddd.ddd);
					
//					});
				
			},
			error : function() {
				alert("오류발생");
			}
		});
	});
});

</script>


<%@ include file="../include/footer.jsp"%>