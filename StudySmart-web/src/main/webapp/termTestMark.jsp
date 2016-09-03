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
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});

                getClasses();
                $('#error').hide();
            });

            function getClasses() {
                $.ajax({
                    url: "ws/rest/teacher/<% out.print(user.getUsername()); %>/classes",
                    async: true
                })
                        .done(function (data) {
                            var sel_cls = document.getElementById("class");
                            sel_cls.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                                sel_cls.innerHTML += row;
                            }
                            getSubjects();
                        })
            }

            function getSubjects() {
                var classid = $('#class').val();
                $.ajax({
                    url: "ws/rest/teacher/<% out.print(user.getUsername()); %>/subjects/" + classid,
                    async: true
                })
                        .done(function (data) {
                            var sel_sbj = document.getElementById("subject");
                            sel_sbj.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                                sel_sbj.innerHTML += row;
                            }
                        });
            }
            
            function getStudents() {
                var classid = $('#class').val();
                var subjectid = $('#subject').val();
                var term = $('#term').val();
                if(classid === '' || subjectid === '' || term === '') {
                    return;
                }
                
                $.ajax({
                    url: "ws/rest/termmarks/all/" + term + "/" + classid + "/" + subjectid,
                    async: true
                })
                        .done(function(data){
                            
                        });
            }
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
                                <div style="float: left;">
                                    <select name="class" class="form-control" id="class" onchange="getSubjects()"></select>
                                </div>
                                <div style="float: left;">
                                    <select name="subject" class="form-control" id="subject"></select>
                                </div>
                                <div style="float: left">
                                    <select name="term" class="form-control">
                                        <option value="1">Term 1</option>
                                        <option value="2">Term 2</option>
                                        <option value="3">Term 3</option>
                                    </select>
                                </div>
                                <div>
                                    <button class="btn btn-primary" onclick="">Load Students</button>
                                </div>
                                <br>
                                <!--Error-->
                                <div id="error" class="alert alert-danger" role="alert" >                                    
                                    <strong>Error : </strong> Record already exists. You might want to edit it.
                                </div>
                                
                                
                                <% if (request.getAttribute("selected") != null) { %>
                                <h3>Grade <% out.print(request.getAttribute("grade")); %> Class <%  out.print(String.valueOf(request.getAttribute("subclass")).toUpperCase()); %> term test <% out.print(request.getAttribute("term")); %> marks for <% out.print(request.getAttribute("subjectname")); %></h3>
                                <form action="StudentManager?action=termtestmarkssave&subjectid=<% out.print(request.getAttribute("subjectid")); %>&classid=<% out.print(request.getAttribute("classid")); %>&term=<% out.print(request.getAttribute("term")); %>" method="POST">

                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Student ID</th>
                                                <th>Student Name</th>
                                                <th>Marks</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="row" items="${marks}">
                                                <tr>
                                                    <td>${row.key.getUsername()}</td>
                                                    <td>${row.key.getName()}</td>
                                                    <td><input type="number" name="${row.key.getUsername()}" required="true" value="${row.value != null ? row.value : ""}"/></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <button type="submit" class="btn btn-default">Finish</button>
                                </form>
                                <% }%>

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
