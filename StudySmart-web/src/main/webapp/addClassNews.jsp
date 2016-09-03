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
        <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css"/>
        <link rel="stylesheet" href="css/bootstrap-datepicker3.standalone.min.css"/>
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                $('#date-container input').datepicker({});
                getClasses();
            });

            function getClasses() {
                var sel_cls = document.getElementById("class");
                sel_cls.innerHTML = '';
                $.ajax({
                    url: "ws/rest/classes",
                    async: false
                })
                        .done(function (data) {
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option name='" + data[i].id + "'>Grade " + data[i].name + "</option>";
                                sel_cls.innerHTML += row;
                            }
                        })
            }
            
            function send() {
                var date = $('#date').val();
                var classid = $('#class').val();
                var title = $('#title').val();
                var content = $('#content').val();
                
                var packet = {};
                packet['classid'] = classid;
                packet['date'] = date;
                packet['title'] = title;
                packet['content'] = content;
                
                $.ajax({
                    type: "POST",
                    url: "management?action=class-msg-add",
                    async: true,
                    data: JSON.stringify(packet),
                    contentType: "text/plain"
                })
                        .done(function(data) {
                            alert("Success");
                        });
                        
                return false;
            }
        </script>


    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <div id="page-title">
                <h1>Study Smart</h1>
            </div>                
            <div class="user-details">
                Signed in as:
                <span id="user-name">
                    <%                        out.print(user.getName());
                    %>
                </span>
                <a href="logout">
                    (logout)
                </a>                    
            </div>
        </div>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li>Add Class Announcements</li>
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
                                <!--class specific news-->
                                <h3><b><i><u> Add Class-Specific Announcements </u></i></b></h3>
                                <br>
                                <form>
                                    <div class="panel panel-info">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">
                                                <div class="form-group">
                                                    <label for="class" >Class: </label>
                                                    <select name="class" id="class" class="form-control">
                                                        <!--Fill with ajax-->
                                                    </select>
                                                </div>
                                                <div class="form-group" id="date-container">
                                                    <label for="date" >Date: </label>
                                                    <input type="text" name="date" class="form-control" id="date" placeholder="8/28/2016">
                                                </div>
                                            </h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="form-group">
                                                <label for="title">Title: </label>
                                                <input type="text" class="form-control" id="title" name="title"     placeholder="Title">
                                            </div>
                                            <div class="form-group">
                                                <label for="content">Content: </label>
                                                <textarea type="text" name="content" id="content" class="form-control" id="InputDescription" placeholder="Message"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <br>
                                <button type="button" class="btn btn-primary" style="margin-left:520px;"><h4> Submit</h4> </button>
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
