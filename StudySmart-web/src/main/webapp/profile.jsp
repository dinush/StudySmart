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
                                <form action="management?action=changeProfile" method="POST">
                                    <div class="form-group">
                                        <label for="username">Username</label>
                                        <input required type="text" class="form-control" id="username" name="username" readonly value="<% out.print(request.getAttribute("username"));%>"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Name</label>
                                        <input required type="text" class="form-control" id="name" name="name" value="<% out.print(request.getAttribute("name"));%>"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <button class="btn btn-default">change</button>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input required type="email" class="form-control" id="email" name="email" value="<% out.print(request.getAttribute("email"));%>"/>
                                    </div>
                                    <% if(request.getAttribute("class") != null) { %>
                                    <div class="form-group">
                                        <label for="class">Class</label>
                                        <input required type="text" class="form-control" name="class" id="class" readonly value="<% out.print(request.getAttribute("class"));%>"/>
                                    </div>
                                    <% } %>
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <select id="gender" name="gender">
                                            <option value="male" <% if(request.getAttribute("gender") == "male") { %>selected<% } %>>Male</option>
                                            <option value="female" <% if(request.getAttribute("gender") == "female") { %>selected<% } %>>Female</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="birthdate">Birth Date</label>
                                        <input required type="date" class="form-control" name="birthdate" id="birthdate" value="<% out.print(request.getAttribute("birthdate") != null ? request.getAttribute("birthdate") : ""); %>" />
                                    </div>
                                    <% if (request.getAttribute("nic") != null) {%>
                                    <div class="form-group">
                                        <label for="nic">NIC</label>
                                        <input required type="text" class="form-control" name="nic" id="nic" value="<% out.print(request.getAttribute("nic")); %>" />
                                    </div>
                                    <% } %>
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <input required type="text" class="form-control" name="address" id="address" value="<% out.print(request.getAttribute("address") != null ? request.getAttribute("address") : ""); %>"/>
                                    </div>
                                    <% if (request.getAttribute("occupation") != null) { %>
                                    <div class="form-group">
                                        <label for="occupation">Occupation</label>
                                        <input required type="text" class="form-control" name="occupation" id="occupation" value="<% out.print(request.getAttribute("occupation")); %>"/>
                                    </div>
                                    <% } %>
                                    <% if (request.getAttribute("tp") != null) { %>
                                    <div class="form-group">
                                        <label for="phone">TP</label>
                                        <input required type="tel" class="form-control" name="tp" id="tp" value="<% out.print(request.getAttribute("tp")); %>"/>
                                    </div>
                                    <% } %>
                                    <% if (request.getAttribute("qualifications") != null) { %>
                                    <div class="form-group">
                                        <label for="qualifications">Qualifications</label>
                                        <input required type="text" class="form-control" name="qualifications" id="qualifications" value="<% out.print(request.getAttribute("qualifications")); %>"/>
                                    </div>
                                    <% } %>
                                    <input type="submit" value="Change" class="btn btn-default"/>
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
