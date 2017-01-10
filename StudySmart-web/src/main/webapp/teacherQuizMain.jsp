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
                                <ul class="nav nav-tabs">
                                    <li role="presentation" class="active"><a href="#">Create Quiz</a></li>
                                    <li role="presentation" ><a href="viewQuizMark.jsp">View Marks</a></li>
                                    <li role="presentation" ><a href="uploadBrainTeaseQuiz.jsp">Upload File</a></li><br>
                                 </ul>
                                        <br>
                                        <div>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                  <div class="input-group">
                                                    <div class="input-group-btn">
                                                      <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Select Subject <span class="caret"></span></button>
                                                      <ul class="dropdown-menu">
                                                        <li><a href="#">Science</a></li>
                                                        <li><a href="#">Maths</a></li>
                                                        <li><a href="#">English</a></li>
                                                      </ul>
                                                      </div><!-- /btn-group -->
                                                </div><!-- /input-group -->
                                              </div><!-- /.col-lg-6 -->
                                            </div><!-- /.row -->
                                            <br>
                                        
                                        <div class="form-group">
                                            <input type="text" size="10px" class="form-control"  placeholder="Enter Quiz ID">
                                        </div>
                                            
                                       
                                            <form>
                                                First Question:<br>
                                                    <div class="form-group">
                                                        <input type="text" size="10px" class="form-control"  placeholder="Enter First Question Here">
                                                    </div>
                                                 First Answer:<br>
                                                    <div class="form-group">
                                                        <input type="text" size="10px" class="form-control"  placeholder="Enter  First Answer Here">
                                                    </div>
                                                 Second Answer:<br>
                                                    <div class="form-group">
                                                        <input type="text" size="10px" class="form-control"  placeholder="Enter  Second Answer Here">
                                                    </div>
                                                 Third Answer:<br>
                                                    <div class="form-group">
                                                        <input type="text" size="50px" class="form-control"  placeholder="Enter  Third Answer Here">
                                                    </div>
                                                 Forth Answer:<br>
                                                    <div class="form-group">
                                                        <input type="text" size="10px" class="form-control"  placeholder="Enter Fourth Answer Here">
                                                    </div>
                                                 Correct Answer:<br>
                                                    <div class="form-group">
                                                        <select name="quizID">
                                                            <option value="ENG001">Answer 1</option>
                                                            <option value="ENG002">Answer 2</option>
                                                            <option value="ENG003">Answer 3</option>
                                                            <option value="ENG004">Answer 4</option>
                                                        </select>
                                                    </div>
                                                 
<!--                                                 Select Correct Answer:<br> -->
                                               
                                            </form>
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
