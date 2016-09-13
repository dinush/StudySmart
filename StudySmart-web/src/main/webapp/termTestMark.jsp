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
                $('#error').hide();
                
                getClasses();                
                getStudents();
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
                            getStudents();
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
                            var tbl = document.getElementById("tbl");
                            tbl.innerHTML = '';
                            for(var i=0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].studentid + "</td>";
                                row += "<td>" + data[i].studentname + "</td>";
                                row += "<td><input required class=marks type=number name='" + data[i].studentid + "' value='";
                                if (data[i].marks !== null) {
                                    row += data[i].marks;
                                }
                                row += "'/></td>";
                                tbl.innerHTML += row;
                            }
                        });
            }
            
            function sendPacket() {
                var packet = {};
                packet['meta'] = {};
                packet['meta']['classid'] = $('#class').val();
                packet['meta']['subjectid'] = $('#subject').val();
                packet['meta']['term'] = $('#term').val();
                packet['values'] = [];
                var elem_marks = document.getElementsByClassName("marks");
                for (var i=0; i < elem_marks.length; i++) {
                    packet['values'].push({});
                    packet['values'][i]['studentid'] = elem_marks[i].name;
                    packet['values'][i]['marks'] = $(elem_marks[i]).val();
                }
                
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "StudentManager?action=termtestmarkssave",
                    data: JSON.stringify(packet),
                    contentType: "text/plain"
                })
                        .done(function() {
                            alert("success");
                        });
                        
                return false;
            }
        </script>


    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
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
                                <form onsubmit="return sendPacket()">
                                <div style="float: left;">
                                    <select name="class" class="form-control" id="class" onchange="getSubjects()"></select>
                                </div>
                                <div style="float: left;">
                                    <select name="subject" class="form-control" id="subject"></select>
                                </div>
                                <div style="float: left">
                                    <select id="term" name="term" class="form-control" onchange="getStudents()">
                                        <option value="1">Term 1</option>
                                        <option value="2">Term 2</option>
                                        <option value="3">Term 3</option>
                                    </select>
                                </div>
                                <div>
                                    <button class="btn btn-primary" onclick="getStudents()">Load Students</button>
                                </div>
                                <br>
                                
                                

                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Student ID</th>
                                                <th>Student Name</th>
                                                <th>Marks</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbl">
                                            
                                        </tbody>
                                    </table>
                                    <button type="submit" class="btn btn-default">Finish</button>
                                
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
