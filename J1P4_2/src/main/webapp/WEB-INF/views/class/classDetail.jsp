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
                            <button class="nav-link active" id="nav-class-tab" data-bs-toggle="tab" data-bs-target="#nav-class" type="button" role="tab" aria-controls="nav-class" aria-selected="true">Class Information</button>
                            <button class="nav-link" id="nav-schedule-tab" data-bs-toggle="tab" data-bs-target="#nav-schedule" type="button" role="tab" aria-controls="nav-schedule" aria-selected="false">Schedule Information</button>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-class" role="tabpanel" aria-labelledby="nav-class-tab">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Class Information</h3>
                                </div>
                                <div class="card-body">
                                    <form:form id="classForm" method="post" action="${pageContext.request.contextPath}/classes/save" modelAttribute="classVO">
                                        <form:hidden path="classNo" />
                                        <div class="mb-3">
                                            <label for="className" class="form-label">Class Name:</label>
                                            <form:input path="className" class="form-control" required="required" id="className"/>
                                        </div>
                                        <div class="mb-3">
                                            <label for="description" class="form-label">Description:</label>
                                            <form:textarea path="description" class="form-control" id="description"/>
                                        </div>
                                        <div class="mb-3">
                                            <label for="fieldCode" class="form-label">Field:</label>
                                            <form:select path="fieldCode" class="form-control" id="fieldCode">
                                                <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                                            </form:select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="divisionCode" class="form-label">Division:</label>
                                            <form:select path="divisionCode" class="form-control" id="divisionCode">
                                                <form:options items="${divisions}" itemValue="codeValue" itemLabel="codeValueName"/>
                                            </form:select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="levelCode" class="form-label">Level:</label>
                                            <form:select path="levelCode" class="form-control" id="levelCode">
                                                <form:options items="${levels}" itemValue="codeValue" itemLabel="codeValueName"/>
                                            </form:select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="minCapacity" class="form-label">Min Capacity:</label>
                                            <form:input path="minCapacity" class="form-control" type="number" required="required" id="minCapacity"/>
                                        </div>
                                        <div class="mb-3">
                                            <label for="maxCapacity" class="form-label">Max Capacity:</label>
                                            <form:input path="maxCapacity" class="form-control" type="number" required="required" id="maxCapacity"/>
                                        </div>
                                        <div class="mb-3">
                                            <label for="instructorName" class="form-label">Instructor Name:</label>
                                            <div class="input-group">
                                                <form:input path="instructorName" class="form-control" id="instructorName" readonly="readonly"/>
                                                <form:hidden path="instructorNo" id="instructorNo"/>
                                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#instructorModal">Find Instructor</button>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                        <!-- classDetail.jsp -->
                        <div class="tab-pane fade" id="nav-schedule" role="tabpanel" aria-labelledby="nav-schedule-tab">
						    <div class="card">
						        <div class="card-header">
						            <h3 class="card-title">Schedule Information</h3>
						        </div>
						        <div class="card-body">
						            <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#scheduleModal" onclick="initScheduleForm()">
						                Add Schedule
						            </button>
						            <button type="button" class="btn btn-primary mt-3" onclick="openAddStudentModal()">Register Student</button>
						            <button type="button" class="btn btn-primary mt-3" onclick="editSelectedSchedules()">Edit</button>
						            <button type="button" class="btn btn-danger mt-3" onclick="deleteSelectedSchedules()">Delete</button>
						            
						            <table class="table table-bordered mt-3">
						                <thead>
						                    <tr>
						                        <th>Select</th>
						                        <th>Start Date</th>
						                        <th>End Date</th>
						                        <th>Start Time</th>
						                        <th>End Time</th>
						                        <th>Recurrence Pattern</th>
						                        <th>Recurrence Days</th>
						                        <th>Current Enrollment</th>
						                        <th>Status</th>
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
						                            <td>${schedule.recurrencePattern}</td>
						                            <td>${schedule.recurrenceDays}</td>
						                            <td>${classVO.currentEnrollment}</td>
						                            <td>
						                                <c:choose>
						                                    <c:when test="${classVO.currentEnrollment >= classVO.maxCapacity}">
						                                        Closed
						                                    </c:when>
						                                    <c:when test="${classVO.currentEnrollment < classVO.minCapacity}">
						                                        Recruitment
						                                    </c:when>
						                                    <c:otherwise>
						                                        Normal
						                                    </c:otherwise>
						                                </c:choose>
						                            </td>
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
                        <h5 class="modal-title" id="scheduleModalLabel">Add Schedule</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form:form id="scheduleForm" method="post" action="${pageContext.request.contextPath}/schedules/save" modelAttribute="scheduleVO">
                            <form:hidden path="scheduleId" />
                            <form:hidden path="classNo" id="scheduleClassNo" value="${classVO.classNo}"/>
                            <div class="mb-3">
                                <label for="startDate" class="form-label">Start Date:</label>
                                <form:input path="startDate" class="form-control" type="date" id="startDate"/>
                            </div>
                            <div class="mb-3">
                                <label for="endDate" class="form-label">End Date:</label>
                                <form:input path="endDate" class="form-control" type="date" id="endDate"/>
                            </div>
                            <div class="mb-3">
                                <label for="startTime" class="form-label">Start Time:</label>
                                <form:select path="startTimeCode" id="startTime" class="form-control">
                                    <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                            </div>
                            <div class="mb-3">
                                <label for="endTime" class="form-label">End Time:</label>
                                <form:select path="endTimeCode" id="endTime" class="form-control">
                                    <form:options items="${times}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                            </div>
                            <div class="mb-3">
                                <label for="recurrencePattern" class="form-label">Recurrence Pattern:</label>
                                <form:input path="recurrencePattern" class="form-control" id="recurrencePattern"/>
                            </div>
                            <div class="mb-3">
                                <label for="recurrenceDays" class="form-label">Recurrence Days:</label>
                                <form:select path="recurrenceDays" multiple="multiple" class="form-control" id="recurrenceDays">
                                    <option value="Mon">Monday</option>
                                    <option value="Tue">Tuesday</option>
                                    <option value="Wed">Wednesday</option>
                                    <option value="Thu">Thursday</option>
                                    <option value="Fri">Friday</option>
                                    <option value="Sat">Saturday</option>
                                </form:select>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Schedule</button>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Instructor Modal -->
        <div class="modal fade" id="instructorModal" tabindex="-1" aria-labelledby="instructorModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="instructorModalLabel">Find Instructor</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="instructorSearch" class="form-label">Search Instructor by Name:</label>
                            <input type="text" class="form-control" id="instructorSearch" placeholder="Enter instructor name">
                        </div>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Instructor No</th>
                                    <th>Name</th>
                                    <th>Expertise</th>
                                    <th>Select</th>
                                </tr>
                            </thead>
                            <tbody id="instructorTableBody">
                                <!-- 강사 검색 시 동적으로 생성된 강사 목록을 표시하기 위함.(서버에서 데이터를 받아 이곳에 삽입) -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Add Student Modal -->
        <div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg"> <!-- modal-lg 클래스로 크기 조정 -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addStudentModalLabel">Register Students</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="studentSearch" class="form-label">Search Students:</label>
                            <input type="text" class="form-control" id="studentSearch" placeholder="Enter student name or phone">
                        </div>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Select</th>
                                    <th>Student No</th>
                                    <th>Name</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Detail Address</th>
                                </tr>
                            </thead>
                            <tbody id="studentTableBody">
                                <!-- 검색된 학생 목록이 여기에 표시됩니다. -->
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-primary" id="registerStudentsButton">Register</button>
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
                                        '<td>' + instructor.instructorNo + '</td>' +
                                        '<td>' + instructor.name + '</td>' +
                                        '<td>' + instructor.expertise + '</td>' +
                                        '<td><button class="btn btn-primary" onclick="selectInstructor(\'' + instructor.instructorNo + '\', \'' + instructor.name + '\')">Select</button></td>' +
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

    // Function to delete selected schedules
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

        if (selectedSchedules.length === 0) {
            alert('Please select at least one schedule.');
            return;
        }

        $('#addStudentModal').modal('show');
    }
</script>

</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
