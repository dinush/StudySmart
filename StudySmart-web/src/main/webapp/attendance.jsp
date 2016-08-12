<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush


--%>

<%@page import="lk.studysmart.apps.models.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@include file="utils/logincheck.jsp" %>
<%@include file="utils/database.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



<% 
    Date date = new Date();
    DateFormat format = new SimpleDateFormat("yyyy/MM/dd");
%>
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
                    <%
                        out.print(user.getName());
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
            <li>Mark Attendance</li>
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
                                <h3>Grade <% out.print(grade); %> attendance details <% out.print(format.format(date)); %></h3>
                                <form action="StudentManager?action=attendancemarked" method="POST">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Student ID</th>
                                                <th>Student Name</th>
                                                <th>Attended?</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="row" items="${students}">
                                            <tr>
                                                <td>${row.username}</td>
                                                <td>${row.name}</td>
                                                <td><input type="checkbox" name="attendance" value="${row.username}" /></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <button type="submit" class="btn btn-default">Finish</button>
                                </form>
                            </div>
                            <div class="col-md-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Calendar</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div id="jqxcalendar"></div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">News feed</h3>
                                    </div>
                                    <div class="panel-body"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>