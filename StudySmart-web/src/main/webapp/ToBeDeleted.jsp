<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : Kaveesh

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
            <li><a href="index.jsp">Home </a></li> 
            <li>Term Test Marks</li>
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
                                
                                <div class="row">
                                    
                                    <div class="col-lg-3">
                                        <select name="term" class="form-control">
                                            <option value="1">Term I</option>
                                            <option value="2">Term II</option>
                                            <option value="3">Term III</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-lg-3">
                                        <select name="grade" class="form-control">
                                            <option value="1">Grade 10</option>
                                            <option value="2">Grade 11</option>
                                        </select>
                                    </div>
                                    

                                    <div class="col-lg-3">
                                        <select name="class" class="form-control">
                                            <option value="1">Class A</option>
                                            <option value="2">Class B</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-lg-3">
                                        <select name="class" class="form-control">
                                            <option value="1">Science</option>
                                            <option value="2">English</option>
                                        </select>
                                    </div>
                                    
                                    
                                    
                                </div>
                                <br>
                                <form class="form-inline">
                                    <div class="form-group">
                                        <label for="exampleInputName2" style="margin-left:100px;">Cut-off Mark: </label>
                                        <input type="text" class="form-control" id="exampleInputName2" placeholder="25">
                                    </div>
                                </form>
                                <br>
                                <br>
                                
                                <div>
                                    <button type="button" class="btn btn-primary" style="margin-left:230px;">Load Students</button>
                                </div>
                                <br><br>
                                
                                <!--students should be loaded to the table below-->
                                
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Student Name</th>
                                            <th>Marks Obtained</th>
                                            <th>Marks out of 100</th>
                                            <th> Comment </th>
                                        </tr>
                                    </thead>
                                     <tbody>
                                       
                                    </tbody>
                                </table>
                                <div>
                                    <button type="button" class="btn btn-danger">Generate marks out of 100</button>
                                    <button type="button" class="btn btn-primary" style="float:right;">Submit</button>
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
