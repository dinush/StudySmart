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
        var resources_glob = [];
        
        function getSubjects() {
            $.ajax({
                url: "ws/rest/subjects/student/<% out.print(user.getUsername()); %>",
                async: true
            })
                    .done(function(data) {
                        var subject_select = document.getElementById("subject");
                        var subjects = "";
                        for(var i=0; i < data.length; i++) {
                            var subject = "<option value='" + data[i].id + "'>" + data[i].name + " " + data[i].id + "</option>";
                            subjects += subject;
                        }
                        subject_select.innerHTML = subjects;
                        getResources();
                    });
        }
        
        function getResources() {

            $.ajax({
                url: "ws/rest/resources/" + $('#subject').val(),
                async: true
            })
                    .done(function (data) {
                        var resources_elem = document.getElementById("resources");
                        resources_elem.innerHTML = "";
                        var resources = "";
                        for (var i = 0; i < data.length; i++) {
                            resources_glob.push(data[i]);
                            var resource = "<h4>" + data[i].topic + "</h4>";
                            resource += "<a href='" + data[i].url + "'>" + data[i].url + "</a>";
                            resource += "<div onclick=showEmbded('" + i + "') style='cursor:pointer; color:blue;'>(Embded)</div>";
                            resource += "<div id='" + i + "'></div>"
                            resource += "<hr>";
                            resources += resource;
                        }
                        resources_elem.innerHTML = resources;
                    });

        }
        
        function showEmbded(id) {
            var div = document.getElementById(id);
            var html = "<div class='embed-responsive embed-responsive-4by3'>";
            html += "<iframe class='embed-responsive-item' src='" + resources_glob[id].url + "'></iframe>";
            html += "</div>";
            div.innerHTML = html;
        }

        $(function () {
            getSubjects();
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

                                <div class="well">
                                    <h5>Select the subject</h5>
                                    <select id="subject" class="form-control" onchange="getResources()"></select>
                                </div>

                                <div id="resources">
                                    
                                </div>
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
