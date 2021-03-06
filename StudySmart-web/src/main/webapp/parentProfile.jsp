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
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        
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
                                <!--parent's profile-->
                                
                                <ul class="nav nav-tabs">
                                    <li role="presentation" class="active"><a href="#">Personal Details</a></li>
                                    <li role="presentation"><a href="#">Student's Profile</a></li>
                                </ul>
                                
                                <h1>
                                    <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                    <span class="label label-primary">Guardian's Information</span>
                                </h1>
                                <br>
                                
                                <div class="panel panel-info" style="font-size:16px;">
                                    <!-- List group -->
                                    <div class="panel-body"
                                        <ul class="list-group" >
                                          <li class="list-group-item"><b>Guardian Name     : <b></li>
                                          <li class="list-group-item">No. of children studying in our school        :</li>
                                          <li class="list-group-item" style="height:100px;">Their Names: </li>
                                          <li class="list-group-item ">Gender: </li>
                                          <li class="list-group-item">NIC: </li>
                                          <li class="list-group-item">Address:</li>
                                          <li class="list-group-item">Occupation:</li>
                                          <li class="list-group-item">Home Telephone No.:</li>
                                          <li class="list-group-item">Mobile:</li>
                                          <li class="list-group-item">Email:</li>
                                        </ul>
                                    </div>
                                </div>
                                <!--parent profile ends here-->
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
