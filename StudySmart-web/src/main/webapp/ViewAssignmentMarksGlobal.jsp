<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush


--%>

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



<%    Date date = new Date();
    DateFormat format = new SimpleDateFormat("yyyy/MM/dd");
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
        <script src="js/Chart/Chart.js"></script>
        <script type = "text/javascript" >
            var barChart = null;

            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                getClasses();
            });
            
            var classid;
            var subjectid;
            var assignmentid;
            
            function getClasses() {
                $.ajax({
                    url: "ws/rest/classes",
                    async: true
                })
                        .done(function (data) {
                            var sel_clz = document.getElementById("class2");
                            sel_clz.innerHTML = '';
                            for (var i=0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>Class " + data[i].name + "</option>";
                                sel_clz.innerHTML += row;
                                classid = data[0].id;
                            }
                            getSubjects();
                        });
            }

            function getSubjects() {
                $.ajax({
                    url: "ws/rest/subjects/" + classid,
                    async: true
                })
                        .done(function (data) {
                            var sel_sbj = document.getElementById("subject");
                            sel_sbj.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                                sel_sbj.innerHTML += row;
                                subjectid = data[0].id;
                            }
                            getAssignments();
                        });
            }
            
            function getAssignments() {
                $.ajax({
                    url: "ws/acadamic/assignments/" + classid + "/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            var tbl = document.getElementById("tbl_data");
                            tbl.innerHTML = '';
                            for (var i=0; i < data.length; i++) {
                                var row = "<tr class='hover'>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                                assignmentid = data[0].name;
                            }
                        });
            }

            function getStudents() {
                var chartLabels = [];
                var chartValues = [[], [], []];

                var tbl = document.getElementById("tbl_data");
                tbl.innerHTML = '';

                $.ajax({
                    url: "ws/rest/student/" + $("#class2").val() + "/" + $("#subject").val() ,
                    async: true
                })
                        .done(function (data) {
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].username + "</td>";
                                row += "<td>" + data[i].name + "</td>";
                                chartLabels.push(data[i].name);
                                // Loop through avalible terms. 3 max
                                for (var j = 0; j < data[i].term_marks.length; j++) {
                                    var marks = data[i].term_marks[j].marks;
                                    row += "<td>" + marks + "</td>";
                                    chartValues[j].push(marks)
                                }
                                row += "</tr>";
                                tbl.innerHTML += row;
                            }
                            var data = {
                                labels: chartLabels,
                                datasets: [
                                    {   // Term 1 marks
                                        label: "Term 1",
                                        data: chartValues[0],
                                        fill: false,
                                        lineTension: 0.1,
                                        backgroundColor: "rgba(75,192,192,0.4)",
                                        borderColor: "rgba(75,192,192,1)",
                                        borderCapStyle: 'butt',
                                        borderDash: [],
                                        borderDashOffset: 0.0,
                                        borderJoinStyle: 'miter',
                                        pointBorderColor: "rgba(75,192,192,1)",
                                        pointBackgroundColor: "#fff",
                                        pointBorderWidth: 1,
                                        pointHoverRadius: 5,
                                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                                        pointHoverBorderColor: "rgba(220,220,220,1)",
                                        pointHoverBorderWidth: 2,
                                        pointRadius: 1,
                                        pointHitRadius: 10,
                                        spanGaps: false,
                                    },
                                    {   // Term 2 marks
                                        label: "Term 2",
                                        data: chartValues[1],
                                        fill: false,
                                        lineTension: 0.1,
                                        backgroundColor: "rgba(102,255,51,0.4)",
                                        borderColor: "rgba(102,255,51,1)",
                                        borderCapStyle: 'butt',
                                        borderDash: [],
                                        borderDashOffset: 0.0,
                                        borderJoinStyle: 'miter',
                                        pointBorderColor: "rgba(102,255,51,1)",
                                        pointBackgroundColor: "#fff",
                                        pointBorderWidth: 1,
                                        pointHoverRadius: 5,
                                        pointHoverBackgroundColor: "rgba(102,255,51,1)",
                                        pointHoverBorderColor: "rgba(220,220,220,1)",
                                        pointHoverBorderWidth: 2,
                                        pointRadius: 1,
                                        pointHitRadius: 10,
                                        spanGaps: false,
                                    },
                                    {   // Term 3 marks
                                        label: "Term 3",
                                        data: chartValues[2],
                                        fill: false,
                                        lineTension: 0.1,
                                        backgroundColor: "rgba(255,102,102,0.4)",
                                        borderColor: "rgba(255,102,102,1)",
                                        borderCapStyle: 'butt',
                                        borderDash: [],
                                        borderDashOffset: 0.0,
                                        borderJoinStyle: 'miter',
                                        pointBorderColor: "rgba(255,102,102,1)",
                                        pointBackgroundColor: "#fff",
                                        pointBorderWidth: 1,
                                        pointHoverRadius: 5,
                                        pointHoverBackgroundColor: "rgba(255,102,102,1)",
                                        pointHoverBorderColor: "rgba(220,220,220,1)",
                                        pointHoverBorderWidth: 2,
                                        pointRadius: 1,
                                        pointHitRadius: 10,
                                        spanGaps: false,
                                    }
                                ]
                            };
                            updateChart(data);
                        });
            }

            function updateChart(data) {
                if (barChart !== null) {
                    barChart.destroy();
                }

                var canvas = document.getElementById("chart");
                barChart = new Chart(canvas, {
                    type: "line",
                    options: {
                        scales: {
                            yAxes: [{
                                    ticks: {
                                        min: 0,
                                        beginAtZero: true,
                                        suggestedMax: 100
                                    }
                                }]
                        }
                    },
                    data: data
                });
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
            <li>View Assignment Marks</li>
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
                                    <div class="flat-panel">
                                        <div class="flat-panel-head">
                                            Class
                                        </div>
                                        <div class="flat-panel-body">
                                            <select id="class2" name="class2" class="form-control" onchange="classid = this.value; getSubjects()">

                                            </select>
                                        </div>
                                    </div>

                                    <div class="flat-panel">
                                        <div class="flat-panel-head">
                                            Subject
                                        </div>
                                        <div class="flat-panel-body">
                                            <select id="subject" name="subject" class="form-control" onchange="subjectid = this.value; getStudents()">

                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <h3>List of assignments as of <% out.print(utils.Utils.getFormattedDateString(new Date())); %></h3>
                                <div class="row">
                                    <table class="table table-hover">
                                        <thead>
                                        <th>Assignment Name</th>
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
</body>
</html>
