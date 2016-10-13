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
                            }
                            getSubjects(data[0].id);
                        });
            }

            function getSubjects(clz) {
                $.ajax({
                    url: "ws/rest/subjects/" + clz,
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
                var chartLabels = [];
                var chartValues = [[], [], []];

                var tbl = document.getElementById("tbl_data");
                tbl.innerHTML = '';

                $.ajax({
                    url: "ws/rest/student/" + $("#class2").val() + "/" + $("#subject").val() ,
                    async: true
                })
                        .done(function (data) {
                            stats = data.stats;
                            raw = data.raw;                            
                            // Processing raw data
                            for (var i = 0; i < raw.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + raw[i].username + "</td>";
                                row += "<td>" + raw[i].name + "</td>";
                                chartLabels.push(raw[i].name);
                                // Loop through avalible terms. 3 max
                                for (var j = 0; j < raw[i].term_marks.length; j++) {
                                    var marks = raw[i].term_marks[j].marks;
                                    row += "<td>" + marks + "</td>";
                                    chartValues[j].push(marks)
                                }
                                row += "</tr>";
                                tbl.innerHTML += row;
                            }
                            // Processing statistics
                            var elem_stat = document.getElementById("elem_stat");
                            elem_stat.innerHTML = '';
                            for( var i=0 ; i<stats.length ; i++ ) {
                                var elem = "<div class='col-md-4 white-block'>";
                                elem += "<h4>Term " + stats[i].term + "</h4>";
                                elem += "Mean: <b>" + stats[i].mean + "</b><br />";
                                elem += "Standard Deviation: <b>" + stats[i].standard_deviation + "</b>";
                                elem += "</div>";
                                elem_stat.innerHTML += elem;
                            }
                            var data = {
                                labels: chartLabels,
                                datasets: [
                                    {   // Term 1 marks
                                        label: "Term 1",
                                        data: chartValues[0],
                                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                        borderColor: 'rgba(54, 162, 235, 1)'
                                    },
                                    {   // Term 2 marks
                                        label: "Term 2",
                                        data: chartValues[1],
                                        backgroundColor: 'rgba(255, 206, 86, 0.6)',
                                        borderColor: 'rgba(255, 206, 86, 1)'
                                    },
                                    {   // Term 3 marks
                                        label: "Term 3",
                                        data: chartValues[2],
                                        backgroundColor: 'rgba(255, 99, 132, 0.6)',
                                        borderColor: 'rgba(255, 99, 132, 1)'
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
                    type: "bar",
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
            <li>View Term Test Marks</li>
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
                                            <select id="class2" name="class2" class="form-control" onchange="getSubjects(this.value)">

                                            </select>
                                        </div>
                                    </div>

                                    <div class="flat-panel">
                                        <div class="flat-panel-head">
                                            Subject
                                        </div>
                                        <div class="flat-panel-body">
                                            <select id="subject" name="subject" class="form-control" onchange="getStudents()">

                                            </select>
                                        </div>
                                    </div>

                                </div>
                                
                                <!--Statistics-->
                                <div class="well" style="margin-top: 10px; height: 240px;">
                                    <h3>Statistics</h3>
                                    <hr>
                                    <div id="elem_stat">
                                    <!--Filled by JS-->
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <h3>Individual Students' Marks View</h3>
                                    <!--Chart-->
                                    <canvas id="chart" height="200px"></canvas>
                                </div>
                                <div class="row">
                                    <table class="table table-striped">
                                        <thead>
                                        <th>Username</th>
                                        <th>Name</th>
                                        <th>Term 1</th>
                                        <th>Term 2</th>
                                        <th>Term 3</th>
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
