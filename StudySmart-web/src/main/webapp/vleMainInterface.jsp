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
            .button1 {
                background-color: #66b5ff;
                border: none;
                color: white;
                padding: 90px 180px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
            }
            .button2 {
                background-color: #66b5ff;
                border: none;
                color: white;
                padding: 45px 70px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
            }
            .button3 {
                background-color: #66b5ff;
                border: none;
                color: white;
                padding: 90px 180px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
            }
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
    <div class="container"  style="background-color: #4d79ff" >
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="#">VLE</a></li>
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
                             
                                 
                                <table>
                                    <tr>
                                       <td><a href="#" class="button2"><img src="images/individual.png" alt="HTML5 Icon" style="width:190px;height:150px;">Individual Activities</a></td>
                                      <td><a href="#" class="button2"><img src="images/teacher.png" alt="HTML5 Icon" style="width:250px;height:150px;">Teacher-Student Collaboration</a></td>
                                    </tr>
                                    <tr>
                                     <td><a href="#" class="button2"><img src="images/ebook.png" alt="HTML5 Icon" style="width:250px;height:150px;">Student Resources</a></td>
                                     <td><a href="#" class="button2"><img src="images/URL.png" alt="HTML5 Icon" style="width:250px;height:150px;">Student Collaboration</a></td>
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
