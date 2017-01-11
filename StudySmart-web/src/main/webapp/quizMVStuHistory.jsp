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
            var subjectid = "006";
            
            $.ajax({
                    url: "ws/rest/questions/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            var qpanel = document.getElementById("quiz_panel");
                            var pbody = "";
                            for(var i=0; i < data.length; i++) {
                                var presen = "<h3>" + data[i].question + "</h3>";
                                presen += "<ul class='qlist'><li>" + data[i].option1 + "</li>";
                                presen += "<li>" + data[i].option2 + "</li>";
                                presen += "<li>" + data[i].option3 + "</li>";
                                presen += "<li>" + data[i].option4 + "</li>";
                                presen += "</ul>";
                                presen += "<div style='cursor:pointer;color:blue' onclick=this.innerHTML='"+data[i].answers+"'><b>Click to show answer</b></div>";
                                console.log(presen);
                                
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
                                <label for="exampleInputEmail1" >Select Subject</label>     
                                <select class="form-control" id="subject" name="subject" onchange="getQuestions()"   >
                                    <option value="002">Science</option>
                                    <option value="001">Maths</option>
                                    <option value="004">ICT</option>
                                    <option value="003">English</option>
                                </select>
                                
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
