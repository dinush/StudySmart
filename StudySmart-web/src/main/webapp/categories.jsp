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


        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                $('#error').hide();

                getClasses(0);
                getClasses(1);
            });

            function sendPacket() {
                var packet = {};
                packet['meta'] = {};
                packet['meta']['cat_name'] = $('#cat_name').val();
                packet['meta']['cat_description'] = $('#cat_description').val();
                packet['meta']['class'] = $('#class').val();
                packet['meta']['subject'] = $('#subject').val();

                $.ajax({
                    type: "POST",
                    async: true,
                    url: "Categories",
                    data: JSON.stringify(packet),
                    contentType: "text/plain"
                })
                        .done(function (data) {
                            alert("succesfully updated");

                        });

                return false;
            }

            function getClasses(n) {
                $.ajax({
                    url: "ws/rest/teacher/<% out.print(user.getUsername());%>/classes",
                    async: false
                })
                        .done(function (data) {
                            var sel_cls = document.getElementsByClassName("classes");
                            sel_cls[n].innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                                sel_cls[n].innerHTML += row;
                            }
                            getSubjects(n);
                        });
            }


            function getSubjects(n) {

                var classid = document.getElementsByClassName("classes")[n];

                $.ajax({
                    url: "ws/rest/teacher/<% out.print(user.getUsername());%>/subjects/" + classid.value,
                    async: false
                })
                        .done(function (data) {
                            var sel_sbj = document.getElementsByClassName("subjects");
                            sel_sbj[n].innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                                sel_sbj[n].innerHTML += row;
                            }
                            getThreads();
                        });
            }

            function getThreads() {

                var classid = document.getElementsByClassName("classes")[0];
                var subjectid = document.getElementsByClassName("subjects")[0];
                if (classid === '' || subjectid === '') {
                    return;
                }
                

                $.ajax({
                    url: "ws/rest/teacherthreads/" + classid.value + "/" + subjectid.value,
                    async: false
                })
                        .done(function (data) {
                            var tbl = document.getElementById("tbl");
                            tbl.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td id=cat_name><a href='forumposts.jsp?lesson=" + data[i].catname + "&class=" + classid.value + "&subject="+subjectid.value+"'>" + data[i].catname + "</a></td>";
                                row += "<td>" + data[i].catdescription + "</td>";
                                row += "<td>" + data[i].catdate + "</td>";
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

                                    <!--editing starts here-->

                                    <!-- Show threads created by the teacher so far-->
<!--                                    <h2><b style="color:#428bca;">Discussion Forum</b></h2>-->
                                    <br>
                                    
                                    
                                    <form class="form-inline" onsubmit="return sendPacket()">
                                        
                                                <div class="form-group">

                                                    <select name="class" class="form-control classes" id="class" onchange="getSubjects(0)"></select>
                                                    <select name="subject" class="form-control subjects" id="subject" onchange="getThreads()" ></select>
                                                    <br>
                                                </div>
                                            

                                                <table class="table table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Lesson Name</th>
                                                            <th>Lesson Description</th>
                                                            <th> Date </th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tbl">

                                                    </tbody>
                                                </table>
                                                <br><br>
                                            
                                    </form>


                                    <!--Create new category-->
                                    <h3><b><u> Create New Discussion: </u></b></h3>
                                   
                                    <form class="form-inline" onsubmit="return sendPacket()">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">
                                                <div class="form-group">

                                                    <select name="class" class="form-control classes" id="class" onchange="getSubjects(1)"></select>
                                                    <select name="subject" class="form-control subjects" id="subject"></select>


                                                    <input type="text" name="cat_name" class="form-control" id="cat_name" placeholder="New Category Name">
                                                </div>
                                            </div>


                                            <div class="form-group">

                                                <textarea type="Description" rows="5" cols="80" name="cat_description" class="form-control" id="cat_description" placeholder="New Category Description"></textarea>
                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-primary" style="float:right;"><h4> Submit</h4> </button>
                                    </form>





                                    <!--ends here-->
                                </div>
                                <div class="col-md-4">
                                    <%@ include file="WEB-INF/jspf/Infopanel.jspf" %>
                                </div>
                            </div>

                    </td>
                </tr>
            </table>
        </div>

    </body>
</html>

