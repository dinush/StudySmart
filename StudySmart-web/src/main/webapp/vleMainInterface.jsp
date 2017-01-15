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
            h5:hover {
    background-color: #1a75ff;
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
<body  style="background-color:  " >
    <div class="container" >
        <%@include file="WEB-INF/jspf/PageHeaderVLE.jspf" %>
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
                            <div id="main-content" class="col-md-12" >
                                 
                                <table style="width:100%;">
                                    <tr>
                                      <td><a href="studentResourceView.jsp" ><img src="images/URL.png"  style="width:230px;height:150px;  margin-left:30px""></a></td>
                                      
                                      <td><a href="#" ><img src="images/teacher.png" align="center" style="width:320px;height:150px;"></a></td>
                                    </tr>
                                    <tr>
                                     <td><h5><font size="5"  style=" margin-left:30px"><b>External Resources&nbsp;&nbsp;&nbsp;</font></td>
                                     <td><h5><font size="5"><b>Teacher-Student Collaboration</font></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                     <tr>
                                     <td><a href="studentResourcesMUI.jsp" ><img src="images/ebook.png" alt="HTML5 Icon" style="width:250px;height:150px; margin-left:30px"></a></td>
                                     <td><a href="quizMain.jsp" ><img src="images/individual.png" alt="HTML5 align="left"  Icon" style="width:150px;height:170px; margin-left:80px"></a></td>
                                    </tr>
                                    
                                    <tr>
                                     <td><h5><font size="5" style=" margin-left:30px"><b>Student Resources</font></td>
                                     <td><h5><font size="5"  style=" margin-left:30px "><b>Individual Activities</font></td>
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
