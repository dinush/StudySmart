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
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                $('#bday-container input').datepicker({
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
                            for(var i=0; i<data.length;i++) {
                                var row = "<tr>";
                                row += "<td>" + data[i].name + "</td>";
                                row += "<td><input type='checkbox' value='" + data[i].id + "'/></td>";
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
        <div class="page-header">
            <div id="page-title">
                <h1>Study Smart</h1>
            </div>                
            <div class="user-details">
                Signed in as:
                <span id="user-name">
                    <%                        out.print(user.getName());
                    %>
                </span>
                <a href="logout">
                    (logout)
                </a>                    
            </div>
        </div>
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
                                <h1><span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="label label-primary">Add New Student</span></h1>


                                <br>
                                <br>
                                <!--adding student registration(with validation)-->
                                <form name="myform" method="post" action="#" onsubmit="return validateForm();">
                                    <div class="form-group row">
                                        <label for="username" class="col-xs-2 col-form-label">Student ID (Username):</label>
                                        <div class="col-xs-10">
                                            <input name="username" required type="text" class="form-control" id="username" placeholder="Username">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Student Name:</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="text" placeholder="Artisanal kale" name="name" id="example-text-input">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-date-input" class="col-xs-2 col-form-label">Birth Date:</label>
                                        <div id="bday-container" class="col-xs-10">
                                            <input class="form-control" type="date" placeholder="2011-08-19" id="bd" name="bdate">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2"><b>Gender: </b></div>
                                        <div class="col-lg-4">
                                            <select name="gender" class="form-control">
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <br>

                                    <div class="form-group row">
                                        <label for="example-email-input" class="col-xs-2 col-form-label">Email:</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="email" name="email" placeholder="artisanal@example.com" id="example-email-input">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2"><b>Entering Grade: </b></div>
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
                                                    <th>Subject</th>
                                                    <th>Enroll</th>
                                                </tr>
                                            </thead>
                                            <tbody id="sub-enroll-tbl">
                                                <!--Ajax fill-->
                                            </tbody>
                                        </table>
                                    </div>
                                    <br><br>
                                    <span>
                                        <h3><u> Guardian's Information</u> </h3> <h4 style="padding-left: 110px;">(Contact in case of Emergency)</h4>
                                    </span>
                                    <br>
                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Guardian Name:</label>
                                        <div class="col-xs-10">
                                            <span style="color:#d9534f;"> *</span>
                                            <input class="form-control" type="text" placeholder="Artisanal kale" name="name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">NIC: </label>
                                        <div class="col-xs-10">
                                            <span style="color:#d9534f;"> *</span>
                                            <input class="form-control" type="text" placeholder="XXXXXXXXXV" name="nic">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-email-input" class="col-xs-2 col-form-label">Guardian Email:</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="email" placeholder="artisanal@example.com" id="example-email-input">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-tel-input" class="col-xs-2 col-form-label">Telephone</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="tel" placeholder="07X-XXXXXXX" id="example-tel-input">
                                        </div>
                                    </div>
                                    <br>


                                    <button type="submit" class="btn btn-primary" style="margin-left:520px;"><h4> Register</h4> </button>
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
                                }

                                function validateName() {
                                    var nm = document.myform.stuname.value;
                                    var gnm = document.myform.gname.value;
                                    var nic = document.myform.nic.value;
                                    var day = document.myform.bd.value;
                                    if (nm === "" || nic === "" || day === "" || gnm === "") {
                                        alert("Please make sure you have filled the compulsory fields");
                                        return false;
                                    }
                                    return true;
                                }

                                function validateForm() {

                                    {
                                        var validation = true;
                                        if ((validateName() && validateEmail()) == true)
                                            return validation;

                                    }
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
