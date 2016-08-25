<%-- 
    Document   : login
    Created on : Jun 25, 2016, 11:48:15 PM
    Author     : dinush
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Object user = session.getAttribute("username");
    if (user != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/main.css" />
        <link rel="stylesheet" href="css/login.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <title>Login - StudySmart</title>
    </head>
    <body>
        <div class="container">
            <div class="page-header">
                <div id="page-title">
                    <h1><small>Welcome to</small><br />Study Smart <small>Learning Management System</small></h1>
                </div>     
            </div>
            <table border="0" >
                <tr>
                    <td valign="top" class="table-col-max">
                        
                         
                            <!--Adding the general news feed-->
                            
                            <div class="panel panel-primary" style="margin-top:-12px;">
                                <div class="panel-heading">
                                    <h1 class="panel-title"><i><b>General News Feed</b></i></h1>
                                </div>
                            </div>
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title">8/25/2016</h3>
                                </div>
                                <div class="panel-body">
                                    The annual school assembly will be held on 8th September 2016. All studetns are required to be present st the school grounds at 8.00 am. 
                                </div>
                                <div class="panel-footer">Author: Sisinda Dinush</div>
                            </div>
                                
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title">02/02/2016</h3>
                                </div>
                                <div class="panel-body">
                                    The school Sports Day is scheduled to be held on the 02/28/2016 at the Sugathadasa Stadium.
                                </div>
                                    <div class="panel-footer">Author: Sisinda Dinush</div>
                                </div>
                                
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                      <h3 class="panel-title">01/30/2016</h3>
                                    </div>
                                    <div class="panel-body">
                                      The school calender for the year 2016 has been uploaded. Please check the attachment below. 
                                    </div>
                                    <div class="panel-footer">Author: Sisinda Dinush</div>
                                </div>
                           
                            <a href="#" style="float:right;"> <i>See older topics..</i>
                            
                            <!--general news feed ends here-->
                            
                            
                        <div class="overview hidden-xs">
                           
                            <table border="0" hidden="true">
                                <tr>
                                    <td>
                                        <img src="images/academic.png" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td valign="top" class="table-col-fixed">
                        <div class="login-form">
                            <img src="images/logo-big.png" height="130px" />
                            <form action="userlogin" method="POST">
                                <% if (request.getParameter("msg") != null) { %>
                                <div class="alert alert-warning alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <strong>Error : </strong> ${fn:escapeXml(param.msg)}
                                </div>
                                <% }%>
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Username" name="username">
                                    <input type="password" class="form-control" placeholder="Password" name="password">
                                </div>
                                <button type="submit" class="btn btn-default">Sign in</button>
                            </form>
                        </div>  
                                
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
