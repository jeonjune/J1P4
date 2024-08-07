<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/sidemenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Daily Attendance</title>
</head>
<body>
    <div class="wrapper">
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Daily Attendance</h1>
                        </div>
                    </div>
                </div>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Student No</th>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>Attendance Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dailyAttendance" items="${dailyAttendanceList}">
                                <tr>
                                    <td>${dailyAttendance.mem_no}</td>
                                    <td>${dailyAttendance.mem_name}</td>
                                    <td>${dailyAttendance.mem_phone}</td>
                                    <td>${dailyAttendance.attendance_date}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
