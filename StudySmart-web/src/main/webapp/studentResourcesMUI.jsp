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
        <style>
            
        </style>
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


    </script>
    <title>StudySmart</title>
</head>
<body  style="background-color" >
    <div class="container"  style="background-color:#66b5ff" >
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="vleMainInterface.jsp">VLE</a></li>
            <li><a href="#">Student Resources</a></li>
        </ol>
        <table border="0">
            <tr>
                <td valign="top" class="table-col-fixed">
                    <%@ include file="WEB-INF/jspf/Sidemenu.jspf" %>
                </td>
                <td valign="top" class="table-col-max">
                    <div class="content">
                        <div class="row">
                            <div id="main-content" class="col-md-12" >
                             
                                 
                                <table>
                                    <tr>
                                        <td><a href="uploadBrainTeaseQuiz.jsp"><img src="images/History.png" alt="HTML5 Icon" style="width:200px;height:200px;"></a></td>
                                        <td><a href="studentResourceView.jsp"><img src="images/Science.png" alt="HTML5 Icon" style="width:200px;height:200px;"></a></td>
                                        <td><a href="#"><img src="images/Geography.png" alt="HTML5 Icon" style="width:200px;height:200px;"></a></td> 
                                    </tr>
                                    <tr>
                                        <td><a href="#"><img src="images/ICT.png" alt="HTML5 Icon" style="width:200px;height:200px;"></a></td>
                                        <td><a href="#"><img src="images/English.png" alt="HTML5 Icon" style="width:200px;height:200px;"></a></td>
                                        <td><a href="#"><img src="images/Maths.png" alt="HTML5 Icon" style="width:200px;height:200px;"></a></td>
                                    </tr>
                                  </table>

                            </div>
                            <div class="col-md-4">
                               <!-- <%@ include file="WEB-INF/jspf/Infopanel.jspf" %> -->
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
