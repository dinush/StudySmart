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


    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="qStudentMain.jsp">VLE</a></li>
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
                                <% if(request.getParameter("msg") != null) { %>
                                <script>
                                    alert("<% out.print(request.getParameter("msg"));%>");
                                </script>
                                <% } %>
                                
                                    <p></p>
                                     <div>
                                         <table cell padding="0" cells pacing="50" >

                                                <tr>
                                                    <td><a href="englishQuizMain.jsp"> <img height="130" width="130" src = "images/English.png"/></a> </td>
                                                    <td><a href="geographyQuizMain.jsp"> <img height="130" width="130" src = "images/Geography.png"/></a> </td>
                                                    <td><a href="t.jsp"> <img height="130" width="130" src = "images/Science.png"/></a> </td>
                                                   
                                                </tr>
                                                    <td><a href="historyQuizMain.jsp"> <img height="130" width="130" src = "images/History.png"/></a> </td>
                                                    <td><a href="ictQuizMain.jsp"> <img height="130" width="130" src = "images/ICT.png"/></a> </td>
                                                    <td><a href="mathsQuizMain.jsp"> <img height="130" width="130" src = "images/Maths.png"/></a> </td>
                                                    
                                                <tr>
                                                    <td></td>>
                                                     <td><a href="brainTeaserMain.jsp"> <img height="130" width="130" src = "images/brain.png"/></a> </td>
                                                </tr>

            </table>
    </div>
                                 
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
                            <script id="dsq-count-scr" src="//EXAMPLE.disqus.com/count.js" async></script>
</body>
</html>
