<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@ page import="javax.servlet.jsp.jstl.sql.Result" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>

        <script>
            function getSubjects() {
                $.ajax({
                    url: "ws/rest/teacher/<% out.print(user.getUsername());%>/subjects",
                    async: true
                })
                        .done(function (data) {
                            var subject_select = document.getElementById("subject");
                            var options = "";
                            for (var i = 0; i < data.length; i++) {
                                var option = "<option value='" + data[i].id + "'>Grade " + data[i].grade + " " + data[i].name + "</option>";
                                options += option;
                            }
                            subject_select.innerHTML = options;
                        });
            }

            function setPreview() {
                var preview = document.getElementById("preview");
                preview.src = $("#link").val();
            }

            $(function () {
                getSubjects();
            });
        </script>

        <title>StudySmart</title>
    </head>
    <body>
        <div class="container">
            <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
            <!-- Path -->
            <ol class="breadcrumb">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="teachVLEMUI.jsp">VLE</a></li>
                <li>Add URL</li>
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


                                    <div class="flat-panel">
                                        <div class="flat-panel-head">
                                            Adding external URL
                                        </div>
                                        <div class="flat-panel-body">
                                            <form method="POST" action="UrlInsertion">

                                                <div class="form-group">
                                                    <label for="subject">Subject</label>
                                                    <select id="subject" name="subject" class="form-control">

                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="">Enter a topic</label>
                                                    <input type="text" class="form-control" id="topic" name="topic" placeholder="Enter a topic here">
                                                </div>
                                                <div class="form-group">
                                                    <label for="">Enter URL</label>
                                                    <input type="text" class="form-control" id="link" name="link" onchange="setPreview()" placeholder="Enter URL here">
                                                </div>

                                                <button type="submit" class="btn btn-primary">Finish</button>
                                            </form>

                                            <!--Preview-->
                                            <div class="embed-responsive embed-responsive-4by3" style="margin-top:10px;">
                                                <iframe id="preview" class="embed-responsive-item" src=""></iframe>
                                            </div>
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
        <script id="dsq-count-scr" src="//EXAMPLE.disqus.com/count.js" async></script>
    </body>
</html>
