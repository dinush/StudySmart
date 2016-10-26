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
                getSubjects();
            });
            
            var username;
            <% if( acc_level == 3 ) { %>    
                username = '<% out.print(user.getUsername()); %>';
            <% } %>
            var subjectid;
            var assignmentid;

            function getSubjects() {
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
                                subjectid = data[0].sbj_id;
                            }
                            getAssignments();
                        });
            }
            
            function getAssignments() {
                $.ajax({
                    url: "ws/acadamic/assignments/" + username + "/subject/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            var tbl = document.getElementById("tbl_data");
                            tbl.innerHTML = '';
                            for (var i=0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "<td>" + ((data[i].marks/data[i].max_marks)*100).toFixed(2) + "% <br>(" + data[i].marks + " out of " + data[i].max_marks + ")</td>";
                                row += "<td>" + data[i].date + "</td>";
                                row += "<td>" + data[i].comment + "</td>";
                                row += "<td>" + data[i].author_name + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                                assignmentid = data[0].name;
                            }
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
