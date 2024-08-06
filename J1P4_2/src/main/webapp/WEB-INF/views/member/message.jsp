<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<style>
        .more-content {
            display: none;
        }
        .show-more {
            color: #cdb4db;
            cursor: pointer;
        }
    </style>
<!-- 바디 시작 -->
<div class="content-wrapper" style="min-height: 831px; padding-top:20px;">

	<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->
	<form action="" method="get" class='actionForm'>

		<div class="form-inline">
		
			<!-- 검색 -->
			<div class="input-group mb-3">
			
				<!-- 검색 타입 선택 -->
				<div class="input-group-prepend">
					<select name="searchType" id="selectType" class="form-control">
						<option value="searchAll" selected="selected">전체</option>
						<option value="searchPhoneNum">수신번호</option>
						<option value="searchContent">전송내용</option>
						<option value="searchManager">담당자</option>
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
		<div class="content">
						<input type="radio" value="전체" class="btn-check btn-check-all" 
							id="radioMSGtype0"> <label
							class="btn btn-outline-dark radioField" for="radioMSGtype0">전체</label>
						<input type="radio" value="예약전송" class="btn-check btn-check-type" name="filter"
							id="radioMSGtype1"> <label
							class="btn btn-outline-dark radioField" for="radioMSGtype1">예약전송</label>
						<input type="radio" value="일반전송" class="btn-check btn-check-type" name="filter"
							id="radioMSGtype2"> <label
							class="btn btn-outline-dark radioField" for="radioMSGtype2">일반전송</label>
					</div>
	</form>
	<!-- 검색 / 필터 / 정렬 / 행 개수 데이터 전송 -->
	

<table id="example1" class="table table-bordered table-hover"
			style="background: #fff; height: 100px;" aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" style="width: 20px;">NO</th>
					<th class="sorting" style="width: 30px;">담당자</th>
					<th class="sorting" style="width: 100px;">전송유형</th>
					<th class="sorting" style="width: 400px;">전송내용</th>
					<th class="sorting" style="width: 150px;">수신번호</th>
					<th class="sorting" style="width: 150px;">전송날짜</th>
				</tr>
			</thead>
			<tbody class="test">
				<c:forEach var="sms" items="${SMS }">
					<tr class="tr:hover">
						<td>${sms.noti_no }</td>
						<td>${sms.sender_user }</td>
						<td>${sms.noti_type }</td>
						<td>${sms.message }</td>
						<td>
						<input type="hidden" id="noti_no" value="${sms.noti_no }">
                     	<button type="button" class="btn btn-warning" onclick="showMemPhone(${sms.noti_no })">수신 번호 확인</button>
                    </td>
						<td>${sms.noti_date }</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		<div class="col-sm-12">
		<div class="d-flex justify-content-between align-items-center">
		
	<!-- 하단 버튼 모음 -->	
	<div>
		<!-- 메시지 전송 버튼 -->
		<button type="button" class="btn btn-danger smsBtn" data-bs-toggle="modal"
			data-bs-target="#smsModal">
			<i class="fas fa-envelope fa-fw" style="color: #fff"></i> 메시지 발송
		</button>

	</div>
	
	<!-- 반려사유 가져오는 모달창 시작 -->
   <div class="modal fade" id="phoneModal" tabindex="-1"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">

            <!-- 모달창 헤더 -->
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">반려사유</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal"
                  aria-label="Close"></button>
            </div>

            <!-- 모달창 바디(본문) -->
            <div class="modal-body">
			   
			   <h5>담당자</h5> <!-- 로그인한 팀장 이름 담기 -->
			   	<div class="form-group">
<!-- 					<input type="text" name="name"  -->
<%-- 					class="form-control" value="${resultVO.name}" readonly="readonly"/> --%>
				<p id="rejectNameText"></p>
				</div>
               
               <h5>반려사유</h5>
               <div class="content">
                  <div class="form-group">
						 <p id="rejectReasonText"></p>
					</div>
                 
               </div>
             
               <hr>

            </div>

            <!-- 모달창 푸터 -->
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary"
                  data-bs-dismiss="modal">취소</button>
               <button type="button" class="btn btn-primary filterBtn"
                  data-bs-dismiss="modal" id="rejectBtt">확인</button>
            </div>

         </div>
      </div>
   </div>
   <!-- 모달창 끝 -->
			<!-- 페이징 처리 -->
			<ul class="pagination" >
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.searchType}">
							<a
								href="/member/message?page=${pageVO.startPage-1 }"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.searchType}">
							<a
								href="/member/message?searchType=${param.searchType }&keyword=${pageVO.cri.keyword }&filter=${pageVO.cri.filter }&page=${pageVO.startPage-1 }"
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
							test="${empty param.searchType}">
							<a href="/member/message?page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.searchType}">
							<a
								href="/member/message?searchType=${param.searchType }&keyword=${pageVO.cri.keyword }&filter=${pageVO.cri.filter }&page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
						</c:if>
					</li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next">
						<!-- 검색을 하지 않았을 때 페이징 처리 --> <c:if
							test="${empty param.searchType}">
							<a
								href="/member/message?page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if> <!-- 검색을 했을 때 페이징 처리 --> <c:if
							test="${not empty param.searchType}">
							<a
								href="/member/message?searchType=${param.searchType }&keyword=${pageVO.cri.keyword }&filter=${pageVO.cri.filter }&page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
						</c:if>
					</li>
				</c:if>
			</ul>
				
		</div>
	</div>
		
		
</div>

<script>
$(document).ready(function() {
    $('.show-more').on('click', function() {
        var $this = $(this);
        var $moreContent = $this.prev('.more-content');
        var recipientCount = $this.data('recipient-count');

        if ($moreContent.is(':visible')) {
            $moreContent.hide();
            $this.text('...외 ' + recipientCount + '명');
        } else {
            $moreContent.show();
            $this.text('접기');
        }
    });
});

function showMemPhone(noti_no){
	
	$.ajax({
		url: '/member/phoneNum',
        method: 'GET',
        data: {noti_no : noti_no},
        success: function(response) {
            document.getElementById('rejectReasonText').innerText = response.recipient_mem;
            
            $('#phoneModal').modal('show');
        },
        error: function() {
            alert('반려 사유를 가져오는데 실패했습니다.');
        }
	});
}

$(function() {
	$('.btn-check-type')
			.click(
					function() {
						
						$(".actionForm").submit();

					});

});
	
	$(function() {
	$('.btn-check-all')
			.click(
					function() {
						
						window.location.href = '/member/message';

					});

});
	
	$(function() {
 	if ('${param.filter}' == '${pageVO.cri.filter}') {
 		if ('${param.filter}'=='') {
 			$(".btn-check-all").attr('checked', true);
 		}
 		$(":radio[name='filter'][value='${param.filter}']").attr('checked', true);
 	}
	});

</script>
<%@ include file="../include/footer.jsp"%>