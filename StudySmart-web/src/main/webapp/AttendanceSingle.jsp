<%-- 
    Document   : AttendanceSingle
    Created on : Sep 8, 2016, 10:28:13 PM
    Author     : dinush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <script>
            var doughnutChart = null;
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
            
            $(function() {
                initDoughnutChart();
                updateDoughnutChart();
            });
        </script>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="well" style="float:left;">
            Student ID: <% out.print(request.getAttribute("student-username")); %><br>
            Student Name: <% out.print(request.getAttribute("student-name")); %><br>
            Student Class: <% out.print(request.getAttribute("student-class")); %><br>
            Date Period: <% out.print(request.getAttribute("from")); %> - <% out.print(request.getAttribute("to")); %><br>
            <!--Chart-->
        <canvas id="att_chart" style="height: 50px; width: 50px;"></canvas>
        </div>
        
        <table class="table table-striped">
            <thead>
            <th>Date</th>
            <th>Attended?</th>
            <th>Marked By</th>
        </thead>
        <tbody>
            <%
                int total = 0;
                int att = 0;
            %>
            <c:forEach var="row" items="${lstAtt}">
                <% total++; %>
                <tr>
                    <td><fmt:formatDate value="${row.getAttendancePK().getDate()}" pattern="MMM/dd/yyyy" /></td>
                    <td><c:choose><c:when test="${row.getAttended()}"><% att++; %>Yes</c:when><c:otherwise>No</c:otherwise></c:choose></td>
                    <td>${row.getMarkedBy().getName()}</td>
                </tr>
            </c:forEach>
        </tbody>
        <!-- Chart update -->
        <script>
            function updateDoughnutChart() {
                var data = [
                    (<% out.print(att); %> / <% out.print(total); %>) * 360,
                    (<% out.print(total - att); %> / <% out.print(total);%>) * 360
                ];

                if (doughnutChart === null) {
                    console.log("Chart object uninitialized");
                    return;
                }

                doughnutChart.data.datasets[0].data = data;
                doughnutChart.update();
            }
        </script>
        <script
    </table>
</body>
</html>
