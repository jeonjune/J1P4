<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class Form</title>
</head>
<body>
    <div class="wrapper">
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Class Form</h1>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                    <form:form id="classForm" method="post" modelAttribute="classVO">
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
                            <form:input path="levelCode" class="form-control"/>
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
            </section>
        </div>
    </div>

</body>
</html>
