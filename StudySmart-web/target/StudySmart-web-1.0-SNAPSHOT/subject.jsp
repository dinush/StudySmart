<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<sql:setDataSource var="StudySmart" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost/StudySmart"
                   user="root" password="abc123" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Object user = session.getAttribute("username");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String idSubject = (String) request.getAttribute("idSubject");
    if (idSubject == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String nameSubject = (String) request.getAttribute("nameSubject");
    String gradeSubject = (String) request.getAttribute("gradeSubject");
    
    int grade = (Integer) session.getAttribute("grade");
%>

<sql:query dataSource="${StudySmart}" var="result">
    SELECT * FROM Subject WHERE grade = ${grade};
</sql:query>
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
                        out.print(session.getAttribute("name"));
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
            <li><a href="#">Subject (${nameSubject})</a></li>
        </ol>
        <table border="0">
            <tr>
                <td valign="top" class="table-col-fixed">
                    <div class="nav-bar-vertical">
                        <ul class="nav nav-pills nav-stacked">
                            <li role="presentation"><a href="index.jsp">Home</a></li>
                            <li role="presentation"><a href="#">Profile</a></li>
                            <li role="presentation" class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-hashopup="true" aria-expanded="false">
                                    Subjects<span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="row" items="${result.rows}">
                                        <li role="presentation"><a href="subject?id=<c:out value='${row.idSubject}'/>"><c:out value="${row.name}"/></a></li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </td>
                <td valign="top" class="table-col-max">
                    <div class="content">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        Forum
                                    </div>
                                </div>
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
