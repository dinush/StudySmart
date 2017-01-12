<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : Kaveesh

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/angular.min.js"></script>
        <script>
            function calculate(origin, target) {
                var val = parseInt($(origin).val());
                var max = parseInt($('#max').val());
                if (isNaN(max)) {
                    $(target).html("<span style='color:red'>INVALID MAXIMUM</span>");
                    return;
                }
                if (isNaN(val)) {
                    $(target).html("<span style='color:red'>INVALID VALUE</span>");
                    return;
                }
                var per = (val / max) * 100;
                if (per > 100) {
                    $(target).html("<span style='color:red'>OUT OF RANGE</span>");
                    return;
                }
                $(target).html(per.toFixed(3) + "%");
            }
            function loadStudents() {
                $.ajax({
                    url: "ws/rest/student/" + $('#class').val() + "/" + $('#subject').val(),
                    async: true
                })
                        .done(function (data) {
                            data = data.raw;
                            var tbl = document.getElementById("table-body");
                            tbl.innerHTML = "";
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "<td><input required type='number' name='st##-" + data[i].username + "' onchange='checkMarks(this);calculate(this, \"#percentage-" + data[i].username + "\")'></td>";
                                row += "<td><span id='percentage-" + data[i].username + "'></span></td>";
                                row += "<td><input type='text' name='" + data[i].username + "'/></td>";
                                row += "</tr>";
                                tbl.innerHTML += row;
                            }

                        });
            }
            function loadSubjects() {
                $.ajax({
                    url: "ws/rest/teacher/<%out.print(user.getUsername());%>/subjects/" + $('#class').val(),
                    async: true
                })
                        .done(function (data) {
                            var subj_opts = document.getElementById("subject");
                            subj_opts.innerHTML = "";
                            for (var i = 0; i < data.length; i++) {
                                var opt = "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                                subj_opts.innerHTML += opt;
                            }
                            loadStudents();
                        });
            }
            
            function checkMax(elem) {
                var val = $(elem).val();
                if (val == null || val == '' || val < 0) {
                    $(elem).val('100');
                }
            }
            
            function checkMarks(elem) {
                var max = parseInt($('#max').val());
                var mark = parseInt($(elem).val());
                if (mark > max) {
                    mark = max;
                } else if(mark < 0) {
                    mark = 0;
                }
                $(elem).val(mark);
            }

            $(function () {
                loadSubjects();
            });

        </script>


    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home </a></li> 
            <li>Assignment   Marks</li>
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
                                <% if (request.getParameter("msg") != null) { %>
                                <div class="alert alert-warning alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <strong>Error : </strong> ${fn:escapeXml(param.msg)}
                                </div>
                                <% }%>
                                <div class="flat-panel">
                                    <div class="flat-panel-head">
                                        Entering assignment marks
                                    </div>
                                    <div class="flat-panel-body">
                                        <form class="form-horizontal" method="POST" action="StudentManager?action=assignmentMarksSave">
                                            <div class="form-group">
                                                <label for="name" class="col-sm-4 control-label">Assignment Name: </label>
                                                <div class="col-sm-8">
                                                    <input required name="name" type="text" class="form-control" id="name">
                                                </div>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <label for="max"  class="col-sm-4 control-label">Maximum marks for this Assignment: </label>
                                                <div class="col-sm-8">
                                                    <input required name="max" type="number" value="100" onchange="checkMax(this)" class="form-control" id="max" placeholder="Max marks allowed" value="<% out.print((request.getAttribute("max") != null ? request.getAttribute("max") : ""));%>">
                                                </div>
                                            </div>
                                            <br />
                                            <div class="col-sm-6">
                                                <label for="class" class="col-sm-6 col-form-label">Class:</label>
                                                <select id="class" name="class" class="col-sm-6 form-control" onchange="loadSubjects()">
                                                    <c:forEach var="teach" items="${teaches}">
                                                        <option value="${teach.getClass1().getId()}">Grade ${teach.getClass1().getGrade()} ${teach.getClass1().getSubclass()}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="col-sm-6">
                                                <label for="class" class="col-sm-6 col-form-label">Subject:</label>
                                                <select id="subject" name="subject" class="col-sm-6 form-control" onchange="loadStudents()">
                                                </select>
                                            </div>

                                            <hr>
                                            <br/>

                                            <h4>Showing list of students:</h4>
                                            <!--students should be loaded to the table below-->

                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Student Name</th>
                                                        <th>Marks Obtained</th>
                                                        <th>Marks %</th>
                                                        <th>Comment</th>
                                                    </tr>
                                                </thead>

                                                <tbody id="table-body">
                                                </tbody>
                                            </table>
                                            <div>
                                                <button type="submit" class="btn btn-primary col-sm-offset-9" style="width:100px;">Submit</button>
                                            </div>
                                        </form>
                                    </div>
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
