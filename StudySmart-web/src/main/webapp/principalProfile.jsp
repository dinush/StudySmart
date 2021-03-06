<%-- 
    Document   : principalProfile
    Created on : Oct 9, 2016, 7:10:02 PM
    Author     : Muhammad

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
                                <!--teachers personal information-->
                                
                                <ul class="nav nav-tabs">
                                    <li role="presentation" class="active"><a href="#">Personal Details</a></li>
                                </ul>
                                <br>
                                <h1><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                <span class="label label-primary">Principal's Information</span></h1>
                                <br>
                                
                                
                                
                                
                                
                                
                                
                                
                                <div class="panel panel-info"
                                    <!-- List group -->
                                    <div class="panel-body"
                                        <ul class="list-group" style="font-size:16px;">
                                          <li class="list-group-item"><b>Principal's Name     : <b></li>
                                          <li class="list-group-item">Gender:</li>
                                          <li class="list-group-item">NIC: </li>
                                          <li class="list-group-item">Address: </li>
                                          <li class="list-group-item">Telephone: </li>
                                          <li class="list-group-item">Email: </li>
                                          <li class="list-group-item">Teaching since: </li>
                                          <li class="list-group-item" style="height:100px;">Qualifications: </li>
                                          </ul>
                                    </div>
                                </div>
                                          
                                
                                <!--teachers personal information ends here-->
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
