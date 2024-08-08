<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidemenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>출석 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
        const dayNames = ['일', '월', '화', '수', '목', '금', '토'];
        const contextPath = '${pageContext.request.contextPath}';

        $(document).ready(function() {
            $('#classSelect').on('change', function() {
                const classNo = $(this).val();
                if (classNo) {
                    $.ajax({
                        url: contextPath + '/attendance/schedules/' + classNo,
                        type: 'GET',
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(data) {
                            $('#scheduleSelect').html('<option value="">일정을 선택하세요</option>');
                            data.forEach(function(schedule) {
                                if (schedule.status === '정상') {
                                    const startDate = new Date(schedule.startDate).toLocaleDateString();
                                    const endDate = new Date(schedule.endDate).toLocaleDateString();
                                    const option = '<option value="' + schedule.scheduleId + '">' + startDate + ' ~ ' + endDate + ' (' + schedule.recurrenceDays + ')</option>';
                                    $('#scheduleSelect').append(option);
                                }
                            });
                        },
                        error: function() {
                            alert('일정을 불러오는 데 실패했습니다.');
                        }
                    });
                } else {
                    $('#scheduleSelect').html('<option value="">일정을 선택하세요</option>');
                }
            });

            $('#scheduleSelect').on('change', function() {
                const scheduleId = $(this).val();
                if (scheduleId) {
                    $.ajax({
                        url: contextPath + '/attendance/students/' + scheduleId,
                        type: 'GET',
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(data) {
                            renderStudentList(data, scheduleId);
                        },
                        error: function() {
                            alert('학생 목록을 불러오는 데 실패했습니다.');
                        }
                    });
                } else {
                    $('#studentList').html('');
                }
            });

            $('#nav-daily-check-tab').on('click', function() {
                const scheduleId = $('#scheduleSelect').val();
                if (scheduleId) {
                    $.ajax({
                        url: contextPath + '/attendance/daily-check/' + scheduleId,
                        type: 'GET',
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        },
                        success: function(data) {
                            renderDailyCheckList(data);
                        },
                        error: function() {
                            alert('일일 출석 목록을 불러오는 데 실패했습니다.');
                        }
                    });
                } else {
                    $('#dailyCheckList').html('');
                }
            });

            loadSelections();
        });

        function renderStudentList(data, scheduleId) {
            var studentTable = '<table class="table table-bordered">' +
                                '<thead>' +
                                '<tr>' +
                                '<th>학생 번호</th>' +
                                '<th>이름</th>' +
                                '<th>전화</th>' +
                                '<th>출석한 수업</th>' +
                                '<th>총 수업</th>' +
                                '<th>출석률</th>' +
                                '</tr>' +
                                '</thead>' +
                                '<tbody>';
            data.forEach(function(student) {
                studentTable += '<tr>' +
                                '<td>' + student.mem_no + '</td>' +
                                '<td><a href="javascript:void(0);" onclick="showDailyAttendance(' + student.mem_no + ',' + scheduleId + ');">' + student.mem_name + '</a></td>' +
                                '<td>' + student.mem_phone + '</td>' +
                                '<td><input type="number" id="attended_classes_' + student.mem_no + '" value="' + student.attendedClasses + '" readonly/></td>' +
                                '<td><input type="number" id="total_classes_' + student.mem_no + '" value="' + student.totalClasses + '" readonly/></td>' +
                                '<td>' + student.attendanceRate + '%</td>' +
                                '</tr>';
            });
            studentTable += '</tbody></table>';
            $('#studentList').html(studentTable);
        }

        function renderDailyCheckList(data) {
            var dailyCheckTable = '<table class="table table-bordered">' +
                                    '<thead>' +
                                    '<tr>' +
                                    '<th>학생 번호</th>' +
                                    '<th>이름</th>' +
                                    '<th>전화</th>' +
                                    '<th>출석 표시</th>' +
                                    '</tr>' +
                                    '</thead>' +
                                    '<tbody>';
            data.forEach(function(student) {
                dailyCheckTable += '<tr>' +
                                   '<td>' + student.mem_no + '</td>' +
                                   '<td>' + student.mem_name + '</td>' +
                                   '<td>' + student.mem_phone + '</td>' +
                                   '<td><input type="checkbox" class="dailyAttendanceCheckbox" data-schedule-id="' + student.classSchedule_no + '" data-mem-no="' + student.mem_no + '"></td>' +
                                   '</tr>';
            });
            dailyCheckTable += '</tbody></table>';
            $('#dailyCheckList').html(dailyCheckTable);
        }
        
        function showDailyAttendance(memNo, scheduleId) {
            $.ajax({
                url: contextPath + '/attendance/daily-attendance/' + memNo + '/' + scheduleId,
                type: 'GET',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(response) {
                    console.log("모달 데이터 로드 성공: ", response);

                    const classAttendance = response.classAttendance;
                    const dailyAttendanceList = response.dailyAttendanceList;

                    // 모달 제목 설정
                    $('#dailyAttendanceModalLabel').text(classAttendance.mem_name + '의 출석 기록');

                    // 모달 본문 설정
                    $('#modalMemNo').text(classAttendance.mem_no);
                    $('#modalMemPhone').text(classAttendance.mem_phone);
                    $('#modalAttendedClasses').text(classAttendance.attendedClasses);
                    $('#modalTotalClasses').text(classAttendance.totalClasses);
                    $('#modalAttendanceRate').text(classAttendance.attendanceRate + '%');

                    // 일일 출석 기록 설정
                    let dailyAttendanceContent = '';
                    dailyAttendanceList.forEach(function(dailyAttendance) {
                        const attendanceDate = new Date(dailyAttendance.attendance_date).toLocaleDateString();
                        dailyAttendanceContent += `
                            <tr>
                                <td>${attendanceDate}</td>
                            </tr>`;
                    });
                    $('#modalDailyAttendanceList').html(dailyAttendanceContent);

                    // 모달 표시
                    var modal = new bootstrap.Modal(document.getElementById('dailyAttendanceModal'));
                    modal.show();
                },
                error: function() {
                    alert('출석 기록을 불러오는 데 실패했습니다.');
                }
            });
        }


        function updateDailyAttendance() {
            const selectedCheckboxes = $('.dailyAttendanceCheckbox:checked');
            const totalCheckboxes = selectedCheckboxes.length;
            let processedCheckboxes = 0;
            let alreadyCheckedAlertShown = false;
            let errorAlertShown = false;

            if (totalCheckboxes === 0) {
                alert('출석할 학생을 선택하세요.');
                return;
            }

            const today = new Date();
            const todayDay = dayNames[today.getDay()];
            const recurrenceDays = $('#scheduleSelect option:selected').text().split('(')[1].replace(')', '').split(',');

            if (!recurrenceDays.includes(todayDay)) {
                alert('오늘은 출석 체크할 수 있는 날이 아닙니다.');
                return;
            }

            selectedCheckboxes.each(function() {
                const classScheduleNo = $(this).data('schedule-id');
                const memNo = $(this).data('mem-no');

                $.ajax({
                    url: `${contextPath}/attendance/daily-check/update`,
                    type: 'POST',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    data: JSON.stringify({
                        classSchedule_no: classScheduleNo,
                        mem_no: memNo
                    }),
                    contentType: 'application/json',
                    success: function(response) {
                        if (response === 'already_checked' && !alreadyCheckedAlertShown) {
                            alert('이미 출석체크를 완료하였습니다.');
                            alreadyCheckedAlertShown = true;
                        } else {
                            processedCheckboxes++;
                            if (processedCheckboxes === totalCheckboxes && !errorAlertShown) {
                                alert('일일 출석 체크가 완료되었습니다.');
                                saveSelections();
                                location.reload();
                            }
                        }
                    },
                    error: function(xhr) {
                        if (xhr.status === 409 && !alreadyCheckedAlertShown) {
                            alert('이미 출석체크를 완료하였습니다.');
                            alreadyCheckedAlertShown = true;
                        } else if (!errorAlertShown) {
                            alert('일일 출석 체크 중 오류가 발생했습니다.');
                            errorAlertShown = true;
                        }
                    }
                });
            });
        }

        function saveSelections() {
            const classSelectVal = $('#classSelect').val();
            const scheduleSelectVal = $('#scheduleSelect').val();
            localStorage.setItem('classSelect', classSelectVal);
            localStorage.setItem('scheduleSelect', scheduleSelectVal);
        }

        function loadSelections() {
            const classSelectVal = localStorage.getItem('classSelect');
            const scheduleSelectVal = localStorage.getItem('scheduleSelect');
            if (classSelectVal) {
                $('#classSelect').val(classSelectVal).trigger('change');
            }
            if (scheduleSelectVal) {
                $('#scheduleSelect').val(scheduleSelectVal).trigger('change');
            }
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
                            <h1>출석 관리</h1>
                        </div>
                    </div>
                </div>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="form-group">
                        <label for="classSelect">강의를 선택하세요:</label>
                        <select id="classSelect" class="form-control">
                            <option value="">강의를 선택하세요</option>
                            <c:forEach var="classItem" items="${classes}">
                                <option value="${classItem.classNo}">${classItem.className}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div id="scheduleList" class="form-group">
                        <label for="scheduleSelect">일정을 선택하세요:</label>
                        <select id="scheduleSelect" class="form-control">
                            <option value="">일정을 선택하세요</option>
                        </select>
                    </div>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <button class="nav-link active" id="nav-attendance-tab" data-bs-toggle="tab" data-bs-target="#nav-attendance" type="button" role="tab" aria-controls="nav-attendance" aria-selected="true">출석</button>
                        <button class="nav-link" id="nav-daily-check-tab" data-bs-toggle="tab" data-bs-target="#nav-daily-check" type="button" role="tab" aria-controls="nav-daily-check" aria-selected="false">일일 체크</button>
                    </div>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-attendance" role="tabpanel" aria-labelledby="nav-attendance-tab">
                            <div id="studentList" class="form-group">
                                <!-- 학생 목록이 여기에 로드됩니다. -->
                            </div>
                        </div>
                        <div class="tab-pane fade" id="nav-daily-check" role="tabpanel" aria-labelledby="nav-daily-check-tab">
                            <div id="dailyCheckList" class="form-group">
                                <!-- 일일 체크 목록이 여기에 로드됩니다. -->
                            </div>
                            <button class="btn btn-primary" onclick="updateDailyAttendance()">출석 제출</button>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    
    <!-- Modal -->
    <div class="modal fade" id="dailyAttendanceModal" tabindex="-1" aria-labelledby="dailyAttendanceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dailyAttendanceModalLabel">출석 기록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>학생 번호:</strong> <span id="modalMemNo"></span></p>
                    <p><strong>전화번호:</strong> <span id="modalMemPhone"></span></p>
                    <p><strong>출석한 수업:</strong> <span id="modalAttendedClasses"></span></p>
                    <p><strong>총 수업:</strong> <span id="modalTotalClasses"></span></p>
                    <p><strong>출석률:</strong> <span id="modalAttendanceRate"></span></p>
                    <h5>일일 출석 기록</h5>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>출석 날짜</th>
                            </tr>
                        </thead>
                        <tbody id="modalDailyAttendanceList">
                            <!-- 일일 출석 기록이 여기에 로드됩니다. -->
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
