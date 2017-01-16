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
        <link rel="stylesheet" href="css/sweetalert.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/sweetalert.min.js"></script>
        <% if (request.getParameter("msg") != null) { %>
        <script>
            $(function() {
                swal({
                        title: "<% out.print(request.getParameter("msg")); %>",
                        type: "success"
                      });
             });
        </script>
        <% } %>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
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
                            <div id="main-content" class="col-md-12">
                               
                            <table style="width:100%;">
                                    <tr>
                                      <td><a href="teachURLInsertMain.jsp" ><img src="images/URL.png"  style="width:200px;height:120px;  margin-left:60px"></a></td>
                                      
                                      <td><a href="categories.jsp"><img src="images/teacher.png" align="center" style="width:320px;height:130px;"></a></td>
                                    </tr>
                                    <tr>
                                     <td><h5><font size="5"  style=" margin-left:30px"><b>Insert External Resources&nbsp;&nbsp;&nbsp;</font></td>
                                     <td><h5><font size="5"><b>Manage Discussion Forum</font></td>
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
                                     <td><a href="uploadFile.jsp" ><img src="images/ebook.png" alt="HTML5 Icon" style="width:250px;height:150px; margin-left:60px"></a></td>
                                     <td><a href="teachQuizMain.jsp" ><img src="images/individual.png" alt="HTML5 align="left"  Icon" style="width:150px;height:150px; margin-left:80px"></a></td>
                                    </tr>
                                    
                                    <tr>
                                     <td><h5><font size="5" style=" margin-left:30px"><b>Add Student Resources</font></td>
                                     <td><h5><font size="5"  style=" margin-left:55px "><b>Create Quizzes</font></td>
                                    </tr>
                                  </table>
                                
                            </div>   
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
