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
        <!-- Special version of Bootstrap that only affects content wrapped in .bootstrap-iso -->
        <link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" /> 

        <!--Font Awesome (added because you use icons in your prepend/append)-->
        <link rel="stylesheet" href="https://formden.com/static/cdn/font-awesome/4.4.0/css/font-awesome.min.css" />

        <!-- Inline CSS based on choices in "Settings" tab -->
        <style>.bootstrap-iso .formden_header h2, .bootstrap-iso .formden_header p, .bootstrap-iso form{font-family: Arial, Helvetica, sans-serif; color: black}.bootstrap-iso form button, .bootstrap-iso form button:hover{color: white !important;} .asteriskField{color: red;}</style>
        <link rel="stylesheet" href="css/main.css" />
        <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css"/>
        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script type = "text/javascript" >
            $(function () {
                getSubjects();
            });

            function checkUsername(elem) {
                var username = $(elem).val();
                $.ajax({
                    url: "ws/search/user/exact/" + username,
                    async: true
                })
                        .done(function (data) {
                            var err_div = document.getElementById("username-error");
                            if (data.length > 0) {
                                err_div.innerHTML = $(elem).val() + " already exists!";
                                $(elem).val('');
                                $(err_div).show();
                            } else {
                                $(err_div).hide();
                            }
                        });
            }

            function getSubjects() {
                $.ajax({
                    url: "ws/rest/subjects/all",
                    async: true
                })
                        .done(function (data) {   // TODO get classes
                            var subjects = document.getElementById("subjects");
                            subjects.innerHTML = '';
                            for (var i = 0; i < data.length; i++) {
                                var row = "<div class='checkbox' style='float:left; width:46%; margin:10px;'>";
                                row += "<label>";
                                row += "<input class='subj' type='checkbox' name='subjects' value='";
                                row += data[i].id;
                                row += "' onchange='selActivator(this)'>";
                                row += data[i].name + " (id: " + data[i].id + ")";
                                row += "</label>";
                                // Get classes of this grade
                                $.ajax({
                                    url: "ws/rest/classes/" + data[i].grade,
                                    async: false
                                })
                                        .done(function (classData) {
                                            row += "<div>";
                                            row += "<select multiple disabled class='form-control' name='" + data[i].id + "_class' id='" + data[i].id + "_class' style='height:70px;'>";
                                            for (var j = 0; j < classData.length; j++) {
                                                row += "<option value='" + classData[j].id + "'>Grade " + classData[j].grade + " " + classData[j].subclass + "</option>";
                                            }
                                            row += "</select>";
                                            row += "</div>";
                                        });
                                row += "</div>";
                                subjects.innerHTML += row;
                            }
                        });
            }

            function selActivator(elem) {
                if (elem.checked) {
                    document.getElementById(elem.value + "_class").disabled = false;
                } else {
                    document.getElementById(elem.value + "_class").disabled = true;
                }
            }

            function validateAndSend() {
                var subjs = document.getElementsByClassName("subj");
                for (var i = 0; i < subjs.length; i++) {
                    if (subjs[i].checked) {
                        var vals = getSelectValues(document.getElementById(subjs[i].value + "_class"));
                        if (vals.length === 0) {
                            alert("Invalid subject assigning detected. Please check again.");
                            return false;
                        }
                    }
                }
                return true;
            }

            // Return an array of the selected option values
            function getSelectValues(select) {
                var result = [];
                var options = select && select.options;
                var opt;

                for (var i = 0, iLen = options.length; i < iLen; i++) {
                    opt = options[i];

                    if (opt.selected) {
                        result.push(opt.value || opt.text);
                    }
                }
                return result;
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
                                    <li role="presentation"><a href="registerStudent.jsp">Student</a></li>
                                    <li role="presentation" ><a href="registerParent.jsp">Parent</a></li>
                                    <li role="presentation" class="active"><a href="#">Teacher</a></li>
                                    <li role="presentation"><a href="registerPrincipal.jsp">Principal</a></li>
                                    <li role="presentation"><a href="registerSystemAdmin.jsp">System Admin</a></li>
                                </ul> 
                                <br>
                                <h1><span class="glyphicon glyphicon-plus" aria-hidden="true" style="color:#428bca"></span><i><u>Add New Teacher</u></i></span></h1>


                                <br>
                                <!--adding teacher registration-->

                                <br>
                                <form name="myform" method="post" action="Admin?action=register/teacher" onsubmit="return validateForm();">
                                    <div class="form-group row">
                                        <label for="id" class="col-xs-2 col-form-label">Username </label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="Username" name="username" id="username" onchange="checkUsername(this)">
                                        </div>
                                        <div class="col-xs-10" id="username-error" hidden style="color:red; float:right;"></div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="name" class="col-xs-2 col-form-label">Name </label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="Name with initials" name="name" id="name">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2"><b>Gender </b></div>
                                        <div class="col-lg-4">
                                            <select name="gender" class="form-control">
                                                <option value="1">Male</option>
                                                <option value="2">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <br>

                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">NIC </label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="XXXXXXXXXV" name="nic" id="nic">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Address</label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="text" placeholder="Address" name="address" id="add">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-tel-input" class="col-xs-2 col-form-label">Telephone</label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="tel" placeholder="0XX-XXXXXXX" name="tp" id="tp">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="email" class="col-xs-2 col-form-label">Email</label>
                                        <div class="col-xs-10">
                                            <input required class="form-control" type="email" name="email" placeholder="example@example.com" id="email">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="qualifications" class="col-xs-2 col-form-label">Qualifications </label>
                                        <div class="col-xs-10">
                                            <input required type="Description" name="qualifications" class="form-control" id="qualifications">
                                        </div>
                                    </div>
                                    <hr>
                                    <!--Show all subjects-->
                                    <h4>Teaching subjects and classes</h4>                                    
                                    <div id="subjects" class="form-group row">

                                    </div>

                                    <button type="submit" onclick="validateAndSend()" class="btn btn-primary" style="float:right;">Register</button>
                                    <!-- finishing student registration-->
                                </form>
                            </div>


                            <!--validation-->

                            <script>
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
                                    //Username max 8 characters
                                    var un = document.myform.username.value;
                                    console.log(un);
                                    if(un.length > 8) {
                                        alert("Username can have 8 characters max");
                                        return false;
                                    }
                                    
                                    return validateTP();
                                }


                            </script>  


                            <!--ends here-->

                            <!--date picker-->
                            <!-- Include Date Range Picker -->
                            <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
                            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

                            <script>
                                $(document).ready(function () {
                                    var date_input = $('input[name="date"]'); //our date input has the name "date"
                                    var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                                    date_input.datepicker({
                                        format: 'mm/dd/yyyy',
                                        container: container,
                                        todayHighlight: true,
                                        endDate: '+0d',
                                        autoclose: true
                                    });
                                });
                            </script>

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
