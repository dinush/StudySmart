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
                               
                                <form>
                                <label for="exampleInputEmail1" >Select Subject</label>     
                                <select class="form-control" id="subject" name="subject" >
                                    <option>Science</option>
                                    <option>History</option>
                                    <option>ICT</option>
                                    <option>Geography</option>
                                 </select>
                                    <br>
                                    <br>
                                    <br>
                                    
                                    
                                
                                    <div class="form-group">
                                      <label for="exampleInputEmail1">Question 1</label>
                                      <input type="email" class="form-control" id="q1" name="q1" placeholder="Question">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 1</label>
                                      <input type="password" class="form-control" id="a11" name="a11" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 2</label>
                                      <input type="password" class="form-control" id="a12" name="a12" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 3</label>
                                      <input type="password" class="form-control" id="a13" name="a13" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 4</label>
                                      <input type="password" class="form-control" id="a14" name="a14" placeholder="Answer">
                                    </div>
  
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Correct Answer</label>
                                      <input type="password" class="form-control" id="a1" name="a1" placeholder="Correct Answer">
                                    </div>
                                    
                                    <br>
                                    -------------------------------------------------------------------------------------------------------------------------------
                                    <br>
                                    <br>
                                    
                                    <div class="form-group">
                                      <label for="exampleInputEmail1">Question 2</label>
                                      <input type="email" class="form-control" id="q2" name="q2" placeholder="Question">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 1</label>
                                      <input type="password" class="form-control" id="a21" name="a21" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 2</label>
                                      <input type="password" class="form-control" id="a22" name="a22" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 3</label>
                                      <input type="password" class="form-control" id="a23" name="a23" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 4</label>
                                      <input type="password" class="form-control" id="a24" name="a24" placeholder="Answer">
                                    </div>
  
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Correct Answer</label>
                                      <input type="password" class="form-control" id="a2 name="a2" placeholder="Correct Answer">
                                    </div>
                                    
                                    <br>
                                    -------------------------------------------------------------------------------------------------------------------------------
                                    <br>
                                    <br>
                                    
                                    <div class="form-group">
                                      <label for="exampleInputEmail1">Question 3</label>
                                      <input type="email" class="form-control" id="q3" name="q3" placeholder="Question">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 1</label>
                                      <input type="password" class="form-control" id="a31" name="a31" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 2</label>
                                      <input type="password" class="form-control" id="a32" name="a32" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 3</label>
                                      <input type="password" class="form-control" id="a33" name="a33" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 4</label>
                                      <input type="password" class="form-control" id="a34" name="a34" placeholder="Answer">
                                    </div>
  
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Correct Answer</label>
                                      <input type="password" class="form-control" id="a3" name="a3" placeholder="Correct Answer">
                                    </div>
                                    
                                    <br>
                                    -------------------------------------------------------------------------------------------------------------------------------
                                    <br>
                                    <br>
                                    
                                    <div class="form-group">
                                      <label for="exampleInputEmail1">Question 4</label>
                                      <input type="email" class="form-control" id="q4" name="q4" placeholder="Question">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 1</label>
                                      <input type="password" class="form-control" id="a41" name="a41" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 2</label>
                                      <input type="password" class="form-control" id="a42" name="a42" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 3</label>
                                      <input type="password" class="form-control" id="a43" name="a43" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 4</label>
                                      <input type="password" class="form-control" id="a44" name="a44" placeholder="Answer">
                                    </div>
  
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Correct Answer</label>
                                      <input type="password" class="form-control" id="a4" name="a4" placeholder="Correct Answer">
                                    </div>
                                    
                                    <br>
                                    -------------------------------------------------------------------------------------------------------------------------------
                                    <br>
                                    <br>
                                    
                                    <div class="form-group">
                                      <label for="exampleInputEmail1">Question 5</label>
                                      <input type="email" class="form-control" id="q1" name="q1" placeholder="Question">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 1</label>
                                      <input type="password" class="form-control" id="a51" name="a51" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 2</label>
                                      <input type="password" class="form-control" id="a52" name="a52" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 3</label>
                                      <input type="password" class="form-control" id="a53" name="a53" placeholder="Answer">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Answer 4</label>
                                      <input type="password" class="form-control" id="a54" name="a54" placeholder="Answer">
                                    </div>
  
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Correct Answer</label>
                                      <input type="password" class="form-control" id="a5" name="a5" placeholder="Correct Answer">
                                    </div>
                                    
                                    <br>
                                   
                                    
                                   
                                    <button type="submit" class="btn btn-default">Submit</button>
                                 </form>
                                                                               
                                    
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
