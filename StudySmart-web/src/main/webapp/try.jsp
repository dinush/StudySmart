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
        <script type="text/javascript">
            
             $(function () {
                getThreads();
            });


            function getThreads() {
                var user = '<% out.print(user.getUsername()); %>';
                var classid = '<% out.print(user.getClass1().getId()); %>';
                if (classid === '') {
                    console.log("class null");
                    return;
                }


                $.ajax({
                    url: "ws/rest/teacherthreads/" + classid + "/null",
                    async: false
                })
                        .done(function (data) {
                            var tbl = document.getElementById("tbl");
                            tbl.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].catsubject + "</td>";
                                row += "<td id=cat_name><a href='forumposts.jsp?lesson=" + data[i].catname + "&class=" + classid + "&subject=" + data[i].catsubject + "'>" + data[i].catname + "</a></td>";
                                row += "<td>" + data[i].catdescription + "</td>";
                                row += "<td>" + data[i].catdate + "</td>";
                                row += "<td>" + data[i].catby + "</td>";
                                row += "</tr>";
                                tbl.innerHTML += row;


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
                                    <script>
                                    alert("<% out.print(request.getParameter("msg"));%>");
                                    </script>
                                    <% }%>

                                    <!-- DIscussion forum rules-->

                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                                        Rules to Follow
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                    <h4 class="modal-title" id="myModalLabel"><span style="color:#9370DB">Forum Etiquette</span></h4>
                                                </div>
                                                <div class="modal-body">
                                                    <%@ include file="WEB-INF/jspf/ForumRules.jspf" %>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary">Save changes</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <br>
                                    <br>

                                    <!-- rules end here -->

                                    <!-- Current threads for the students class-->
                                    <div>

                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Subject</th>
                                                    <th>Lesson</th>
                                                    <th>Lesson Description</th>
                                                    <th> Date </th>
                                                    <th> By </th>

                                                </tr>
                                            </thead>
                                            <tbody id="tbl">

                                            </tbody>
                                        </table>
                                    </div>     



                                    <!--ends here-->

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
