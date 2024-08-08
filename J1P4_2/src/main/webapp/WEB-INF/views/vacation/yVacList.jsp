<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/empMenu.jsp"%>

 <div class="content-wrapper p-3" style="min-height: 831px;">
 
		<table id="example1"
			class="table table-bordered table-hover"
			style="background: #fff"
			aria-describedby="example1_info">
			<thead>
				<tr>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">사번</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">이름</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Rendering engine: activate to sort column ascending">직무</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">직급</th>
				
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 종류</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 시작일</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 종료일</th>
					<th class="sorting" tabindex="0" aria-controls="example1"
						rowspan="1" colspan="1"
						aria-label="Browser: activate to sort column ascending">휴가 사유</th>
					

				</tr>
			</thead>



			<tbody>
			<c:forEach var="list" items="${yList}">
            <c:forEach var="vList" items="${list.vacationList}">
                <tr class="odd">
                    <td class="dtr-control" tabindex="0">${list.user_no }</td>
                    <td>${list.name}</td>
                    <td>${list.job}</td>
                    <td>${list.job_rank}</td>
                    <td>${vList.vacation_status }</td>
                    <td>${vList.vacation_start }</td>
                    <td>${vList.vacation_end }</td>
                    <td>${vList.vacation_reason }</td>
                </tr>
            </c:forEach>
        </c:forEach>
			</tbody>

		</table>
		<div class="d-flex justify-content-between p-1" >
		<div></div>
		<div>
		<ul class="pagination" >
							<c:if test="${pageVO.prev }">
								<li class="paginate_button page-item previous"
									id="example1_previous">
									<!-- 검색을 하지 않았을 때 페이징 처리 -->
										<a
											href="/vacation/yVacList?page=${pageVO.startPage-1 }"
											aria-controls="example1" data-dt-idx="0" tabindex="0"
											class="page-link">«</a>
								</li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }"
								end="${pageVO.endPage }" step="1">
								<li
									class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }">
										<a href="/vacation/yVacList?page=${i }"
											aria-controls="example1" data-dt-idx="1" tabindex="0"
											class="page-link">${i }</a>
								</li>
							</c:forEach>
							<c:if test="${pageVO.next && pageVO.endPage > 0 }">
								<li class="paginate_button page-item next" id="example1_next">
									<!-- 검색을 하지 않았을 때 페이징 처리 -->
										<a
											href="/vacation/yVacList?page=${pageVO.endPage+1 }"
											aria-controls="example1" data-dt-idx="7" tabindex="0"
											class="page-link">»</a>
								</li>
							</c:if>
						</ul> 
		</div>
		</div>
 
 
 </div>
 
  <%@ include file="../include/footer.jsp"%>