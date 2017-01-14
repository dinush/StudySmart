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
        function getResources(){
        <% if (request.getParameter("subject") == null) { %>
                window.location = "index.jsp?msg=No subject selected";
        <% } %>
            var subjectid = "<% out.print(request.getParameter("subject")); %>";
            
            $.ajax({
                    url: "ws/resources/get/list/internal/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            console.log(JSON.stringify(data));
                            var tbl_body = document.getElementById("resource_table_body");
                            for (var i=0 ; i < data.length; i++) {
                                var row = tbl_body.insertRow(-1);
                                
                                var cell_filename = row.insertCell(0);
                                var cell_uploaded_person = row.insertCell(1);
                                
                                cell_filename.innerHTML = data[i].filename;
                                cell_uploaded_person.innerHTML = data[i].uploader_name;
                            }
                        });
            
        }
        
        $(function() {
            getResources();
        });
       
    </script>
    <title>StudySmart</title>   
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeaderVLE.jspf" %>
     
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
                                <table id="resource_table" class="table">
                                    <thead>
                                        <th>Filename</th>
                                        <th>Uploaded person name</th>
                                    </thead>
                                    <tbody id="resource_table_body">
                                        
                                    </tbody>
                                </table>
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
