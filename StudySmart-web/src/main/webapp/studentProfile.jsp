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
            <li> Profile </li>
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
                               
                                <!--student profile (personal details)-->
                                
                                <!--row of buttons at the top-->
                                <ul class="nav nav-tabs">
                                    <li role="presentation" class="active"><a href="#">Personal Details</a></li>
                                    <li role="presentation" class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                          Academic Details <span class="caret"></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                          <li><a href="#">Achievements</a></li>
                                            <li><a href="#">Progress Report</a></li>
                                            
                                        </ul>
                                    </li>
                                    <li role="presentation"><a href="#">Attendance</a></li>
                                    <li role="presentation" class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                          Extra-Curricular Activities <span class="caret"></span>
                                        </a>
                                         <ul class="dropdown-menu">
                                            <li><a href="#">Membership Details</a></li>
                                            <li><a href="#">Achievements</a></li>
                                            
                                        </ul>
                                    </li>
                                </ul>  
                                <br>
                                <!--student personal details-->
                                
  
                                <h1><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                    <span class="label label-primary">Student's Information</span></h1>
                                <br>
                                <div class="panel panel-info"
                                    <!-- List group -->
                                    <div class="panel-body"
                                        <ul class="list-group" style="font-size:16px;">
                                            <li class="list-group-item"><b>Student Name: <b></li>
                                          <li class="list-group-item">Birth Date:</li>
                                          <li class="list-group-item">Gender: </li>
                                          <li class="list-group-item">Entered Grade: </li>
                                          <li class="list-group-item">Email:</li>
                                          <li class="list-group-item">Main  mode of transportation:</li>
                                        </ul>
                                    </div>
                                </div>
                                <br>
                                
                                    <h1><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                    <span class="label label-primary">Guardian's Information</span></h1>
                                
                                <br>
                                <div class="panel panel-info"style="font-size:16px;">
                                    <!-- List group -->
                                    <div class="panel-body">
                                        <ul class="list-group">
                                            <li class="list-group-item"><b>Guardian Name: <b></li>
                                            <li class="list-group-item">NIC:</li>
                                            <li class="list-group-item">Telephone Number: </li>
                                            <li class="list-group-item">Email: </li>
                                        </ul>
                                    </div>
                                </div>
                                  

                                <!--student profile personal details ends here-->
                                
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
