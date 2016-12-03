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

            $(function () {
                <% if (acc_level == 3) { %>
                    getSubjects("<%out.print(user.getUsername());%>");
                <% } %>
            });

            function getSubjects(username) {
                $.ajax({
                    url: "ws/acadamic/subjects/" + username,
                    async: true
                })
                        .done(function (data) {
                            var sel_sbj = document.getElementById("subject");
                            sel_sbj.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].sbj_id + "'>" + data[i].sbj_name + "</option>";
                                sel_sbj.innerHTML += row;
                            }
                            getMarks();
                        });
            }

            function getMarks() {
                var chartLabels = [];
                var chartValues = [];

                var tbl = document.getElementById("tbl_data");
                tbl.innerHTML = '';

                $.ajax({
                    url: "ws/acadamic/marks/terms/<%out.print(user.getUsername());%>/" + $('#subject').val(),
                    async: true
                })
                        .done(function (data) {
                            for (var i = 0; i < data.length; i++) {
                                chartLabels.push("Term " + data[i].term);
                                chartValues.push(data[i].value);
                                var row = "<tr>";
                                row += "<td>" + data[i].term + "</td>";
                                row += "<td>" + data[i].value + "</td>";
                                row += "<td>" + data[i].marker_name + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                            }
                            var data = {
                                labels: chartLabels,
                                datasets: [
                                    {
                                        label: "Term Test Marks",
                                        data: chartValues,
                                        backgroundColor: [
                                            "rgba(75,192,192,0.5)",
                                            "rgba(0,153,204,0.5)",
                                            "rgba(153,0,204,0.5)"
                                        ],
                                        borderColor: "rgba(75,192,192,1)",
                                        borderWidth: 1
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
                                    
                                    <% if (acc_level < 3) { %>
                                    <div class="col-md-3">
                                        <select id="class2" name="class2" class="form-control">
                                            
                                        </select>
                                    </div>
                                    <% } %>

                                    <div class="flat-panel">
                                        <div class="flat-panel-head">
                                            Subject
                                        </div>
                                        <div class="flat-panel-body">
                                            <select id="subject" name="subject" class="form-control" onchange="getMarks()">

                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <!--Chart-->
                                    <canvas id="chart" height="100"></canvas>
                                </div>
                                <div class="row">
                                    <table class="table table-striped">
                                        <thead>
                                        <th>Term</th>
                                        <th>Marks</th>
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
