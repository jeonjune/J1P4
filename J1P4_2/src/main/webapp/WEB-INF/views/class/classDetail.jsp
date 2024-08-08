<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidemenu.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class Detail</title>
    <style>
        .modal-dialog {
            z-index: 1050; /* Bootstrap 모달 기본 z-index */
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
                            <h1>Class Detail</h1>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <button class="nav-link active" id="nav-class-tab" data-bs-toggle="tab" data-bs-target="#nav-class" type="button" role="tab" aria-controls="nav-class" aria-selected="true">강의</button>
                            <button class="nav-link" id="nav-schedule-tab" data-bs-toggle="tab" data-bs-target="#nav-schedule" type="button" role="tab" aria-controls="nav-schedule" aria-selected="false">일정</button>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-class" role="tabpanel" aria-labelledby="nav-class-tab">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">정보 수정</h3>
                                </div>
                                <div class="card-body">
                                    <form:form id="classForm" method="post" action="${pageContext.request.contextPath}/classes/save" modelAttribute="classVO">
                                        <form:hidden path="classNo" />
                                        <form:hidden path="price" id="classPrice" value="${classVO.price}" />
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
                        <!-- classDetail.jsp -->
                        <div class="tab-pane fade" id="nav-schedule" role="tabpanel" aria-labelledby="nav-schedule-tab">
						    <div class="card">
						        <div class="card-header">
						            <h3 class="card-title">수정 / 등록</h3>
						        </div>
						        <div class="card-body">
					<div class="d-flex justify-content-between align-items-center" style="height: 45px;">
						        <form action="/classes/search" method="get" class='actionForm'>
						        <div style="padding-top: 22px;">
						<input type="radio" value="" class="btn-check btn-check-type" name="status"
							id="radioStatus0" checked> <label
							class="btn btn-outline-dark radioField" for="radioStatus0">전체</label>
						<input type="radio" value="정상" class="btn-check btn-check-type" name="status"
							id="radioStatus1"> <label
							class="btn btn-outline-dark radioField" for="radioStatus1">정상</label>
						<input type="radio" value="종료" class="btn-check btn-check-type" name="status"
							id="radioStatus2"> <label
							class="btn btn-outline-dark radioField" for="radioStatus2">종료</label>
						<input type="radio" value="모집" class="btn-check btn-check-type" name="status"
							id="radioStatus3"> <label
							class="btn btn-outline-dark radioField" for="radioStatus3">모집</label>
						<input type="radio" value="폐강" class="btn-check btn-check-type" name="status"
							id="radioStatus4"> <label
							class="btn btn-outline-dark radioField" for="radioStatus4">폐강</label>
					</div>
					</form>
					<div>
						            <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#scheduleModal" onclick="initScheduleForm()">
						                일정 등록
						            </button>
						            <button type="button" class="btn btn-primary mt-3" onclick="openAddStudentModal()">회원 등록</button>
						            <button type="button" class="btn btn-primary mt-3" onclick="editSelectedSchedules()">수정</button>
						            <button type="button" class="btn btn-danger mt-3" onclick="deleteSelectedSchedules()">삭제</button>
					</div>
						            </div>
						            <table class="table table-bordered mt-3">
						                <thead>
						                    <tr>
						                        <th></th>
						                        <th>시작 날짜</th>
						                        <th>종료 날짜</th>
						                        <th>시작 시간</th>
						                        <th>종료 시간</th>
						                        <th>요일</th>
						                        <th>신청 인원</th>
						                        <th>상태</th>
						                    </tr>
						                </thead>
						                <tbody id="scheduleTableBody">
						                    <c:forEach var="schedule" items="${schedules}">
						                        <tr>
						                            <td><input type="checkbox" name="scheduleCheckbox" value="${schedule.scheduleId}"></td>
						                            <td>${schedule.startDate}</td>
						                            <td>${schedule.endDate}</td>
						                            <td>${schedule.startTimeCode}</td>
						                            <td>${schedule.endTimeCode}</td>
						                            <td>${schedule.recurrenceDays}</td>
						                            <td>${schedule.currentEnrollment}</td>
						                            <td>${schedule.status}</td>
						                        </tr>
						                    </c:forEach>
						                </tbody>
						            </table>
						        </div>
						    </div>
						</div>

                    </div>
                </div>
            </section>
        </div>

		        <!-- 스케줄 모달 -->
		<div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="scheduleModalLabel">일정 등록</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <form:form id="scheduleForm" method="post" action="${pageContext.request.contextPath}/schedules/save" modelAttribute="scheduleVO">
		                    <form:hidden path="scheduleId" />
		                    <form:hidden path="classNo" id="scheduleClassNo" value="${classVO.classNo}"/>
		                    <form:hidden path="status" id="status" />  <!-- 추가된 부분 -->
		                    <div class="mb-3">
		                        <label for="startDate" class="form-label">시작 날짜</label>
		                        <form:input path="startDate" class="form-control" type="date" id="startDate"/>
		                    </div>
		                    <div class="mb-3">
		                        <label for="endDate" class="form-label">종료 날짜</label>
		                        <form:input path="endDate" class="form-control" type="date" id="endDate"/>
		                    </div>
		                    <div class="mb-3">
		                        <label for="startTime" class="form-label">시작 시간</label>
		                        <form:select path="startTimeCode" id="startTime" class="form-control">
		                            <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
		                        </form:select>
		                    </div>
		                    <div class="mb-3">
		                        <label for="endTime" class="form-label">종료 시간</label>
		                        <form:select path="endTimeCode" id="endTime" class="form-control">
		                            <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
		                        </form:select>
		                    </div>
		                    <div class="mb-3">
		                        <label for="recurrenceDays" class="form-label">요일</label>
		                        <form:select path="recurrenceDays" multiple="multiple" class="form-control" id="recurrenceDays">
		                            <option value="월">월요일</option>
		                            <option value="화">화요일</option>
		                            <option value="수">수요일</option>
		                            <option value="목">목요일</option>
		                            <option value="금">금요일</option>
		                            <option value="토">토요일</option>
		                        </form:select>
		                    </div>
		                    <button type="submit" class="btn btn-primary">저장</button>
		                </form:form>
		            </div>
		        </div>
		    </div>
		</div>

                <!-- Instructor Modal -->
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
        
        <!-- Add Student Modal -->
        <div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg"> <!-- modal-lg 클래스로 크기 조정 -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addStudentModalLabel">회원 등록</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="studentSearch" class="form-label">회원검색</label>
                            <input type="text" class="form-control" id="studentSearch" placeholder="Enter student name or phone">
                        </div>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>회원번호</th>
                                    <th>이름</th>
                                    <th>휴대폰 번호</th>
                                    <th>주소</th>
                                </tr>
                            </thead>
                            <tbody id="studentTableBody">
                                <!-- 검색된 학생 목록이 여기에 표시됩니다. -->
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-primary" id="registerStudentsButton">등록</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	const csrfToken = $('meta[name="_csrf"]').attr('content');
	const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
	
    IMP.init('imp41432400'); // 고객사 식별 코드를 입력합니다.

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

        $('#scheduleForm').on('submit', function(event) {
            event.preventDefault();
            const form = $(this);
            $.ajax({
                url: form.attr('action'),
                method: 'POST',
                data: form.serialize(),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    $('#scheduleModal').modal('hide');
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while saving the schedule.');
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

        $('#registerStudentsButton').on('click', function(event) {
            event.preventDefault();
            const selectedStudents = $('input[name="studentCheckbox"]:checked').map(function() {
                return $(this).val();
            }).get();

            if (selectedStudents.length !== 1) {
                alert('회원 등록을 위해 하나의 일정만 선택해야 합니다.');
                return;
            }

            const classPrice = parseInt($('#classPrice').val(), 10);
            const scheduleNo = parseInt($('input[name="scheduleCheckbox"]:checked').val(), 10);
            const studentNo = parseInt(selectedStudents[0], 10);

            IMP.request_pay({
                pg: 'kakaopay',
                pay_method: 'card',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: 'Class Registration',
                amount: classPrice,
                buyer_email: 'buyer@example.com',
                buyer_name: '구매자 이름',
                buyer_tel: '010-1234-5678',
                buyer_addr: '서울특별시 강남구 삼성동',
                buyer_postcode: '123-456'
            }, function (rsp) {
                if (rsp.success) {
                    const paymentInfo = {
                        amount: rsp.paid_amount,
                        paymentStatus: 'Paid',
                        paymentMethod: rsp.pay_method,
                        transactionId: rsp.imp_uid,
                        merchantId: rsp.merchant_uid
                    };

                    const registration = {
                        mem_no: studentNo,
                        schedule_no: scheduleNo,
                        registration_date: new Date().toISOString().split('T')[0] // 날짜 형식 수정
                    };

                    const requestData = {
                        registration: registration,
                        paymentInfo: paymentInfo
                    };

                    console.log("Sending request data: ", requestData); 

                    $.ajax({
                        url: '/students/register',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(requestData),
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(response) {
                            alert('결제가 성공적으로 완료되었습니다.');
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            alert('결제 처리 중 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        });

    });

    function openModal() {
        $('#classForm')[0].reset();
        $('#classModalLabel').text('Add Class');
        $('#classNo').val(0); // 신규 추가 시 classNo를 0으로 설정
        $('#classModal').modal('show');
    }

    function initScheduleForm() {
        $('#scheduleForm')[0].reset();
        $('#scheduleId').val(0);  // 신규 등록 시 scheduleId를 0으로 설정
        $('#scheduleClassNo').val('${classVO.classNo}');
        $('#scheduleModalLabel').text('Add Schedule');
    }

    function editSchedule(scheduleId) {
        $.get('${pageContext.request.contextPath}/schedules/edit/' + scheduleId, function(data) {
            $('#scheduleForm')[0].reset();
            $('#scheduleId').val(data.scheduleId);
            $('#scheduleClassNo').val(data.classNo);
            
            // 서버에서 반환된 날짜에 하루를 더함
            const startDate = new Date(data.startDate);
            startDate.setDate(startDate.getDate() + 1);
            const formattedStartDate = startDate.toISOString().split('T')[0];

            const endDate = new Date(data.endDate);
            endDate.setDate(endDate.getDate() + 1);
            const formattedEndDate = endDate.toISOString().split('T')[0];

            $('#startDate').val(formattedStartDate);
            $('#endDate').val(formattedEndDate);
            $('#startTime').val(data.startTimeCode);
            $('#endTime').val(data.endTimeCode);
            $('#recurrencePattern').val(data.recurrencePattern);
            $('#recurrenceDays').val(data.recurrenceDays);
            $('#status').val(data.status);  
            $('#scheduleModalLabel').text('Edit Schedule');
            $('#scheduleModal').modal('show');
        });
    }


    function deleteSchedule(scheduleId) {
        if (confirm('Are you sure you want to delete this schedule?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/schedules/delete/' + scheduleId,
                method: 'POST',
                data: JSON.stringify({
                    [csrfHeader]: csrfToken
                }),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while deleting schedule.');
                }
            });
        }
    }

    function editSelectedSchedules() {
        const selectedSchedules = [];
        $('input[name="scheduleCheckbox"]:checked').each(function() {
            selectedSchedules.push($(this).val());
        });

        if (selectedSchedules.length === 0) {
            alert('Please select at least one schedule to edit.');
            return;
        }

        if (selectedSchedules.length > 1) {
            alert('Please select only one schedule to edit.');
            return;
        }

        editSchedule(selectedSchedules[0]);
    }

    function deleteSelectedSchedules() {
        const selectedSchedules = [];
        $('input[name="scheduleCheckbox"]:checked').each(function() {
            selectedSchedules.push($(this).val());
        });

        if (selectedSchedules.length === 0) {
            alert('Please select at least one schedule to delete.');
            return;
        }

        if (confirm('Are you sure you want to delete the selected schedules?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/schedules/delete',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(selectedSchedules),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while deleting schedules.');
                }
            });
        }
    }

    function selectInstructor(instructorNo, instructorName) {
        $('#instructorNo').val(instructorNo);
        $('#instructorName').val(instructorName);
        $('#instructorModal').modal('hide');
    }
    
    function openAddStudentModal() {
        const selectedSchedules = [];
        $('input[name="scheduleCheckbox"]:checked').each(function() {
            selectedSchedules.push($(this).val());
        });

        if (selectedSchedules.length !== 1) {
            alert('회원 등록을 위해 하나의 일정만 선택해야 합니다.');
            return false;
        }

        const selectedScheduleStatus = $('input[name="scheduleCheckbox"]:checked').closest('tr').find('td:last-child').text().trim();
        
        if (selectedScheduleStatus !== '모집') {
            alert('모집이 마감되었습니다.');
            return false;
        }

        $('#addStudentModal').modal('show');
    }
    
 	$(function() {
		$('.btn-check-type')
				.click(
						function() {
							var status = $("input[name='status']:checked").val();
							var classNo = ${classVO.classNo};
							$.ajax({
								url : "/classes/search",
								type : "GET",
								data : {
									status : status,
									classNo : classNo
								},
								success : function(data) {
									
							        const scheduleTableBody = $('#scheduleTableBody');
							        scheduleTableBody.empty();
			                        data.forEach(function(item) {
			                            const row = '<tr>' +
			                                        '<td><input type="checkbox" name="scheduleCheckbox" value="' + item.scheduleId + '"></td>' +
			                                        '<td>' + convertTimestampToDate(item.startDate) + '</td>' +
			                                        '<td>' + convertTimestampToDate(item.endDate) + '</td>' +
			                                        '<td>' + item.startTimeCode + '</td>' +
			                                        '<td>' + item.endTimeCode + '</td>' +
			                                        '<td>' + item.recurrenceDays + '</td>' +
			                                        '<td>' + item.currentEnrollment + '</td>' +
			                                        '<td>' + item.status + '</td>' +
			                                     '</tr>';
	                                     scheduleTableBody.append(row);
			                        });


								},
								error : function() {
									alert("오류발생");
								}
							});

						});

	});
 	
 	$(function() {
		$('.btn-check-all')
				.click(
						function() {
							
							window.location.href = '/classes/detail/${classVO.classNo}';

						});

	});
 	
 	$(function() {
	 	if ('${param.repair_type}' == '${pageVO.cri.repair_type}') {
	 		if ('${param.repair_type}'=='') {
	 			$(".btn-check-all").attr('checked', true);
	 		}
	 		$(":radio[name='repair_type'][value='${param.repair_type}']").attr('checked', true);
	 	}
 	});    
</script>

</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
