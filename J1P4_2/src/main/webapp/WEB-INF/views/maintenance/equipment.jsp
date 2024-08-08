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

<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->
	<form action="" method="get" class='actionForm'>
	<input type="hidden" value="승인" name="status">
		<div class="form-inline">
		
			<!-- 검색 -->
			<div class="input-group mb-3">
			
				<!-- 검색 타입 선택 -->
				<div class="input-group-prepend">
					<select name="searchType" id="selectType" class="form-control">
						<option value="searchAll" selected="selected">전체</option>
						<option value="searchName">장비이름</option>
						<option value="searchCompany">제조사</option>
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
				<c:if test="${not empty param.field }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="field" value="${param.field }">${param.field }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter2" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.e_repair_type }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="e_repair_type" value="${param.e_repair_type }">${param.e_repair_type }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
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

					<h5>분야별</h5>
					<div class="content">
						<select class="form-control" name="field">
							<option selected disabled>=== 선택 ===</option>
							<option value="AEROBICS">에어로빅</option>
							<option value="BADMINTON">배드민턴</option>
							<option value="FITNESS">피트니스</option>
							<option value="PILATES">필라테스</option>
							<option value="SWIMMING">수영</option>
							<option value="TABLETENNIS">탁구</option>
							<option value="VOLLEYBALL">배구</option>
							<option value="YOGA">요가</option>
						</select>
					</div>
					<hr>
					<h5>장비보수유형별</h5>
					<div class="content">
						<input type="radio" value="정상" class="btn-check" name="e_repair_type"
							id="radioRepair1"> <label
							class="btn btn-outline-dark radioField" for="radioRepair1">정상</label>
						<input type="radio" value="수리중" class="btn-check" name="e_repair_type"
							id="radioRepair2"> <label
							class="btn btn-outline-dark radioField" for="radioRepair2">수리중</label>
						<input type="radio" value="폐기" class="btn-check" name="e_repair_type"
							id="radioRepair3"> <label
							class="btn btn-outline-dark radioField" for="radioRepair3">폐기</label>
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
						    <li><a class="dropdown-item" id="repairButt" >수리완료
								<input type="hidden" id="eqno" value="${eList.equipment_no }">
						    	</a>
						    </li>
						  </ul>
						</div>
						</c:if>
						<c:if test="${eList.e_repair_type eq '정상'or eList.e_repair_type eq '폐기'}">
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

	<!-- 페이징 처리 -->
			<ul class="pagination" >
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword}">
							<a
								href="/maintenance/equipment?page=${pageVO.startPage-1 }"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword}">
							<a
								href="/maintenance/equipment?status=승인&searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&field=${pageVO.cri.field }&e_repair_type=${pageVO.cri.e_repair_type }&page=${pageVO.startPage-1 }"
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
							test="${empty param.keyword}">
							<a href="/maintenance/equipment?page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword}">
							<a
								href="/maintenance/equipment?status=승인&searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&field=${pageVO.cri.field }&e_repair_type=${pageVO.cri.e_repair_type }&page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if>
					</li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.keyword}">
							<a
								href="/maintenance/equipment?page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.keyword}">
							<a
								href="/maintenance/equipment?status=승인&searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }&field=${pageVO.cri.field }&e_repair_type=${pageVO.cri.e_repair_type }&page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if>
					</li>
				</c:if>
			</ul>

</div>

<script type="text/javascript">

$(document).ready(function(){
	
	$(document).on("click","#repairButt",function(){
		 var type = $('#eqno').val();
		alert(type);
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
					   data: {"equipment_no": type
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

/* 사용자가 선택한 필터 출력 */
$(function() {
	$('.filterBtn')
			.click(
					function() {

						let field = $('select[name="field"]').val();
						let e_repair_type = $('input[name=e_repair_type]:checked').val();

						/* 분야별 필터를 선택했을 때 */
						if (field != undefined) {
							$('.filter1')
									.html(
											'<div class="deleteFilter"><h5><span class="badge badge-warning p-2" style="color: #000;">'
													+ '<input type="hidden" name="field" value="'+field+'">'
													+ field
													+ '<button class="removeFi btn-close btn-xs" aria-label="Close" style="margin-left: 7px;">'
													+ '</button></span></h5></div>');
						}

						/* 유지보수유형을 선택했을 때 */
						if (e_repair_type != undefined) {
							$('.filter2')
									.html(
											'<div class="deleteFilter"><h5><span class="badge badge-warning p-2" style="color: #000;">'
													+ '<input type="hidden" name="e_repair_type" value="'+e_repair_type+'">'
													+ e_repair_type
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



</script>



<%@ include file="../include/footer.jsp"%>