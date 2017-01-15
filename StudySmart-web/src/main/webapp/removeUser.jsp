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
<%--<%@include file="utils/database.jsp" %>--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/main.css" />
        <link rel="stylesheet" href="css/jquery.dataTables.min.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script>
            $(function() {
                
                $.ajax({
                    url: "ws/lk.studysmart.apps.models.user",
                    async: true
                }) .done (function (data) {
                    var table = document.getElementById("table_body");
                    for (var i=0; i < data.length; i++) {
                        var row = table.insertRow(-1);
                        var cell_username = row.insertCell(0);
                        var cell_name = row.insertCell(1);
                        var cell_gender = row.insertCell(2);
                        var cell_email = row.insertCell(3);
                        var cell_birthday = row.insertCell(4);
                        var cell_address = row.insertCell(5);
                        
                        row.id = data[i].username;
                        row.style = "cursor:pointer;";
                        cell_username.innerHTML = data[i].username;
                        cell_name.innerHTML = data[i].name;
                        cell_gender.innerHTML = (data[i].gender !== undefined) ? data[i].gender : "";
                        cell_email.innerHTML = (data[i].email !== undefined) ? data[i].email : "";
                        cell_birthday.innerHTML = (data[i].birthdate !== undefined) ? data[i].birthdate.split("T")[0] : "";
                        cell_address.innerHTML = (data[i].address !== undefined) ? data[i].address : "";
                        
                        row.onclick = function() {
                            removeUser(this.id);
                        };
                    }
                    $('#users').DataTable({});
                });
                
                $('#form-panel').hide();
            });
            
            function removeUser(username) {
                var ret = confirm("Are you sure to remove the user " + username + "?");
                if (!ret)
                    return;
                $.ajax({ 
                    url: "ws/admin/removeuser/" + username,
                    async: true,
                    type: "DELETE"
                }) .done(function(data) {
                    location.reload();
                });
            }
            
            
        </script>
    <title>StudySmart</title>
</head>
<body>
    <div class="container">
        <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
        <!-- Path -->
        <ol class="breadcrumb">
            <li><a href="index.jsp">Home</a></li>
            <li>Remove users</li>
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
                                <% if(request.getParameter("msg") != null) { %>
                                <script>
                                    alert("<% out.print(request.getParameter("msg"));%>");
                                </script>
                                <% } %>
                                <table id="users" cellspacing="0" class="display dataTable">
                                    <thead>
                                        <tr>
                                            <th>Username</th>
                                            <th>Full Name</th>
                                            <th>Gender</th>
                                            <th>Email</th>
                                            <th>Birthday</th>
                                            <th>Address</th>
                                        </tr>
                                    </thead>
                                    <tbody id="table_body">
                                        
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
