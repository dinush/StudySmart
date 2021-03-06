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
    </script>
    <script>
        function getQuestions(){
        <% 
            if (request.getParameter("subject") == null) {
                response.sendRedirect("index.jsp");
            } 
        %>
            var subjectid = '<% out.print(request.getParameter("subject")); %>';
            
            $.ajax({
                    url: "ws/rest/questions/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            if (data.length === 0) {
                                /* Feedback */
                                var panel = document.getElementById("quiz_panel");
                                panel.innerHTML = "<h3><small><i>No quizzes here</i></small></h3>";
                                return;
                            }
                            var qpanel = document.getElementById("quiz_panel");
                            if (data.length > 0) {
                                var subject_view = document.getElementById("subject");
                                subject_view.innerHTML = "Quizes for " + data[0].subject_name + "<hr>";
                            }
                            var pbody = "";
                            for(var i=0; i < data.length; i++) {
                                var presen = "<h4>" + data[i].question + "</h4>";
                                presen += "<ul class='qlist list-group'>";
                                presen += "<li class='list-group-item'>" + data[i].option1 + "</li>";
                                presen += "<li class='list-group-item'>" + data[i].option2 + "</li>";
                                presen += "<li class='list-group-item'>" + data[i].option3 + "</li>";
                                presen += "<li class='list-group-item'>" + data[i].option4 + "</li>";
                                presen += "</ul>";
                                presen += "<div style='cursor:pointer;color:blue' onclick=this.innerHTML='"+data[i].answer+"'><b>Click to show answer</b></div><hr>";
                                
                                pbody += presen;
                            }
                            
                            qpanel.innerHTML = pbody;
                        });
            
        }
        
        $(function() {
            getQuestions();
        })
       
    </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="vleMainInterface.jsp">VLE</a></li>
            <li><a href="quizMain.jsp">Quizzes</a></li>
            <li>View quizzes</li>
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
                                <h3 id="subject"></h3>
                                <div id="quiz_panel"></div>
                               
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
