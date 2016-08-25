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
                                
                                 <ul class="nav nav-tabs">
                                    <li role="presentation"><a href="registerStudent.jsp">Student</a></li>
                                    <li role="presentation" class="active"><a href="#">Parent</a></li>
                                    <li role="presentation"><a href="registerTeacher.jsp">Teacher</a></li>
                                    <li role="presentation"><a href="registerPrincipal.jsp">Principal</a></li>
                                    <li role="presentation"><a href="registerAdmin.jsp">System Admin</a></li>
                                 </ul> 
                                <br>
                                 <h1><span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="label label-primary">Create New Parent Entry</span></h1>
                                    
                               
                                <br>
                                <!--adding student registration-->
                                
                                <br>
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">Guardian Name:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">Child's Name:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">
                                    </div>
                                </div>
                                
                                 <div class="row">
                                    <div class="col-lg-2"><b>Gender: </b></div>
                                    <div class="col-lg-4">
                                        <select name="class" class="form-control">
                                            <option value="1">Male</option>
                                            <option value="2">Female</option>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">NIC: </label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="text" value="XXXXXXXXXV" id="example-text-input">
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">Address:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">Occupation:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="example-tel-input" class="col-xs-2 col-form-label">Home TP</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="tel" value="0XX-XXXXXXX" id="example-tel-input">
                                    </div>
                                </div>
                                <br>
                                <div class="form-group row">
                                    <label for="example-tel-input" class="col-xs-2 col-form-label">Mobile</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="tel" value="0XX-XXXXXXX" id="example-tel-input">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="example-email-input" class="col-xs-2 col-form-label">Email:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="email" value="artisanal@example.com" id="example-email-input">
                                    </div>
                                </div>
                                <br>
                                
                                
                                <button type="button" class="btn btn-primary" style="margin-left:520px;"><h4> Register</h4> </button>
                            <!-- finishing student registration-->
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