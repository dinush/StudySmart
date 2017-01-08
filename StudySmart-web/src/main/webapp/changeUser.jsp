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
                            openForm(this.id);
                        };
                    }
                    $('#users').DataTable({});
                });
                
                $('#form-panel').hide();
            });
            
            function openForm(username) {
                $('#form-panel').show();
                $.ajax({
                    url: "ws/search/user/exact/" + username,
                    async: true
                }) .done(function(data) {
                    data = data[0];
                    $('#form-username').html(data.username);
                    $('#form-panel-username').val(data.username);
                    $('#form-panel-name').val(data.name);
                    $('#form-panel-email').val(data.email);
                    $('#form-panel-gender').val(data.gender);
                    $('#form-panel-birthday').val(data.birthdate);
                    $('#form-panel-address').val(data.address);
                    $('#form-panel-nic').val(data.nic);
                    $('#form-panel-phone').val(data.tp);
                });
            }
            
            function submitChanges() {
                var username = $('#form-panel-username').val();
                var name = $('#form-panel-name').val();
                var password = $('#form-panel-password').val();
                var email = $('#form-panel-email').val();
                var gender = $('#form-panel-gender').val();
                var birthday = $('#form-panel-birthday').val();
                var address = $('#form-panel-address').val();
                var nic = $('#form-panel-nic').val();
                var phone = $('#form-panel-phone').val();
                
                // building data to POST
                var data = {};
                data.username = username;
                data.name = name;
                data.password = password ? password : null;
                data.email = email ? email : null;
                data.gender = gender ? gender : null;
                data.birthday = birthday ? birthday : null;
                data.address = address ? address : null;
                data.nic = nic ? nic : null;
                data.phone = phone ? phone : null;
                        
                // ajax call
                $.ajax({
                    type: "PUT",
                    url: "ChangeUser",
                    data: JSON.stringify(data),
                    success: function(data) {
                        alert(data);
                    }
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
            <li>Change users</li>
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
                                
                                <div id="form-panel" style="position: fixed; background-color: #fafafa; height: 80%; width: 70%; top:10%; left:15%; padding: 20px; overflow: auto; box-shadow: 0 0 16px; z-index: 100000">
                                    <span class="glyphicon glyphicon-remove" style="float: right; top: 20; right: 20; cursor: pointer;" onclick="$('#form-panel').hide();"></span>
                                    <h3>Changing details of <b><span id="form-username"></span></b></h3>
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <label for="form-panel-username" class="col-sm-2 control-label">Username</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="form-panel-username" class="form-control" disabled />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-name" class="col-sm-2 control-label">Full Name</label>
                                            <div class='col-sm-10'>
                                                <input type="text" id="form-panel-name" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-password" class="col-sm-2 control-label">Password</label>
                                            <div class='col-sm-10'>
                                                <input type="password" id="form-panel-password" placeholder="leave blank if don't want to change" class="form-control" />
                                            </div>
                                        </div>
                                        <div class='form-group'>
                                            <label for="form-panel-email" class="col-sm-2 control-label">Email</label>
                                            <div class='col-sm-10'>
                                                <input type="email" id='form-panel-email' class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-gender" class="col-sm-2 control-label">Gender</label>
                                            <div class="col-sm-10">
                                                <select id="form-panel-gender" class="form-control">
                                                    <option id="male">Male</option>
                                                    <option id="female">Female</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-birthday" class="col-sm-2 control-label">Birthday</label>
                                            <div class="col-sm-10">
                                                <input type="date" id="form-panel-birthday" class="form-control" placeholder="mm/dd/yyyy" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-address" class="col-sm-2 control-label">Address</label>
                                            <div class='col-sm-10'>
                                                <input type='text' id='form-panel-address' class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-nic" class="col-sm-2 control-label">NIC</label>
                                            <div class='col-sm-10'>
                                                <input type='text' id='form-panel-nic' class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="form-panel-phone" class="col-sm-2 control-label">Phone</label>
                                            <div class='col-sm-10'>
                                                <input type='text' id='form-panel-phone' class="form-control" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-2 col-sm-10">
                                                <button onclick="submitChanges()" class='btn btn-primary'>Accept changes</button>
                                            </div>
                                        </div>
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
