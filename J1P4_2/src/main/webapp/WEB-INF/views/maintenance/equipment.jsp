<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/equipMenu.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<div class="content-wrapper" style="min-height: 831px;">

<h1>승인된 장비 내역 페이지- equipment</h1>
<%-- ${eList } --%>

<!-- 	<button class="btn btn-primary" type="button" -->
<!-- 		data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" -->
<!-- 		aria-controls="offcanvasRight">버튼</button> -->

	
	<div class="col-sm-12">
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">장비번호</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">분야</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">장비보수유형</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">장비이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">제조사</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">가격</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">수량</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">담당자</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">날짜</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="eList" items="${eList }">
					<tr class="odd">
						<td class="dtr-control" tabindex="0">${eList.equipment_no}</td>
						<td>${eList.field}</td>
						<td>
						<c:if test="${eList.e_repair_type eq '수리중'}">
							<div class="dropdown" id="commute-div">
							<button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="width:100px;">
							수리중
  							</button>
  							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
						    <li><a class="dropdown-item" id="repairButt">정상 됐습니다.</a></li>
						  </ul>
						</div>
						</c:if>
						<c:if test="${eList.e_repair_type eq '정상' || '폐기'}">
						${eList.e_repair_type}
						</c:if>
						</td>
						<td><a
							href="/maintenance/equipdetail?equipment_no=${eList.equipment_no}">${eList.equipment_name }</a></td>
						<td>${eList.manufacturer }</td>
						<td>${eList.cost }</td>
						<td>${eList.count }</td>
						<td>${eList.name }</td>
						<td>${eList.approval_date }</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

</div>

<script type="text/javascript">

$(document).ready(function(){
	
	$(document).on("click","#repairButt",function(){
		 var type = $('#repairButt').val();
		//alert('asd')
		Swal.fire({
			   title: '수리가 끝났습니다.',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: true, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   var token = $("meta[name='_csrf']").attr("content");
			       var header = $("meta[name='_csrf_header']").attr("content");
				   $.ajax({
					   url:"/maintenance/equipdetail2",
					   type:"POST",
					   data: {"equipment_no":"${resultVO.equipment_no }",
						   	  e_repair_type:type,
						   },
					   beforeSend: function(xhr) { //header.jsp에 있는 토큰때문에 써주는 것
				                xhr.setRequestHeader(header, token);
				            },   
						   
					   success:function(){
						   history.go(0)
					   },
					   error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				       }
				   })
			   
			   }
			});
	
	
	});
});


</script>



<%@ include file="../include/footer.jsp"%>