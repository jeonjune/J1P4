<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Class Form</title>
    <!-- 필요한 CSS 파일들 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/adminlte.min.css">
</head>
<body>
    <div class="wrapper">
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>시설등록</h1>
                        </div>
                    </div>
                </div>
            </section>

            <section class="content">
                <div class="container-fluid">
                  
                        <div class="form-group">
                            <label>시설번호</label>
                            <input type="text" name="facility_no" value="${vo.facility_no}" class="form-control" required />
                        </div>
                      
                        
                        <div class="form-group">
                            <label>시설이름</label>
                            <input type="text" name="facility_name" value="${vo.facility_name}" class="form-control" />
                        </div>
                        
                        <div class="form-group">
                            <label>담당자</label>
                            <input type="text" name="name" value="${vo.name}" class="form-control" />
                        </div>
                       
                        <button type="submit" class="btn btn-primary">등록</button>
                    
                </div>
            </section>
        </div>
    </div>

    <!-- 필요한 JS 파일들 -->
    <script src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/adminlte.min.js"></script>
</body>
</html>
