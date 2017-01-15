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
        <link rel="stylesheet" href="css/bootstrap-datepicker3.standalone.min.css" />
        <link rel="stylesheet" href="css/selectize.bootstrap2.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script src="js/selectize.min.js"></script>
        <script>
            function getStudents() {
                $.ajax({
                    url: "ws/search/students/all",
                    async: true
                })
                        .done(function(data) {
                            var students_select = document.getElementById("students");
                            students_select.innerHTML = "";
                            var students_html = "";
                            for (var i=0; i < data.length; i++) {
                                var student_html = "<option name='students' value='" + data[i].username + "'>" + data[i].name + "(" + data[i].username + ")" + "</option>";
                                students_html += student_html;
                            }
                            students_select.innerHTML = students_html;
                            
                            $('#students').selectize({
                                persist: true,
                                maxItems: 1
                            });
                        });
            }
            
            $(function() {
                getStudents();
                $('#date').datepicker({
                    
                });
                
            });
        </script>

    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home </a></li>
            <li><a href="manageStudentDetails.jsp">Student Management </a></li>
            <li> Achievement details </li>
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
                                
                                <form action="StudentManager?action=addachievement" method="POST">
                                    
                                    <div class="form-group">
                                        <label for="students" class="col-xs-3 col-form-label">Student Name:</label>
                                        <div class="col-xs-9">
                                            <select id="students" name="students"></select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-lg-3"><b> Category </b></div>
                                        <div class="col-lg-4">
                                            <select name="category" class="form-control">
                                                <option value="1">Academics</option>
                                                <option value="2">Extra-Curricular</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group row">
                                        <label for="example-date-input" class="col-xs-3 col-form-label"> Date </label>
                                        <div class="col-xs-9">
                                          <input id="date" name="date" class="form-control" style="width:185px;" type="date" placeholder="2011-08-19" id="example-date-input">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputEmail1" class="col-xs-3 col-form-label">Achievement</label>
                                      <div class="col-xs-9">
                                        <input name="achive" type="Achievement" class="form-control" id="InputAchievement" placeholder="Achievement">
                                      </div>
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Description</label>
                                      <textarea name="descrip" type="Description" class="form-control" id="InputDescription" placeholder="Description"></textarea>
                                    </div>
                                   
                             
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                  </form>
                                
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
