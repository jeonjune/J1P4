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
						<option value="searchName">수신번호</option>
						<option value="searchPhoneNum">전송내용</option>
						<option value="searchEmail">담당자</option>
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
				<c:if test="${not empty param.filter }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="filter" value="${param.filter }">${param.filter }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter2" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.memYear }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="memYear" value="${param.memYear }">${param.memYear }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter3" style="display: inline-block;">
			<div class="deleteFilter">
				<c:if test="${not empty param.mem_gender }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="mem_gender"
							value="${param.mem_gender }"> <c:if
								test="${param.mem_gender == 0}">남자</c:if> <c:if
								test="${param.mem_gender == 1}">여자</c:if>
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		
		<div class="filter4" style="display: inline-block;">
			<c:if test="${not empty param.msg_opt }">
				<div class="border border-1 rounded-3 p-2" role="group"
					style="width: 120px; margin-bottom: 20px; background-color: #fff;">
					<button class="removeFi btn-close" aria-label="Close"
						style="width: 1px; position: absolute;"></button>
					<input type="hidden" value="chk" name="msg_opt"> <span
						style="padding-left: 20px; font-size: 18px; font-weight: bold;">
						<c:if test="${not empty param.msg_opt}">메시지만 동의</c:if>
					</span>
				</div>
			</c:if>
		</div>
		</div>

		<!-- 테이블 커스텀 (정렬 / 행 개수) -->
		<div class="content memListSort">
		
			<div>검색결과 : ${pageVO.totalCount }건</div>

			
			<!-- 행 개수 선택 -->
			<div class="textRight">
				<select name="pageSize" id="selectPage" class="form-control">
					<option value="10">10개씩 보기</option>
					<option value="20">50개씩 보기</option>
					<option value="30">100개씩 보기</option>
				</select>
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

					<h5>전송유형</h5>
					<div class="content">
						<input type="radio" value="신규회원" class="btn-check" name="filter"
							id="radioRank1"> <label
							class="btn btn-outline-dark radioField" for="radioRank1">일반전송</label>
						<input type="radio" value="일반회원" class="btn-check" name="filter"
							id="radioRank2"> <label
							class="btn btn-outline-dark radioField" for="radioRank2">예약전송</label>
					</div>
					<hr>
					<h5>연도별</h5>
					<input type="month" id="monthInput">년

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
                       <c:choose>
                            <c:when test="${not empty sms.recipient_more}">
                                <span class="recipient">
                                    ${sms.recipient_mem}
                                    <span class="more-content">${sms.recipient_more}</span>
                                    <span class="show-more" data-recipient-count="${sms.recipient_count}">...외 ${sms.recipient_count}명</span>
                                </span>
                            </c:when>
                            <c:otherwise>
                                ${sms.recipient_mem}
                            </c:otherwise>
                        </c:choose>
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
			<!-- 페이징 처리 -->
			<ul class="pagination" >
			
				<c:if test="${pageVO.prev }">
					<li class="paginate_button page-item previous"
						id="example1_previous">
							<a
								href="/member/message?page=${pageVO.startPage-1 }"
								aria-controls="example1" data-dt-idx="0" tabindex="0"
								class="page-link">«</a>
					</li>
				</c:if>
				
				<c:forEach var="i" begin="${pageVO.startPage }"
					end="${pageVO.endPage }" step="1">
					<li
						class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }">
							<a href="/member/message?page=${i }"
								aria-controls="example1" data-dt-idx="1" tabindex="0"
								class="page-link">${i }</a>
					</li>
				</c:forEach>
				<c:if test="${pageVO.next && pageVO.endPage > 0 }">
					<li class="paginate_button page-item next" id="example1_next">
							<a
								href="/member/message?page=${pageVO.endPage+1 }"
								aria-controls="example1" data-dt-idx="7" tabindex="0"
								class="page-link">»</a>
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

</script>
<%@ include file="../include/footer.jsp"%>