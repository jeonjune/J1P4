<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidemenu.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class List</title>
    
    <style>
    #viewScheduleModal .modal-dialog {
        z-index: 1050; /* Bootstrap 모달 기본 z-index */
    }
    #scheduleModal .modal-dialog {
        z-index: 1060; /* viewScheduleModal 보다 높은 z-index 설정 */
    }
    </style>
    
</head>
<body>
    <div class="wrapper">
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Class List</h1>
                        </div>
                    </div>
                </div>
            </section>
            
            <form action="" method="get" class='actionForm'>

		<div class="form-inline">
		
			<!-- 검색 -->
			<div class="input-group mb-3">
			
				<!-- 검색 타입 선택 -->
				<div class="input-group-prepend">
					<select name="searchType" id="selectType" class="form-control">
						<option value="searchAll" selected="selected">전체</option>
						<option value="searchClass">강의명</option>
						<option value="searchInstructor">강사이름</option>
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
				<c:if test="${not empty param.division }">
					<h5>
						<span class="badge badge-warning p-2" style="color: #000;">
							<input type="hidden" name="division" value="${param.division }">${param.division }
							<button class="removeFi btn-close btn-xs" aria-label="Close"
								style="margin-left: 7px;"></button>
						</span>
					</h5>
				</c:if>
			</div>
		</div>
		</div>

		<!-- 테이블 커스텀 (정렬 / 행 개수) -->
		<div class="content memListSort">
		
			<div>검색결과 : ${pageVO.totalCount }명</div>
			
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

					<h5>분야코드</h5>
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
					<h5>구분코드</h5>
					<div class="content">
						<select class="form-control" name="division">
							<option selected disabled>=== 선택 ===</option>
							<option value="ADULT">ADULT</option>
							<option value="CHILD">CHILD</option>
							<option value="HOBBY">HOBBY</option>
							<option value="WORK">WORK</option>
						</select>
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

            <section class="content">
                <div class="container-fluid">
                    <table class="table table-bordered" style="background: #fff">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()" ></th>
					            <th>강의번호</th>
					            <th>강의명</th>
					            <th>설명</th>
					            <th>분야</th>
					            <th>구분</th>
					            <th>수준</th>
					            <th>최소 / 최대 (인원)</th>
					            <th>강사</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="classItem" items="${classList}">
                                <tr>
                                    <td><input type="checkbox" class="selectCheckbox" value="${classItem.classNo}"></td>
					                <td>${classItem.classNo}</td>
					                <td><a href="${pageContext.request.contextPath}/classes/detail/${classItem.classNo}">${classItem.className}</a></td>
					                <td>${classItem.description}</td>
					                <td>${classItem.fieldCode}</td>
					                <td>${classItem.divisionCode}</td>
					                <td>${classItem.levelCode}</td>
					                <td>${classItem.minCapacity} / ${classItem.maxCapacity}</td>
					                <td>${classItem.instructorName}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="col-sm-12">
					<div class="d-flex justify-content-between align-items-center">
	                    <div>
	                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#classModal" onclick="openModal()">등록</button>
	                        <button type="button" class="btn btn-danger" onclick="deleteSelectedClasses()">삭제</button>
	                    </div>
	                    <ul class="pagination" >
							<c:if test="${pageVO.prev }">
								<li class="paginate_button page-item previous"
									id="example1_previous">
									<!-- 검색을 하지 않았을 때 페이징 처리 -->
									<c:if test="${empty param.searchType }">
										<a
											href="/classes/list/?page=${pageVO.startPage-1 }"
											aria-controls="example1" data-dt-idx="0" tabindex="0"
											class="page-link">«</a>
									</c:if> <!-- 검색을 했을 때 페이징 처리 --> 
									<c:if test="${not empty param.searchType }">
										<a
											href="/classes/list/?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }
											&field=${pageVO.cri.field }&division=${pageVO.cri.division }&page=${pageVO.startPage-1 }"
											aria-controls="example1" data-dt-idx="0" tabindex="0"
											class="page-link">«</a>
									</c:if>
								</li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }"
								end="${pageVO.endPage }" step="1">
								<li
									class="paginate_button page-item ${pageVO.cri.page == i ? 'active':'' }">
									<!-- 검색을 하지 않았을 때 페이징 처리 --> 
									<c:if test="${empty param.searchType }">
										<a href="/classes/list/?page=${i }"
											aria-controls="example1" data-dt-idx="1" tabindex="0"
											class="page-link">${i }</a>
									</c:if> 
									<c:if test="${not empty param.searchType }">
										<a
											href="/classes/list/?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }
											&field=${pageVO.cri.field }&division=${pageVO.cri.division }&page=${i }"
											aria-controls="example1" data-dt-idx="1" tabindex="0"
											class="page-link">${i }</a>
									</c:if>
								</li>
							</c:forEach>
							<c:if test="${pageVO.next && pageVO.endPage > 0 }">
								<li class="paginate_button page-item next" id="example1_next">
									<!-- 검색을 하지 않았을 때 페이징 처리 -->
									<c:if test="${empty param.searchType }">
										<a
											href="/classes/list/?page=${pageVO.endPage+1 }"
											aria-controls="example1" data-dt-idx="7" tabindex="0"
											class="page-link">»</a>
									</c:if> <!-- 검색을 했을 때 페이징 처리 -->
									<c:if test="${not empty param.searchType }">
										<a
											href="/classes/list/?searchType=${pageVO.cri.searchType }&keyword=${pageVO.cri.keyword }
											&field=${pageVO.cri.field }&division=${pageVO.cri.division }&page=${pageVO.endPage+1 }"
											aria-controls="example1" data-dt-idx="7" tabindex="0"
											class="page-link">»</a>
									</c:if>
								</li>
							</c:if>
						</ul>
                    </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- 강의 모달 -->
        <div class="modal fade" id="classModal" tabindex="-1" aria-labelledby="classModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="classModalLabel">Add/Edit Class</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <!-- classList.jsp의 Class Modal에 추가 -->
					<div class="modal-body">
					    <form:form id="classForm" method="post" action="${pageContext.request.contextPath}/classes/save" modelAttribute="classVO">
					        <form:hidden path="classNo" />
					        <div class="mb-3">
					            <label for="className" class="form-label">강의명</label>
					            <form:input path="className" class="form-control" required="required" id="className"/>
					        </div>
					        <div class="mb-3">
					            <label for="description" class="form-label">설명</label>
					            <form:textarea path="description" class="form-control" id="description"/>
					        </div>
					        <div class="mb-3">
					            <label for="fieldCode" class="form-label">분야</label>
					            <form:select path="fieldCode" class="form-control" id="fieldCode">
					                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
					            </form:select>
					        </div>
					        <div class="mb-3">
					            <label for="divisionCode" class="form-label">구분</label>
					            <form:select path="divisionCode" class="form-control" id="divisionCode">
					                <form:options items="${divisions}" itemValue="codeValue" itemLabel="codeValueName"/>
					            </form:select>
					        </div>
					        <div class="mb-3">
					            <label for="levelCode" class="form-label">수준</label>
					            <form:select path="levelCode" class="form-control" id="levelCode">
					                <form:options items="${levels}" itemValue="codeValue" itemLabel="codeValueName"/>
					            </form:select>
					        </div>
					        <div class="mb-3">
					            <label for="minCapacity" class="form-label">최소인원</label>
					            <form:input path="minCapacity" class="form-control" type="number" required="required" id="minCapacity"/>
					        </div>
					        <div class="mb-3">
					            <label for="maxCapacity" class="form-label">최대인원</label>
					            <form:input path="maxCapacity" class="form-control" type="number" required="required" id="maxCapacity"/>
					        </div>
					        <div class="mb-3">
					            <label for="instructorName" class="form-label">강사명</label>
					            <div class="input-group">
					                <form:input path="instructorName" class="form-control" id="instructorName" readonly="readonly"/>
					                <form:hidden path="instructorNo" id="instructorNo"/>
					                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#instructorModal">강사 찾기</button>
					            </div>
					        </div>
					        <button type="submit" class="btn btn-primary">저장</button>
					    </form:form>
					</div>
                </div>
            </div>
        </div>

                <!-- 강사찾기 모달 -->
        <div class="modal fade" id="instructorModal" tabindex="-1" aria-labelledby="instructorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg"> <!-- modal-lg 클래스로 크기 조정 -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="instructorModalLabel">강사 찾기</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="instructorSearch" class="form-label">이름을 입력해주세요.</label>
                            <input type="text" class="form-control" id="instructorSearch" placeholder="Enter instructor name">
                        </div>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>강사번호</th>
                                    <th>이름</th>
                                    <th>전문분야</th>
                                </tr>
                            </thead>
                            <tbody id="instructorTableBody">
                                <!-- 강사 검색 시 동적으로 생성된 강사 목록을 표시하기 위함.(서버에서 데이터를 받아 이곳에 삽입) -->
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-primary" id="selectInstructorButton">선택</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
    const csrfToken = $('meta[name="_csrf"]').attr('content');
    const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    $(document).ready(function() {
        $('#classForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: '${pageContext.request.contextPath}/classes/save',
                method: 'POST',
                data: $(this).serialize(),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while saving the class.');
                }
            });
        });

        $('#instructorSearch').on('input', function() {
            const query = $(this).val();
            if (query.length > 0) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/instructors/search',
                    method: 'GET',
                    data: { query: query },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(data) {
                        const instructorTableBody = $('#instructorTableBody');
                        instructorTableBody.empty();
                        data.forEach(function(instructor) {
                            const row = '<tr>' +
                                        '<td><input type="checkbox" name="instructorCheckbox" value="' + instructor.instructorNo + '"></td>' +
                                        '<td>' + instructor.instructorNo + '</td>' +
                                        '<td>' + instructor.name + '</td>' +
                                        '<td>' + instructor.expertise + '</td>' +
                                     '</tr>';
                            instructorTableBody.append(row);
                        });
                    },
                    error: function(error) {
                        alert('Error occurred while searching for instructors.');
                    }
                });
            }
        });
        
        $('#selectInstructorButton').on('click', function(event) {
            event.preventDefault();
            const selectedInstructor = $('input[name="instructorCheckbox"]:checked').val();
            const selectedInstructorName = $('input[name="instructorCheckbox"]:checked').closest('tr').find('td:nth-child(3)').text();

            if (!selectedInstructor) {
                alert('Please select an instructor.');
                return;
            }

            $('#instructorNo').val(selectedInstructor);
            $('#instructorName').val(selectedInstructorName);
            $('#instructorModal').modal('hide');
        });

        $('#studentSearch').on('input', function() {
            const query = $(this).val();
            if (query.length > 0) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/students/search',
                    method: 'GET',
                    data: { query: query },
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(data) {
                        const studentTableBody = $('#studentTableBody');
                        studentTableBody.empty();
                        data.forEach(function(student) {
                            const row = '<tr>' +
                                        '<td><input type="checkbox" name="studentCheckbox" value="' + student.mem_no + '"></td>' +
                                        '<td>' + student.mem_no + '</td>' +
                                        '<td>' + student.mem_name + '</td>' +
                                        '<td>' + student.mem_phone + '</td>' +
                                        '<td>' + student.mem_addr1 + ' ' + student.mem_addr2 + '</td>' +
                                     '</tr>';
                            studentTableBody.append(row);
                        });
                    },
                    error: function(error) {
                        alert('Error occurred while searching for students.');
                    }
                });
            }
        });

        $('#registerSelectedStudents').on('click', function(event) {
            event.preventDefault();
            const selectedSchedules = [];
            $('input[name="scheduleCheckbox"]:checked').each(function() {
                selectedSchedules.push($(this).val());
            });

            if (selectedSchedules.length === 0) {
                alert('Please select at least one schedule.');
                return;
            }

            const selectedStudents = [];
            $('input[name="studentCheckbox"]:checked').each(function() {
                selectedStudents.push($(this).val());
            });

            if (selectedStudents.length === 0) {
                alert('Please select at least one student.');
                return;
            }

            const registrationData = selectedStudents.map(studentNo => ({
                mem_no: studentNo,
                schedule_no: selectedSchedules[0] // Assuming registering one schedule at a time
            }));

            $.ajax({
                url: '${pageContext.request.contextPath}/students/register',
                method: 'POST',
                data: JSON.stringify(registrationData),
                contentType: 'application/json',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    $('#addStudentModal').modal('hide');
                    alert('Student(s) registered successfully.');
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while registering student(s).');
                }
            });
        });
    });

    function openModal() {
        $('#classForm')[0].reset();
        $('#classModalLabel').text('Add Class');
        $('#classNo').val(0); // Set classNo to 0 for new entries
        $('#classModal').modal('show');
    }

    function toggleSelectAll() {
        const selectAll = $('#selectAll').is(':checked');
        $('.selectCheckbox').prop('checked', selectAll);
    }

    function selectInstructor(instructorNo, instructorName) {
        $('#instructorNo').val(instructorNo);
        $('#instructorName').val(instructorName);
        $('#instructorModal').modal('hide');
    }

    function deleteSelectedClasses() {
        const selected = [];
        $('.selectCheckbox:checked').each(function() {
            selected.push($(this).val());
        });

        if (selected.length === 0) {
            alert('Please select at least one class to delete.');
            return;
        }

        if (confirm('Are you sure you want to delete the selected classes?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/classes/delete',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(selected),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while deleting classes.');
                }
            });
        }
    }
    
    /* 사용자가 선택한 필터 출력 */
    $(function() {
    	$('.filterBtn')
    			.click(
    					function() {

    						let field = $('select[name="field"]').val();
    						let division = $('select[name="division"]').val();

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
    						if (division != undefined) {
    							$('.filter2')
    									.html(
    											'<div class="deleteFilter"><h5><span class="badge badge-warning p-2" style="color: #000;">'
    													+ '<input type="hidden" name="division" value="'+division+'">'
    													+ division
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


</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
