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

<%
    if (request.getParameter("assignment") == null) {
        return;
    }
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
            var assignment = '<% out.print(request.getParameter("assignment")); %>';
            var barChart = null;

            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                getStudents();
            });

            function getStudents() {
                var chartLabels = [];
                var chartValues = [];

                var tbl = document.getElementById("tbl_data");
                tbl.innerHTML = '';

                $.ajax({
                    url: "ws/acadamic/assignment/marks/" + assignment,
                    async: true
                })
                        .done(function (data) {
                            // Set breadcrumb element
                            document.getElementById("path_name").innerHTML = assignment;
                            
                            var stats = document.getElementById("elem_stat");
                            var tbl = document.getElementById("tbl_data");
                            stats.innerHTML = '';
                            tbl.innerHTML = '';
                            
                            document.getElementById("heading").innerHTML = "Assignment: " + assignment;
                            
                            // Stats
                            var stat_html = "<p>Maximum marks for this assignment: <b>" + data.max + "</b></p>";
                            stat_html += "<p>Highest marks: <b>" + data.highest + "</b></p>";
                            stat_html += "<p>Lowest marks: <b>" + data.lowest + "</b></p>";
                            stat_html += "<p>Mean: <b>" + data.mean + "</b></p>";
                            stat_html += "<p>Standard Deviation: <b>" + data.standard_deviation + "</b></p>";
                            stats.innerHTML = stat_html;
                            
                            // Individual marks
                            for( var i=0 ; i<data.marks.length ; i++ ) {
                                var marks = data.marks[i];
                                var row = "<tr>";
                                row += "<td>" + marks.student_username + "</td>";
                                row += "<td>" + marks.student_name + "</td>";
                                row += "<td>" + marks.marks + "</td>";
                                row += "<td>" + marks.comment + "</td>";
                                row += "<td>" + marks.author_name + "</td>";
                                tbl.innerHTML += row;
                                
                                // Chart data
                                chartLabels.push(marks.student_name);
                                chartValues.push(marks.marks);
                            }
                            
                            var data2 = {
                                labels: chartLabels,
                                datasets: [
                                    {
                                        label: assignment,
                                        data: chartValues,
                                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                        borderColor: 'rgba(54, 162, 235, 1)'
                                    }
                                ]
                            };
                            updateChart(data2, data.max);
                        });
            }

            function updateChart(data2, max) {
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
                                        suggestedMax: max
                                    }
                                }]
                        }
                    },
                    data: data2
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
                <li><a href="ViewAssignments.jsp">Assignment Marks</a></li>
                <li id="path_name"></li>
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
                                    
                                    <h2 id="heading"></h2>

                                    <!--Statistics-->
                                    <div class="well" style="margin-top: 10px; height: 275px;">
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
                                            <th>Student Username</th>
                                            <th>Student Name</th>
                                            <th>Marks</th>
                                            <th>Comment</th>
                                            <th>Marked By</th>
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
