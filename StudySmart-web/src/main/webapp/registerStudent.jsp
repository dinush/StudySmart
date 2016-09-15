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
        <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css"/>
        <link rel="stylesheet" href="css/bootstrap-datepicker3.standalone.min.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- Special version of Bootstrap that only affects content wrapped in .bootstrap-iso -->
        <!--<link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />--> 

        <!--Font Awesome (added because you use icons in your prepend/append)-->
        <!--<link rel="stylesheet" href="https://formden.com/static/cdn/font-awesome/4.4.0/css/font-awesome.min.css" />-->

        <!-- Inline CSS based on choices in "Settings" tab -->
        <!--<style>.bootstrap-iso .formden_header h2, .bootstrap-iso .formden_header p, .bootstrap-iso form{font-family: Arial, Helvetica, sans-serif; color: black}.bootstrap-iso form button, .bootstrap-iso form button:hover{color: white !important;} .asteriskField{color: red;}</style>-->
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                $('#bday-container input').datepicker({
                    endDate: new Date()
                });

                $.ajax({
                    url: "ws/rest/classes",
                    async: true
                })
                        .done(function (data) {
                            var class_sel = document.getElementById("class");
                            class_sel.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option value='" + data[i].id + "'>Grade " + data[i].name + "</option>";
                                class_sel.innerHTML += row;
                            }
                            loadSubjects(document.getElementById('class'));
                        });
            });

            function loadSubjects(sel) {
                $.ajax({
                    url: "ws/rest/subjects/" + sel.value,
                    async: true
                })
                        .done(function (data) {
                            var plh = document.getElementById("sub-enroll-tbl");
                            plh.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].id + "</td>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "<td><input type='checkbox' name='subjects[]' value='" + data[i].id + "'/></td>";
                                plh.innerHTML += row;
                            }
                        })
            }

        </script>


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
                                    <li role="presentation" class="active"><a href="#">Student</a></li>
                                    <li role="presentation"><a href="registerParent.jsp">Parent</a></li>
                                    <li role="presentation"><a href="registerTeacher.jsp">Teacher</a></li>
                                    <li role="presentation"><a href="registerPrincipal.jsp">Principal</a></li>
                                    <li role="presentation"><a href="registerSystemAdmin.jsp">System Admin</a></li>
                                </ul> 
                                <br>
                                <h1><span class="glyphicon glyphicon-plus" aria-hidden="true" style="color:#428bca"></span><i><u>Add New Student</u></i></h1>

                                <h5><span style="color:#cc0000;">* Please fill all the fields before submitting </span></h5>
                                
                                <br>

                                <!--adding student registration(with validation)-->
                                
                                
                                
                                <form name="myform" method="post" action="Admin?action=registerstudent" onsubmit="return validateForm();">
                                    <div class="form-group row">
                                        <label for="username" class="col-xs-2 col-form-label">Student ID (Username)</label>
                                        <div class="col-xs-10">
                                            <input name="username" required type="text" class="form-control" id="username" placeholder="Username">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Student Name </label>

                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="Name" name="name" id="example-text-input">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-date-input" class="col-xs-2 col-form-label">Birth Date</label>
                                        <div id="bday-container" class="col-xs-10">
                                            <input required class="form-control" type="date" placeholder="Birth Date" id="bd" name="bdate">
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-lg-2"><b>Gender </b></div>
                                        <div class="col-lg-4">
                                            <select name="gender" class="form-control">
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <br>
                                    
                                     <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Address </label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="text" placeholder="Peterson Lane, Col 05" name="add" id="add">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group row">
                                        <label for="example-email-input" class="col-xs-2 col-form-label">Email</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="email" name="email" placeholder="sample@host.com" id="example-email-input">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2"><b>Entering Grade </b></div>
                                        <div class="col-lg-4">
                                            <select id="class" name="class" class="form-control" onchange="loadSubjects(this)">
                                                <!--Populated by ajax call-->
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Subject ID</th>
                                                    <th>Subject Name</th>
                                                    <th>Enroll</th>
                                                </tr>
                                            </thead>
                                            <tbody id="sub-enroll-tbl">
                                                <!--Ajax fill-->
                                            </tbody>
                                        </table>
                                    </div>
                                    <br>

                                    <button type="submit" class="btn btn-primary" style="float:right;"><h4> Register</h4> </button>
                                </form>
                                <!-- finishing student registration-->
                            </div>


                            <!--email validation-->

                            <script>
                                function validateEmail()
                                {
                                    var x = document.myform.email.value;
                                    var atposition = x.indexOf("@");
                                    var dotposition = x.lastIndexOf(".");
                                    if (atposition < 1 || dotposition < atposition + 2 || dotposition + 2 >= x.length) {
                                        alert("Please enter a valid e-mail address!");
                                        return false;
                                    }
                                    return true;
                                }
                                function validateTP() {
                                    var tp = document.myform.tp.value;
                                    console.log("DEBUG tp -> " + tp);
                                    var re = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;
                                    if ((re.test(tp) === false) && tp !== "") {
                                        alert("Wrong telephone number format!");
                                        return false;
                                    }
                                    return true;
                                }

                                function validateForm() {
                                    return validateEmail();
                                }


                            </script>  


                            <!--ends here-->

                           
                            <div class="col-md-4">
                                <%@ include file="WEB-INF/jspf/Infopanel.jspf" %>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
