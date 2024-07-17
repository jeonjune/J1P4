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
                            <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#classModal" onclick="openModal()">
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
                                <th>Instructor No</th>
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
                                    <td>${classItem.instructorNo}</td>
                                    <td>
                                        <button class="btn btn-warning" onclick="editClass(${classItem.classNo})">Edit</button>
                                        <form:form action="${pageContext.request.contextPath}/classes/delete/${classItem.classNo}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form:form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="classModal" tabindex="-1" role="dialog" aria-labelledby="classModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="classModalLabel">Add/Edit Class</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form:form id="classForm" method="post" action="${pageContext.request.contextPath}/classes/save" modelAttribute="classVO">
                            <form:hidden path="classNo" />
                            <div class="form-group">
                                <label>Class Name:</label>
                                <form:input path="className" class="form-control" required="required"/>
                            </div>
                            <div class="form-group">
                                <label>Description:</label>
                                <form:textarea path="description" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label>Field:</label>
                                <form:select path="fieldCode" class="form-control">
                                    <form:options items="${fields}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                            </div>
                            <div class="form-group">
                                <label>Division:</label>
                                <form:select path="divisionCode" class="form-control">
                                    <form:options items="${divisions}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                            </div>
                            <div class="form-group">
                                <label>Level:</label>
                                <form:select path="levelCode" class="form-control">
                                    <form:options items="${levels}" itemValue="codeValue" itemLabel="codeValueName"/>
                                </form:select>
                            </div>
                            <div class="form-group">
                                <label>Max Capacity:</label>
                                <form:input path="maxCapacity" class="form-control" type="number" required="required"/>
                            </div>
                            <div class="form-group">
                                <label>Instructor No:</label>
                                <form:input path="instructorNo" class="form-control" type="number" required="required"/>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- AJAX to handle form submission and editing -->
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
        });

        function openModal() {
            $('#classForm')[0].reset();
            $('#classModalLabel').text('Add Class');
            $('input[name=classNo]').val(0); // 신규 추가 시 classNo를 0으로 설정
        }

        function editClass(classNo) {
            $.get('${pageContext.request.contextPath}/classes/edit/' + classNo, function(data) {
                $('input[name=classNo]').val(data.classNo);
                $('input[name=className]').val(data.className);
                $('textarea[name=description]').val(data.description);
                $('select[name=fieldCode]').val(data.fieldCode);
                $('select[name=divisionCode]').val(data.divisionCode);
                $('select[name=levelCode]').val(data.levelCode);
                $('input[name=maxCapacity]').val(data.maxCapacity);
                $('input[name=instructorNo]').val(data.instructorNo);
                $('#classModalLabel').text('Edit Class');
                $('#classModal').modal('show');
            });
        }
    </script>
</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
