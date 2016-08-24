<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="utils/logincheck.jsp" %>
<%@include file="utils/database.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/main.css" />
        <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css"/>
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script type = "text/javascript" >
            $(document).ready(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
            });
        </script>


    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <div id="page-title">
                <h1>Study Smart</h1>
            </div>                
            <div class="user-details">
                Signed in as:
                <span id="user-name">
                    <%                        out.print(user.getName());
                    %>
                </span>
                <a href="logout">
                    (logout)
                </a>                    
            </div>
        </div>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li>View Attendance</li>
        </ol>
        <table border="0">
            <tr>
                <td valign="top" class="table-col-fixed">
                    <%@ include file="WEB-INF/jspf/Sidemenu.jspf" %>
                </td>
                <td valign="top" class="table-col-max">
                    <div class="content">
                        <div class="row">
                            <div id="main-content" class="col-md-8">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">Attendance Details</div>
                                    <div class="panel-body">
                                        <% User student = (User) request.getAttribute("student"); %>
                                        Student Name: <% out.println(student.getName()); %> <br>
                                        Grade: <% out.println(student.getGrade());%>
                                    </div>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Attended?</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="day" items="${days}">
                                                <tr>
                                                    <td>${day.attendancePK.date}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${day.attended}">
                                                                Yes
                                                            </c:when>
                                                            <c:otherwise>
                                                                No
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                    
                                <!-- View Attendance by the Teacher -->
                                <div class="row">
                                    
                                    <div class="col-lg-4">
                                        <select name="grade" class="form-control">
                                               <option value="1">Grade 10</option>
                                               <option value="2">Grade 11</option>
                                        </select>
                                    </div>
                               
                                
                                    
                                    <div class="col-lg-4">
                                        <select name="class" class="form-control">
                                               <option value="1">Class A</option>
                                               <option value="2">Class B</option>
                                               <option value="2">Class C</option>
                                        </select>
                                    </div>
                                    
                                </div>
                           
                                <br>
                                
                                <form class="form-inline">
                                    <div class="form-group">
                                      <label for="exampleInputStartDate">From:     </label>
                                      <input type="date" class="form-control" id="exampleInputName2" placeholder="yyyy/mm/dd">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputEndDate">To:    </label>
                                      <input type="date" class="form-control" id="exampleInputEmail2" placeholder="yyyy/mm/dd">
                                    </div>
                                    <br></br>
                                    <div class="form-group">
                                      <label for="exampleInputName">Student Name: </label>
                                      <input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
                                    </div>
                                </form>
                                <br> </br>
                                <button type="button" class="btn btn-primary">View Attendance</button>

                            
                                
                            </div>
                            <div class="col-md-4">
                                <%@ include file="WEB-INF/jspf/Infopanel.jspf" %>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
