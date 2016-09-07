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
        <link rel="stylesheet" href="css/selectize.bootstrap2.css" />
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/selectize.min.js"></script>
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});

                $.ajax({
                    url: "ws/rest/students",
                    async: true
                })
                        .done(function (data) {
                            var students_sel = document.getElementById("students");
                            students_sel.innerHTML = "<option disabled selected value=''>Select students belong to this parent</option>";
                            for (var i = 0; i < data.length; i++) {
                                var row = "<option name='students' value='" + data[i].id + "'>" + data[i].name + " (" + data[i].id + ")</option>";
                                students_sel.innerHTML += row;
                            }
                            $('#students').selectize({
                                persist: false,
                                maxItems: null
                            });
                        });

            });
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
                                    <li role="presentation"><a href="registerStudent.jsp">Student</a></li>
                                    <li role="presentation" class="active"><a href="#">Parent</a></li>
                                    <li role="presentation"><a href="registerTeacher.jsp">Teacher</a></li>
                                    <li role="presentation"><a href="registerPrincipal.jsp">Principal</a></li>
                                    <li role="presentation"><a href="registerSystemAdmin.jsp">System Admin</a></li>
                                </ul> 
                                <br>
                                <h1><span class="glyphicon glyphicon-plus" aria-hidden="true" style="color:#428bca"></span><i><u>Add New Parent</u></i></h1>
                                <h5><span style="color:#cc0000;">* Please fill all the fields before submitting </span></h5>

                                
                                <!--adding student registration-->

                                <br>
                                <form name="myform" method="post" action="Admin?action=registerparent" onsubmit="return validateForm();">
                                    <div class="form-group row">
                                        <label for="username" class="col-xs-2 col-form-label">Username</label>
                                        <div class="col-xs-10">                                      
                                            <input required class="form-control" type="text" placeholder="Username" name="username" id="username">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="name" class="col-xs-2 col-form-label">Name</label>
                                        <div class="col-xs-10">                                      
                                            <input required class="form-control" type="text" placeholder="Name" name="name" id="name">
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
                                        <label for="nic" class="col-xs-2 col-form-label">NIC </label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="XXXXXXXXXV" name="nic" id="nic">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="address" class="col-xs-2 col-form-label">Address</label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="Address" id="address" name="address">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="occupation" class="col-xs-2 col-form-label">Occupation</label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="Occupation" id="occupation" name="occupation">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="phone" class="col-xs-2 col-form-label">Phone</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="tel" placeholder="0XX-XXXXXXX" name="phone" id="phone">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="email" class="col-xs-2 col-form-label">Email</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" name="email" type="email" placeholder="sample@host.com" id="email">
                                        </div>
                                    </div>
                                    <br>  
                                    <div class="form-group row">
                                        <label for="students" class="col-xs-2 col-form-label">Belongings</label>
                                        <div class="col-xs-10">
                                            <select required name="students" id="students"></select>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary" style="float: right"><h4> Register</h4> </button>
                                    <!-- finishing student registration-->
                                </form>
                            </div>

                            <!--validation-->

                            <script>
                                function validateEmail()
                                {
                                    var x = document.myform.email.value;
                                    var atposition = x.indexOf("@");
                                    var dotposition = x.lastIndexOf(".");
                                    if (x !== "") {
                                        if (atposition < 1 || dotposition < atposition + 2 || dotposition + 2 >= x.length) {
                                            alert("Please enter a valid e-mail address!");
                                            return false;
                                        }
                                    }
                                    return true;
                                }

//                                function validateEmail() {
//                                var email = document.myform.email.value;
//                                var re = "/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/";
//                                if (re.test(email)===false){
//                                alert("Wrong email format!");
//                                return false;
//                                }
//
//                                }
                                function validateTP() {
                                    var tp = document.myform.phone.value;
                                    console.log("DEBUG tp -> " + tp);
                                    var re = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;
                                    if ((re.test(tp) === false) && tp !== "") {
                                        alert("Wrong telephone number format!");
                                        return false;
                                    }
                                    return true;
                                }




                                function validateName() {

                                    var nm = document.myform.nm.value;
                                    var nic = document.myform.nic.value;
                                    console.log("DEBUG vname ->");
                                    if (nm === "" || nic === "") {
                                        alert("Please make sure you have filled the compulsory fields");
                                        return false;
                                    }
                                    return true;
                                }

                                function validateForm() {

                                    var validation = true;
                                    if ((validateName() && validateTP() && validateEmail()) === true) {
                                        return validation;
                                    }
                                    return false;
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
