<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush


--%>

<%@page import="java.util.HashMap"%>
<%@page import="lk.studysmart.apps.models.Attendance"%>
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
    DateFormat format = new SimpleDateFormat("MMMM dd yyyy");
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
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                getClasses();
            });
            
            function getClasses() {
                $.ajax({
                    url: "ws/rest/classes",
                    async: true
                })
                        .done (function(data){
                            var elem_cls = document.getElementById("class");
                            elem_cls.innerHTML = '';
                            for (var i=0; i<data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>Grade " + data[i].name + "</option>";
                                elem_cls.innerHTML += row;
                            }
                            getAttendance();
                        })
            }
            
            function getAttendance() {
                var cls_id = $('#class').val();
                $.ajax({
                    url: "ws/rest/student/attendance/" + cls_id,
                    async: true
                })
                        .done(function(data) {
                            // set today
                            var date = document.getElementById("date");
                            date.innerHTML = new Date();
                            // previuos marker, if any
                            var prev_marker = document.getElementById("marked-user-name");
                            if(data[0].marked_name !== "n/a") {
                                prev_marker.innerHTML = "Previously marked by: " + data[0].marked_name;
                            } else {
                                prev_marker.innerHTML = '';
                            }
                            
                            var tbl_data = document.getElementById("tbl_data");
                            tbl_data.innerHTML = '';
                            for (var i=1; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].id + "</td>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "<td><input class='att_details' type=checkbox name='" + data[i].id + "' ";
                                if (data[i].attended || data[i].controlled)
                                    row += "checked";
                                row += "/></td>";
                                row += "</tr>";
                                tbl_data.innerHTML += row;
                            }
                        });
            }
            
            function sendPacket() {
                var packet = {};
                packet['meta'] = {};
                packet['meta']['classid'] = $('#class').val();
                packet['values'] = [];
                var att_details = document.getElementsByClassName("att_details");
                for (var i=0; i < att_details.length; i++) {
                    packet['values'].push({});
                    packet['values'][i]['studentid'] = att_details[i].name;
                    if($(att_details[i]).is(":checked")) {
                        packet['values'][i]['attended'] = 1;
                    }else {
                        packet['values'][i]['attended'] = 0;
                    }
                }
                
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "StudentManager?action=attendancemarked",
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
                                <div class="row">
                                    <div class="col-lg-3">
                                        <select name="class" class="form-control" id="class" onchange="getAttendance()">
                                        </select>
                                    </div>
                                    
                                    <div class="col-lg-2">
                                        <button type="submit" class="btn btn-primary">Load Students</button>
                                    </div>
                                    </form>
                                </div>
                                <br>
                                
                                <h3>Attendance Details for <span id="date"></span></h3>
                                
                                <h5 id="marked-user-name"></h5>
                                
                                <form onsubmit="return sendPacket()">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Student ID</th>
                                                <th>Student Name</th>
                                                <th>Attended?</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbl_data">
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
