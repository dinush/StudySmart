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
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/Chart/Chart.js"></script>
        <script type = "text/javascript" >
            var barChart = null;
            var student_username;
            var student_name;
            <% if (user.getLevel() == 3) { %>
                student_username = "<% out.print(user.getUsername()); ; %>";
                student_name = "<% out.print(user.getName()); %>";
            <% } %>

            $(function () {
                <% if (user.getLevel() == 3) { %>
                    getSubjects();
                <% } else if (user.getLevel() == 4) { %>
                    getSubjectsOfStudent();
                <% } %>
            });
            
            var subjectid;
            var assignmentid;
            
            function getSubjectsOfStudent() {
                $.ajax({
                    url: "ws/search/child",
                    async: true
                })
                        .done(function(data) {
                            student_username = data.username;
                            student_name = data.name;
                            getSubjects();
                        });
            }

            function getSubjects() {
                $.ajax({
                    url: "ws/acadamic/subjects/" + student_username,
                    async: true
                })
                        .done(function (data) {
                            var sel_sbj = document.getElementById("subject");
                            sel_sbj.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].sbj_id + "'>" + data[i].sbj_name + "</option>";
                                sel_sbj.innerHTML += row;
                                subjectid = data[0].sbj_id;
                            }
                            getAssignments();
                        });
            }
            
            function getAssignments() {
                var chartLabels = [];
                var chartValues = [];
                $.ajax({
                    url: "ws/acadamic/assignments/" + student_username + "/subject/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            var tbl = document.getElementById("tbl_data");
                            tbl.innerHTML = '';
                            for (var i=0; i < data.length; i++) {
                                // Feeding chart data
                                chartLabels.push(data[i].name);
                                chartValues.push(((data[i].marks/data[i].max_marks)*100).toFixed(2));
                                
                                // Table data
                                var row = "<tr>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "<td>" + ((data[i].marks/data[i].max_marks)*100).toFixed(2) + "%</td>";
                                row += "<td>" + (data[i].date !== undefined ? data[i].date : "") + "</td>";
                                row += "<td>" + data[i].comment + "</td>";
                                row += "<td>" + data[i].author_name + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                                assignmentid = data[0].name;
                            }
                            
                            // Construct chart data object
                            var data = {
                                labels: chartLabels,
                                datasets: [{
                                        label: "Overall assignment marks percentages",
                                        backgroundColor: [
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)',
                                            'rgba(66, 134, 244, 0.6)'
                                        ],
                                        borderColor: [
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)',
                                            'rgba(66, 134, 244, 1)'
                                        ],
                                        borderWidth: 1,
                                        data: chartValues
                                }]
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
                console.log(data);
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
            <li>Assignments</li>
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
                                            Subject
                                        </div>
                                        <div class="flat-panel-body">
                                            <select id="subject" name="subject" class="form-control" onchange="subjectid = this.value; getAssignments()">

                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <h3>List of assignments as of <% out.print(utils.Utils.getFormattedDateString(new Date())); %></h3>
                                <div class="row">
                                    <table class="table table-hover">
                                        <thead>
                                        <th>Assignment Name</th>
                                        <th>Marks</th>
                                        <th>Held Date</th>
                                        <th>Comment by Teacher</th>
                                        <th>Marked By</th>
                                        </thead>
                                        <tbody id="tbl_data">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="row">
                                    <canvas id="chart" height="200px"></canvas>
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
