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
        <link rel="stylesheet" href="css/bootstrap-datepicker.standalone.min.css" />
        <link rel="stylesheet" href="css/main.css" />
        <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css"/>
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script>
            $(function() {
                $("#birthdate").datepicker({
                    title: "Birth Date"
                });
            });            
        </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="#">Profile</a></li>
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
                                
                                <% if (acc_level == 3) { %>
                                <h1><span class="glyphicon glyphicon-info-sign" aria-hidden="true" style="color:#428bca"></span>
                                    <u><i>Student's Information</u></i></h1>
                                <br>
                                <% } %>
                                
                                <% if (acc_level == 2) { %>
                                <h1><span class="glyphicon glyphicon-info-sign" aria-hidden="true" style="color:#428bca"></span>
                                    <u><i>Teacher's Information</u></i></h1>
                                <br>
                                <% } %>
                                
                                 <% if (acc_level == 4) { %>
                                <h1><span class="glyphicon glyphicon-info-sign" aria-hidden="true" style="color:#428bca"></span>
                                    <u><i>Parent's Information</u></i></h1>
                                <br>
                                <% } %>
                                
                                <form action="management?action=changeProfile" method="POST">
                                    <div class="panel panel-info" style="font-size:16px;">
                                    <!-- List group -->
                                        <div class="panel-body">
                                            

                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Name </b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"> <b><i><% out.print(user.getName()); %></i></b></span>
                                                </div>
                                                </div>
                                            </li>
                                                
                                                            
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Birth Date </b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getBirthdate()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                                                    
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Gender</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getGender()); %></b</i></span>
                                                </div>
                                                </div>
                                            </li>
                                            
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Address</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getAddress()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                                        
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Email</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getEmail()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                                        
                                             
                                                        
                                            <% if(request.getAttribute("class") != null) { %>
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Class</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getClass()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                             
                                            <% } %>
                                            
                                            <% if (request.getAttribute("nic") != null) { %>
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>NIC</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getNic()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                             
                                            <% } %>
                                            
                                             <% if(request.getAttribute("qualifications") != null) { %>
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Qualifications</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getQualifications()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                             
                                            <% } %>
                                            
                                             <% if(request.getAttribute("occupation") != null) { %>
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Occupation</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getOccupation()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                             
                                            <% } %>
                                            
                                             <% if(request.getAttribute("tp") != null) { %>
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b>Telephone Number</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <span style="color:#428bca"><i><b><% out.print(user.getPhone()); %></b></i></span>
                                                </div>
                                                </div>
                                            </li>
                                             
                                            <% } %>
                                            
                                             <% if(request.getAttribute("nic") != null) { %>
                                             <li class="list-group-item"><b>NIC: <b><% out.print(user.getNic()); %></li>  
                                            <% } %>
                                            
                                             <% if(request.getAttribute("occupation") != null) { %>
                                             <li class="list-group-item"><b>Occupation: <b><% out.print(user.getOccupation()); %></li>  
                                            <% } %>
                                            
                                             <% if(request.getAttribute("tp") != null) { %>
                                             <li class="list-group-item"><b>NIC: <b><% out.print(user.getPhone()); %></li>  
                                            <% } %>
                                            
                                             <% if(request.getAttribute("qualifications") != null) { %>
                                             <li class="list-group-item"><b>NIC: <b><% out.print(user.getQualifications()); %></li>  
                                            <% } %>
                                            
                                            <br>
                                            <li class="list-group-item">
                                                <div class="row">
                                                <div class="col-md-4">
                                                    <b></b> Password</b>
                                                </div>
                                                <div class="col-md-4">
                                                    <button class="btn btn-danger"><i>Change Password</i></button>
                                                </div>
                                            </div>
                                            </li>
                                            
                                           
                                            
                                           
                                            
                                            
                                            
                                          
                                            
                                        </div>
                                    </div>
                                            
                                            
                                </form>
                                            
                                            
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
