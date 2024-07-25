<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidemenu.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class List</title>
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
                        <div class="col-sm-6">
                            <button type="button" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#classModal" onclick="openModal()">
                                Add New Class
                            </button>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Field</th>
                                <th>Division</th>
                                <th>Level</th>
                                <th>Max Capacity</th>
                                <th>Instructor</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="classItem" items="${classList}">
                                <tr>
                                    <td>${classItem.classNo}</td>
                                    <td>${classItem.className}</td>
                                    <td>${classItem.description}</td>
                                    <td>${classItem.fieldCode}</td>
                                    <td>${classItem.divisionCode}</td>
                                    <td>${classItem.levelCode}</td>
                                    <td>${classItem.maxCapacity}</td>
                                    <td>${classItem.instructorName}</td>
                                    <td>
                                        <button class="btn btn-warning" onclick="editClass(${classItem.classNo})">Edit</button>
                                        <button class="btn btn-danger" onclick="deleteClass(${classItem.classNo})">Delete</button>
                                        <button class="btn btn-info" onclick="openScheduleModal(${classItem.classNo})">Add Schedule</button>
                                        <button class="btn btn-secondary" onclick="viewSchedules(${classItem.classNo})">View Schedules</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Class Modal -->
        <div class="modal fade" id="classModal" tabindex="-1" aria-labelledby="classModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="classModalLabel">Add/Edit Class</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
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
        </div>

        <!-- Schedule Modal -->
        <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="scheduleModalLabel">Add Schedule</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form:form id="scheduleForm" method="post" action="${pageContext.request.contextPath}/schedules/save" modelAttribute="scheduleVO">
                            <form:hidden path="classNo" id="scheduleClassNo"/>
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

        <!-- View Schedule Modal -->
        <div class="modal fade" id="viewScheduleModal" tabindex="-1" aria-labelledby="viewScheduleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewScheduleModalLabel">View Schedules</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Recurrence Pattern</th>
                                    <th>Recurrence Days</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="scheduleTableBody">
                                <!-- Dynamic content goes here -->
                            </tbody>
                        </table>
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
                                <!-- Dynamic content goes here -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include jQuery and Bootstrap if not already included -->

<script>
    $(document).ready(function() {
        $('#classForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: '${pageContext.request.contextPath}/classes/save',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#classModal').modal('hide');
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while saving the class');
                }
            });
        });

        $('#scheduleForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: '${pageContext.request.contextPath}/schedules/save',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#scheduleModal').modal('hide');
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while saving the schedule');
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
                        alert('Error occurred while searching for instructors');
                    }
                });
            }
        });
    });

    function openModal() {
        $('#classForm')[0].reset();
        $('#classModalLabel').text('Add Class');
        $('#classNo').val(0); // 신규 추가 시 classNo를 0으로 설정
    }

    function editClass(classNo) {
        $.get('${pageContext.request.contextPath}/classes/edit/' + classNo, function(data) {
            $('#classNo').val(data.classNo);
            $('#className').val(data.className);
            $('#description').val(data.description);
            $('#fieldCode').val(data.fieldCode);
            $('#divisionCode').val(data.divisionCode);
            $('#levelCode').val(data.levelCode);
            $('#maxCapacity').val(data.maxCapacity);
            $('#instructorNo').val(data.instructorNo);
            $('#instructorName').val(data.instructorName);
            $('#classModalLabel').text('Edit Class');
            $('#classModal').modal('show');
        });
    }

    function openScheduleModal(classNo) {
        $('#scheduleForm')[0].reset();
        $('#scheduleClassNo').val(classNo);
        $('#scheduleModal').modal('show');
    }

    function viewSchedules(classNo) {
        $.get('${pageContext.request.contextPath}/schedules/list/' + classNo, function(data) {
            const scheduleTableBody = $('#scheduleTableBody');
            scheduleTableBody.empty();
            data.forEach(function(schedule) {
                const startDate = new Date(schedule.startDate).toLocaleDateString();
                const endDate = new Date(schedule.endDate).toLocaleDateString();
                const row = '<tr>' +
                            '<td>' + startDate + '</td>' +
                            '<td>' + endDate + '</td>' +
                            '<td>' + schedule.startTimeCode + '</td>' +
                            '<td>' + schedule.endTimeCode + '</td>' +
                            '<td>' + schedule.recurrencePattern + '</td>' +
                            '<td>' + schedule.recurrenceDays + '</td>' +
                            '<td><button class="btn btn-warning" onclick="editSchedule(' + schedule.scheduleId + ')">Edit</button>' +
                            '<button class="btn btn-danger" onclick="deleteSchedule(' + schedule.scheduleId + ')">Delete</button></td>' +
                         '</tr>';
                scheduleTableBody.append(row);
            });
            $('#viewScheduleModal').modal('show');
        });
    }

    function selectInstructor(instructorNo, instructorName) {
        $('#instructorNo').val(instructorNo);
        $('#instructorName').val(instructorName);
        $('#instructorModal').modal('hide');
    }

    function deleteClass(classNo) {
        if (confirm('Are you sure you want to delete this class?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/classes/delete/' + classNo,
                method: 'POST',
                success: function(response) {
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while deleting the class');
                }
            });
        }
    }

    function editSchedule(scheduleId) {
        $.get('${pageContext.request.contextPath}/schedules/edit/' + scheduleId, function(data) {
            $('#scheduleId').val(data.scheduleId);
            $('#scheduleClassNo').val(data.classNo);
            $('#startDate').val(data.startDate);
            $('#endDate').val(data.endDate);
            $('#startTime').val(data.startTimeCode);
            $('#endTime').val(data.endTimeCode);
            $('#recurrencePattern').val(data.recurrencePattern);
            $('#recurrenceDays').val(data.recurrenceDays);
            $('#scheduleModal').modal('show');
        });
    }

    function deleteSchedule(scheduleId) {
        if (confirm('Are you sure you want to delete this schedule?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/schedules/delete/' + scheduleId,
                method: 'POST',
                success: function(response) {
                    location.reload();
                },
                error: function(error) {
                    alert('Error occurred while deleting the schedule');
                }
            });
        }
    }
</script>

</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
