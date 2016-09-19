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
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                getSubjects();
                
            });

            function getSubjects() {
                $.ajax({
                    url: "ws/acadamic/subjects/<%out.print(user.getUsername());%>",
                    async: true
                })
                        .done(function (data) {
                            var sel_sbj = document.getElementById("subject");
                            sel_sbj.innerHTML = '';
                            for(var i=0;i < data.length; i++) {
                                var row = "<option value='" + data[i].sbj_id + "'>" + data[i].sbj_name + "</option>";
                                sel_sbj.innerHTML += row;
                            }
                            getMarks();
                        });
            }

            function getMarks() {
                $('#marks').html("Not Marked");
                $.ajax({
                    url: "ws/acadamic/marks/term/<%out.print(user.getUsername());%>/" + $('#term').val() + "/" + $('#subject').val(),
                    async: true
                })
                        .done(function(data) {
                            $('#marks').html(data.value + "/100");
                        });
            }
        </script>


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

                                    <div class="col-lg-3">
                                        <select id="term" name="term" class="form-control" onchange="getMarks()">
                                            <option value="1">Term 1</option>
                                            <option value="2">Term 2</option>
                                            <option value="3">Term 3</option>
                                        </select>
                                    </div>


                                    <div class="col-lg-3">
                                        <select id="subject" name="subject" class="form-control" onchange="getMarks()">
                                            <option value="1">Science</option>
                                            <option value="2">English</option>
                                        </select>
                                    </div>

                                </div>
                                <div class="row">
                                    <h3 id="marks">Marks</h3>
                                </div>
                                <br>




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
