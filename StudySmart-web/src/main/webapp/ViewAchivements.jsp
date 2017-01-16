<%-- 
    Document   : index
    Created on : Jun 29, 2016, 8:10:42 PM
    Author     : dinush

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
--%>

<%@page import="java.util.Date"%>
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
        <link rel="stylesheet" href="css/selectize.bootstrap2.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/selectize.min.js"></script>
        <script>
            function getStudents() {
                $.ajax({
                    url: "ws/search/students/all",
                    async: true
                })
                        .done(function (data) {
                            var receivers_sel = document.getElementById("students");
                            receivers_sel.innerHTML = "<option disabled selected value=''>Select student</option>";
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].username + "'>" + data[i].name + " (" + data[i].username + ")</option>";
                                receivers_sel.innerHTML += row;
                            }
                            $('#students').selectize({
                                persist: false,
                                maxItems: 1
                            });
                        });
            }
            function getAchievements() {
                $.ajax({
                    url: "ws/acadamic/achievements/" + $('#students').val(),
                    async: true
                }).done(function (data) {
                    var tbl = document.getElementById("tbl_data");
                    tbl.innerHTML = "";
                    for (var i = 0; i < data.length; i++) {
                        var row = tbl.insertRow(-1);
                        var date_cell = row.insertCell(0);
                        var achievements_cell = row.insertCell(1);
                        var description_cell = row.insertCell(2);

                        date_cell.innerHTML = data[i].date.split("T")[0];
                        achievements_cell.innerHTML = data[i].title;
                        description_cell.innerHTML = data[i].description;
                    }


                });
            }

            $(function () {
                getStudents();
                getAchievements();
            });

            function printPageArea() {
                var printContent = document.getElementById("printingarea");
                var WinPrint = window.open('', '', 'width=900,height=650');
                WinPrint.document.write(printContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                WinPrint.close();
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
                <li><a href="ViewAchivementStu.jsp">Achievement</a></li>
            </ol>
            <table border="0">
                <tr>
                    <td valign="top" class="table-col-fixed">
                        <%@ include file="WEB-INF/jspf/Sidemenu.jspf" %>
                    </td>
                    <td valign="top" class="table-col-max">
                        <div class="content">
                            <div class="row">
                                <div id="main-content" class="col-sm-8">
                                    <%--   <div class="flat-panel-head">
                                                Category
                                    </div> --%>
                                    Select student <select id="students" name="student" onchange="getAchievements()"></select>
                                    <div id="printingarea">
                                    <h3>List of Achievement as of <% out.print(utils.Utils.getFormattedDateString(new Date()));%></h3>
                                    <div class="row">
                                        <table class="table table-striped">
                                            <thead>
                                                <%--   <th>Category</th> --%>
                                            <th>Date</th>
                                            <th>Achievement</th>
                                            <th>Description</th>                                       
                                            </thead>
                                            <tbody id="tbl_data">

                                            </tbody>
                                        </table>
                                    </div>
                                    </div>
                                            <button class="btn btn-success" onclick="printPageArea()"><i>Print PDF</i></button>
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
