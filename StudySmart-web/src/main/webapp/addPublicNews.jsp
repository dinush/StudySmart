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
            $(document).ready(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
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
                                <h3><b><i><u> Add General News </u></i></b></h3>
                                <br>
                                <form class="form-inline">
                                <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        <div class="form-group">
                                        <label for="exampleInputName2" >Date: </label>
                                        <input type="text" class="form-control" id="exampleInputName2" style="margin-left:20px;" placeholder="8/28/2016">
                                      </div>
                                    </h3>
                                </div>
                                <div class="panel-body">
                                     <div class="form-group">
                                      <label for="exampleInputPassword1">News: </label>
                                      <textarea type="Description" class="form-control" id="InputDescription" style="margin-left:66px; width:510px; " placeholder="New Announcement"></textarea>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <div class="form-group">
                                        <label for="exampleInputName2" >Author: </label>
                                        <input type="text" class="form-control" id="exampleInputName2" style="margin-left:10px;" placeholder="Jane Doe">
                                    </div>
                                </div>
                            </div>
                                    
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
