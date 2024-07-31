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

            <section class="content">
                <div class="container-fluid">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
					            <th>No</th>
					            <th>Name</th>
					            <th>Description</th>
					            <th>Field</th>
					            <th>Division</th>
					            <th>Level</th>
					            <th>Min / Max (Capacity)</th>
					            <th>Instructor</th>
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
                    <div>
                        <button type="button" class="btn btn-danger" onclick="deleteSelectedClasses()">Delete Selected Classes</button>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#classModal" onclick="openModal()">Add New Class</button>
                    </div>
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
                    <!-- classList.jsp의 Class Modal에 추가 -->
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
</script>


</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
