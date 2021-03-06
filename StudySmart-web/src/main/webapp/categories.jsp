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
        <!--        Sweet alert 2-->
        <script src="js/sweetalert.min.js"></script>
        <link rel="stylesheet" href="css/sweetalert.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>


        <script type = "text/javascript" >
            $(function () {
                $('#error').hide();

                getClasses(0);
                getClasses(1);
            });

            function sendPacket() {
                var packet = {};
                packet['meta'] = {};
                packet['meta']['cat_name'] = $('#cat_name').val();
                packet['meta']['cat_description'] = $('#cat_description').val();
                packet['meta']['class'] = document.getElementsByClassName("classes")[1].value;
                packet['meta']['subject'] = document.getElementsByClassName("subjects")[1].value;
                
                if (!(packet['meta']['cat_name'] || packet['meta']['cat_description'])){
                    swal({
                                title: "Error",
                                text: "Please enter the lesson name and a descripption!",
                                type: "error"
                            });
                            return false;
                }
                

                $.ajax({
                    type: "POST",
                    async: true,
                    url: "Categories",
                    data: JSON.stringify(packet),
                    contentType: "text/plain"
                })
                        .done(function (data) {
                            swal({
                                title: "Success",
                                text: "New Discussion Thread Succesfully Created!",
                                type: "success"
                            });
                            getThreads();
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

            function deleteThread(threadid) {

                $.ajax({
                    url: "ws/rest/forumdeletethread/" + threadid,
                    async: true,
                    type: 'DELETE',
                    success: function (res) {
                        swal({
                            title: "",
                            text: "Succesfully Deleted !",
                            type: "error"
                        });
                        getThreads();

                    }
                });

                return false;

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
                            var alert_panel = document.getElementById("alert");
                            tbl.innerHTML = '';
                            if (data.length === 0) {
                                alert_panel.innerHTML = "<h4><small><i>No discussions</i></small></h4>";
                                return;
                            }
                            alert_panel.innerHTML = "";
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td><a href='forumposts.jsp?lesson=" + data[i].catname + "&catid=" + data[i].catid + "&class=" + classid.value + "&subject=" + subjectid.value + "'>" + data[i].catname + "</a></td>";
                                row += "<td>" + data[i].catdescription + "</td>";
                                row += "<td>" + data[i].catdate + "</td>";
                                row += "<td><span class='glyphicon glyphicon-remove-circle pull-right' aria-hidden='true' onclick='deleteThread(" + data[i].catid + ")' style='cursor:pointer'></span></td>";
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
                <li class="breadcrumb-item"><a href="studentVLEmain.jsp">Access VLE</a></li>
                <li class="breadcrumb-item active">Discussion Forum</li>
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
                                            Discussions
                                        </div>
                                        <div class="flat-panel-body">
                                            <form class="form-inline">

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
                                                            <th></th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tbl">

                                                    </tbody>
                                                    <div id="alert"></div>
                                                </table>
                                                <br><br>

                                            </form>
                                        </div>
                                    </div>

                                    <!--Create new category-->
                                    <h3><b><u> Create New Discussion: </u></b></h3>

                                    <form class="form-inline" onsubmit="return sendPacket()">
                                        <div class="panel" style="background-color: #336699;">
                                            <div class="panel-heading">
                                                <div class="form-group">

                                                    <select name="class" class="form-control classes" id="class" onchange="getSubjects(1)"></select>
                                                    <select name="subject" class="form-control subjects" id="subject"></select>


                                                    <input type="text" name="cat_name" class="form-control" id="cat_name" placeholder="New Category Name">
                                                </div>
                                            </div>


                                            <div class="form-group" style="width: 100%;">

                                                <textarea type="Description" rows="5" name="cat_description" class="form-control" id="cat_description" placeholder="New Category Description" style="width: 100%;"></textarea>
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

