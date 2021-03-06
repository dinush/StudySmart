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
            //View all subjects
            function getSubjects() {
                var subject_select = document.getElementById("subject");
                $.ajax({
                    url: "ws/rest/subjects/all",
                    async: true
                })
                        .done(function (data) {
                            var subjects_html = "";
                            for (var i = 0; i < data.length; i++) {
                                var subject_html = "<option value='" + data[i].id + "'>Grade " + data[i].grade + " " + data[i].name + "</option>";
                                subjects_html += subject_html;
                            }
                            subject_select.innerHTML = subjects_html;
                        });
            }
            //System automatically load every subjects
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
                <li><a href="#">Upload File</a></li>
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
                                            File upload for subjects
                                        </div>
                                        <div class="flat-panel-body">
                                            <!--Send informaation to the brainTeaseFileUpload servlet in lk.studysmart.apps-->
                                            <form method="POST" action="brainTeaseFileUpload" enctype="multipart/form-data" >
                                                <div class="form-group">
                                                    <label for="filename">Filename</label>
                                                    <input required type="text" size="10px" class="form-control"  name="filename" placeholder="Enter file name here">
                                                </div>
                                                <div class="form-group">
                                                    <label for="description">Description</label>
                                                    <input type="text" size="10px" class="form-control"  name="description" placeholder="Short description">
                                                </div>
                                                <div class="form-group">
                                                    <label for="subject">Subject</label>
                                                    <select id="subject" name="subject" class="form-control">

                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="file">File</label>
                                                    <input required type="file" name="file" id="file"/> 
                                                </div>

                                                <button type="submit" class="btn btn-primary">Finish</button>
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
        <script id="dsq-count-scr" src="//EXAMPLE.disqus.com/count.js" async></script>
    </body>
</html>
