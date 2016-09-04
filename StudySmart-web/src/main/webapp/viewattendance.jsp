<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@page import="java.util.Date"%>
<%@page import="utils.Utils"%>
<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/bootstrap-datepicker3.standalone.min.css" />
        <script src="js/jquery-2.0.0.js"></script>        
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script src="js/Chart/Chart.js"></script>
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                $("#from").datepicker({
                    daysOfWeekDisabled: [0, 6],
                    title: "From",
                    todayBtn: "linked",
                    todayHighlight: true,
                    endDate: new Date()
                });
                $("#to").datepicker({
                    daysOfWeekDisabled: [0, 6],
                    title: "To",
                    todayBtn: "linked",
                    todayHighlight: true,
                    endDate: new Date()
                });
                loadStudents();
            });
            function loadStudents() {
                var parentid = '<% out.print(user.getUsername()); %>';
                $.ajax({
                    url: "ws/rest/parent/" + parentid + "/students",
                    async: true
                })
                        .done(function (data) {
                            var student_view = document.getElementById("student");
                            student_view.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>" + data[i].name + " (" + data[i].id + ")</option>";
                                student_view.innerHTML += row;
                            }
                            loadAttendance();
                        })
            }

            function loadAttendance() {

                if ($('#from').val() > $('#to').val()) {
                    alert('Invalid date period');
                }

                var from = encodeURIComponent($("#from").val());
                var to = encodeURIComponent($("#to").val());
                var studentid = $('#student').val();
                $.ajax({
                    url: "ws/rest/attendance/" + studentid + "/" + from + "/" + to,
                    async: true
                })
                        .done(function (data) {
                            var tbl = document.getElementById("tbl_data");
                            tbl.innerHTML = '';
                            var attended = 0;
                            var absent = 0;
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].date + "</td>";
                                row += "<td>";
                                if (data[i].attended) {
                                    row += "Yes";
                                    attended++;
                                } else {
                                    row += "No";
                                    absent++;
                                }
                                row += "</td>";
                                row += "<td>" + data[i].markedby + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                            }
                            
                            var nDays = attended + absent;
                            var chart_data = [
                                (attended/nDays)*360,
                                (absent/nDays)*360
                            ];
                            if(nDays === 0) {
                                chart_data = null;
                            }
                            drawChart(chart_data);
                        });
            }

            function drawChart(data) {
                if(data === null) return;
                
                var chart_canvas = document.getElementById("att_chart");
                var chart = new Chart(chart_canvas, {
                    type: "pie",
                    data: {
                        labels: [
                            "Attended",
                            "Absent"
                        ],
                        datasets: [
                            {
                                data: data,
                                backgroundColor: [                                    
                                    "#36A2EB",
                                    "#FF6384"
                                ],
                                hoverBackgroundColor: [                                    
                                    "#36A2EB",
                                    "#FF6384"
                                ]
                            }]
                    }
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
            <li><a href="index.jsp">Home</a></li>
            <li>View Attendance</li>
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
                                From <input type="text" id="from" name="from" value="<% out.print(Utils.getFormattedDateString(new Date())); %>" onchange="loadAttendance()">
                                To <input type="text" id="to" name="to" value="<% out.print(Utils.getFormattedDateString(new Date())); %>" onchange="loadAttendance()">
                                <% if (acc_level < 3) { %>
                                <div class="form-group">
                                    <label for="exampleInputName">Student Name: </label>
                                    <input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
                                </div>
                                <% } %>
                                <div class="panel panel-primary" style="margin-top:16px;">

                                    <div class="panel-heading">Attendance Details</div>
                                    <div class="panel-body">
                                        <% // User student = (User) request.getAttribute("student"); %>
                                        Student: 
                                        <select name="student" id="student" onchange="loadAttendance()"></select>
                                        <!--Chart-->
                                        <canvas id="att_chart" height="100"></canvas>
                                    </div>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Attended?</th>
                                                <th>Marked By</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbl_data">
                                        </tbody>
                                    </table>
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
    <script>

    </script>
</body>

</html>
