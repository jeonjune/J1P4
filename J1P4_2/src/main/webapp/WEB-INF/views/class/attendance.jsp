<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidemenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        $(document).ready(function() {
            $('#classSelect').on('change', function() {
                const classNo = $(this).val();
                if (classNo) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/attendance/schedules/' + classNo,
                        type: 'GET',
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(data) {
                            $('#scheduleSelect').html('<option value="">Select Schedule</option>');
                            data.forEach(function(schedule) {
                                const startDate = new Date(schedule.startDate).toLocaleDateString();
                                const endDate = new Date(schedule.endDate).toLocaleDateString();
                                const option = '<option value="' + schedule.scheduleId + '">' + startDate + ' ~ ' + endDate + ' (' + schedule.recurrenceDays + ')</option>';
                                $('#scheduleSelect').append(option);
                            });
                        },
                        error: function() {
                            alert('Failed to load schedules');
                        }
                    });
                } else {
                    $('#scheduleSelect').html('<option value="">Select Schedule</option>');
                }
            });

            $('#scheduleSelect').on('change', function() {
                const scheduleId = $(this).val();
                if (scheduleId) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/attendance/students/' + scheduleId,
                        type: 'GET',
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(data) {
                            var studentTable = '<table class="table table-bordered">' +
                                                '<thead>' +
                                                '<tr>' +
                                                '<th>Student No</th>' +
                                                '<th>Name</th>' +
                                                '<th>Phone</th>' +
                                                '<th>Attended Classes</th>' +
                                                '<th>Total Classes</th>' +
                                                '<th>Attendance Rate</th>' +
                                                '<th>Actions</th>' +
                                                '</tr>' +
                                                '</thead>' +
                                                '<tbody>';
                            data.forEach(function(student) {
                                studentTable += '<tr>' +
                                                '<td>' + student.mem_no + '</td>' +
                                                '<td>' + student.mem_name + '</td>' +
                                                '<td>' + student.mem_phone + '</td>' +
                                                '<td><input type="number" id="attended_classes_' + student.mem_no + '" value="' + student.attendedClasses + '" data-mem-no="' + student.mem_no + '" data-schedule-id="' + scheduleId + '" class="attendedClasses"/></td>' +
                                                '<td><input type="number" id="total_classes_' + student.mem_no + '" value="' + student.totalClasses + '" data-mem-no="' + student.mem_no + '" data-schedule-id="' + scheduleId + '" class="totalClasses"/></td>' +
                                                '<td>' + student.attendanceRate + '%</td>' +
                                                '<td><button class="btn btn-primary" onclick="updateAttendance(' + student.classSchedule_no + ', ' + student.mem_no + ')">Update</button></td>' +
                                                '</tr>';
                            });
                            studentTable += '</tbody></table>';
                            $('#studentList').html(studentTable);
                        },
                        error: function() {
                            alert('Failed to load students');
                        }
                    });
                } else {
                    $('#studentList').html('');
                }
            });
        });

        function updateAttendance(classScheduleNo, memNo) {
            const attendedClasses = $('#attended_classes_' + memNo).val();
            const totalClasses = $('#total_classes_' + memNo).val();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/attendance/update',
                type: 'POST',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                data: {
                    classSchedule_no: classScheduleNo,
                    mem_no: memNo,
                    attendedClasses: attendedClasses,
                    totalClasses: totalClasses
                },
                success: function() {
                    alert('Attendance updated successfully');
                },
                error: function() {
                    alert('Error updating attendance');
                }
            });
        }
    </script>
</head>
<body>
    <div class="wrapper">
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Attendance Management</h1>
                        </div>
                    </div>
                </div>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="form-group">
                        <label for="classSelect">Select Class:</label>
                        <select id="classSelect" class="form-control">
                            <option value="">Select Class</option>
                            <c:forEach var="classItem" items="${classes}">
                                <option value="${classItem.classNo}">${classItem.className}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div id="scheduleList" class="form-group">
                        <label for="scheduleSelect">Select Schedule:</label>
                        <select id="scheduleSelect" class="form-control">
                            <option value="">Select Schedule</option>
                        </select>
                    </div>
                    <div id="studentList" class="form-group">
                        <!-- Student list will be loaded here -->
                    </div>
                </div>
            </section>
        </div>
    </div>
</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
