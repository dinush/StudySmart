<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="logincheck.jsp" %>
<%@include file="database.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<sql:query dataSource="${StudySmart}" var="result">
    SELECT * FROM Subject s WHERE s.grade = ${grade};
</sql:query>
<sql:query dataSource="${StudySmart}" var="quizes">
    SELECT * FROM Quizset q WHERE q.username = '${username}';
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
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        
    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li>Quiz Management</li>
        </ol>
        <table border="0">
            <tr>
                <td valign="top" class="table-col-fixed">
                    <div class="nav-bar-vertical">
                        <ul class="nav nav-pills nav-stacked">
                            <li role="presentation" class="active"><a href="#">Home</a></li>
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
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        Quizes
                                    </div>
                                    <div class="panel-body">
                                        <a class="btn btn-default" href="addquiz.jsp" role="button">Add quiz</a>
                                        <c:forEach var="row" items="${quizes.rows}">
                                            <h4><c:out value="${row.name}"/></h4>
                                        </c:forEach>
                                    </div>
                                </div>
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
