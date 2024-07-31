<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/sidemenu.jsp"%>
<%@ include file="../include/empMenu.jsp"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@page import="com.itwillbs.domain.EmpAttendanceVO"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
    <script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        
        var calendar = new FullCalendar.Calendar(calendarEl, {
          	initialView: 'dayGridMonth',
          	locale : 'ko',
     	  	selectable : true,
     	  	droppable : true,
     	  	editable : true,
     	  	events : [ 
     	      	    <%List<EmpAttendanceVO> calendarList = (List<EmpAttendanceVO>) request.getAttribute("calendarList");%>
     	              <%if (calendarList != null) {%>
     	              <%for (EmpAttendanceVO vo : calendarList) {%>
     	              {
     	              	title : '<%=vo.getVacation_reason()%>',
     	                  start : '<%=vo.getVacation_start()%>',
     	                  end : '<%=vo.getVacation_end()%>',
     	                  color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
     	               },
     	  	<%}
     	  }%>
     	  				]
        });
        calendar.render();
//         calendar.setOption('height', 700);
        calendar.setOption('contentHeight', 650);

      });


    </script>
<div class="content-wrapper" style="min-height: 831px;">
  <div class="content-wrapper" style="min-height: 831px;">
    <div id='calendar'></div>
  </div>
 </div> 
  
  
  
  
 <%@ include file="../include/footer.jsp"%>