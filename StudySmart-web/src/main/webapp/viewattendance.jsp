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
        <link rel="stylesheet" href="css/selectize.bootstrap2.css" />
        <script src="js/jquery-2.0.0.js"></script>        
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script src="js/Chart/Chart.js"></script>
        <script src="js/selectize.min.js"></script>
        <script type = "text/javascript" >
            var barChart = null;
            var doughnutChart = null;

            $(function () {
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
            <% if (user.getLevel() == 4) { %>
                loadStudentsByParent();
                initDoughnutChart();
            <% } else if (user.getLevel() == 3) { %>
                loadAttendance();
                initDoughnutChart();
            <% } else { %>
                loadClasses();
            <% } %>
            });

            function loadStudentsByParent() {
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
                        });
            }

            function initDoughnutChart() {
                var canvas = document.getElementById("att_chart");
                doughnutChart = new Chart(canvas, {
                    type: "doughnut",
                    data: {
                        labels: [
                            "Attended",
                            "Absent"
                        ],
                        datasets: [
                            {
                                data: [],
                                backgroundColor: [
                                    "#36A2EB",
                                    "#FF6384"
                                ],
                                hoverBackgroundColor: [
                                    "#36A2EB",
                                    "#FF6384"
                                ]
                            }
                        ]
                    }
                });
            }

            function initBarChart(data) {
                var canvas = document.getElementById("att_chart");
                barChart = new Chart(canvas, {
                    type: "line",
                    options:
                            {
                                scales:
                                        {
                                            xAxes: [{
                                                    display: false
                                                }],
                                            yAxes: [{
                                                    ticks: {
                                                        min: 0,
                                                        beginAtZero: true
                                                    }
                                                }]
                                        }
                            },
                    data: data
                });
            }

            function loadAttendance() {

                var studentid;
            <% if (user.getLevel() == 3) { %>
                studentid = '<% out.print(user.getUsername()); %>' // Get the studentid according to user level
            <% } else if (user.getLevel() == 4) { %>
                studentid = $("#student").val();
            <% }%>

                var fromDate = new Date($('#from').val());
                var toDate = new Date($('#to').val());
                if (fromDate > toDate) {
                    alert('Invalid date period');
                    return;
                }

                var from = encodeURIComponent($("#from").val());
                var to = encodeURIComponent($("#to").val());
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
                                    row += "<span style='color:blue';>Yes</span>";
                                    attended++;
                                } else {
                                    row += "<span style='color:red';>No</span>";
                                    absent++;
                                }
                                row += "</td>";
                                row += "<td>" + data[i].markedby + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                            }

                            var nDays = attended + absent;
                            var chart_data = [
                                (attended / nDays) * 360,
                                (absent / nDays) * 360
                            ];
                            if (nDays === 0) {
                                chart_data = null;
                            }
                            updateDoughnutChart(chart_data);
                        });
            }

            function updateDoughnutChart(data) {
                if (data === null) {
                    return;
                }
                
                if (doughnutChart === null) {
                    console.log("Chart object uninitialized");
                    return;
                }
                // Calculate the percentages
                var attended = data[0];
                var absent = data[1];
                var attended_percentage = ( (attended / (attended + absent)) * 100 ).toFixed(2);
                var absent_percentage = ( (absent / (attended + absent)) * 100 ).toFixed(2);
                var doughnut_labels = [
                    "Attended (" + attended_percentage + " %)",
                    "Absent (" + absent_percentage + " %)"
                ];

                doughnutChart.data.datasets[0].data = data;
                doughnutChart.data.labels = doughnut_labels;
                doughnutChart.update();
            }

            function loadClasses() {
                $.ajax({
                    url: "ws/rest/classes",
                    async: true
                })
                        .done(function (data) {
                            var sel_cls = document.getElementById("class");
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'> Grade" + data[i].name + "</option>";
                                sel_cls.innerHTML += row;
                            }
                            studentsInClassForPeriod(data[0].id);
                        });
            }

            function studentsInClassForPeriod(classid) {
                if (classid === undefined)
                    classid = $('#class').val();
                //Construct the url
                var RESTurl = "ws/rest/student/attendance/";
                RESTurl += classid + "/";
                RESTurl += encodeURIComponent($("#from").val()) + "/";
                RESTurl += encodeURIComponent($("#to").val());

                // Chart vars
                var chartLabels = [];
                var chartData = [];

                $.ajax({
                    url: RESTurl,
                    async: true
                })
                        .done(function (data) {
//                            data = JSON.parse(data);
                            var tbl_data = document.getElementById("tbl_data");
                            tbl_data.innerHTML = '';
                            //Loop through each student
                            for (var i = 0; i < data.length; i++) {

                                var url = "StudentManager?action=SingleStudentAttendance&user=" + data[i].username + "&from=" + encodeURIComponent($('#from').val()) + "&to=" + encodeURIComponent($('#to').val());
                                var row = "<tr>";
                                row += "<td>" + data[i].username + "</td>";
                                row += "<td>" + data[i].name + "</td>";

                                //Get number of attended days
                                var attDetails = data[i].attendance;
                                var nAttDays = 0;
                                //Loop throught each date
                                for (var j = 0; j < attDetails.length; j++) {
                                    if (attDetails[j].attended) {
                                        nAttDays++;
                                    }
                                }

                                //Get attendance as percentage for given time period
                                var perc = (nAttDays / attDetails.length) * 100;
                                if (!isNaN(perc)) {
                                    row += "<td>" + perc.toFixed(0) + "% (" + nAttDays + "/" + attDetails.length + " days)</td>";
                                    chartData.push(perc);
                                    chartLabels.push(data[i].name + " (" + data[i].username + ")");
                                } else {
                                    row += "<td>N/A</td>";
                                }
                                row += "<td><a href='" + url + "' target='_blank'>view info</a></td>";
                                row += "</tr>";
                                tbl_data.innerHTML += row;
                            }

                            //Construct chart data
                            var data = {
                                labels: chartLabels,
                                datasets: [
                                    {
                                        label: $('#from').val() + " - " + $('#to').val(),
                                        fill: true,
                                        backgroundColor: "rgba(75,192,192,0.4)",
                                        lineTension: 0.1,
                                        borderCapStyle: 'butt',
                                        borderDashOffset: 0.0,
                                        pointBorderColor: "rgba(75,192,192,1)",
                                        pointBackgroundColor: "#fff",
                                        pointBorderWidth: 1,
                                        pointHoverRadius: 5,
                                        pointHitRadius: 10,
                                        snapGaps: false,
                                        data: chartData
                                    }
                                ]
                            };
                            updateBarChart(data);
                        });
            }

            function updateBarChart(data) {
                if (barChart !== null)
                    barChart.destroy();

                if (data !== null)
                    initBarChart(data);
            }
        </script>
        <title>StudySmart</title>
    </head>
    <body>
        <div class="container">
            <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
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
                                    <div class="panel panel-primary" >

                                        <div class="panel-heading">Attendance Details</div>
                                        <div class="panel-body">

                                            <div class="well">
                                                <h4>Filter Results</h4>

                                                <% if (user.getLevel() == 4) { %>
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <label for="student">Student:</label>
                                                        <select class="form-control" name="student" id="student" onchange="loadAttendance()"></select>
                                                    </div>
                                                </div>
                                                <% }%>
                                                <% if (user.getLevel() < 3) { %>
                                                <div class="form-inline">

                                                    <div class="form-group">
                                                        <label for="class">Class:</label>
                                                        <select name="class" id="class" class="form-control" onchange="studentsInClassForPeriod(this.value)">
                                                        </select>
                                                    </div>
                                                </div>
                                                <% } %>
                                                <div class="form-inline" style="margin-top:10px;">
                                                    <div class="form-group">
                                                        <label for="from">From:</label>
                                                        <input class="form-control" type="text" id="from" name="from" value="<% out.print(Utils.getFormattedDateStringNotFriendly(new Date())); %>" 
                                                               onchange="<% if (user.getLevel() < 3) {
                                                                        out.print("studentsInClassForPeriod(undefined)");
                                                                    } else {
                                                                        out.print("loadAttendance()");
                                                                    } %>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="from">To:</label>
                                                        <input class="form-control" type="text" id="to" name="to" value="<% out.print(Utils.getFormattedDateStringNotFriendly(new Date()));%>"
                                                               onchange="<% if (user.getLevel() < 3) {
                                                                        out.print("studentsInClassForPeriod(undefined)");
                                                                    } else {
                                                                        out.print("loadAttendance()");
                                                                    } %>">
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <!--Chart-->
                                        <canvas id="att_chart" height="100"></canvas>

                                        <% if (user.getLevel() >= 3) { %>
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
                                        <% } else { %>
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Student ID</th>
                                                    <th>Student Name</th>
                                                    <th>Attendance %</th>
                                                    <th>Detailed Info</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbl_data">
                                            </tbody>
                                        </table>
                                        <% }%>

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
