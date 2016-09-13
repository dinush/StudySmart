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
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script type = "text/javascript" >
            $(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
                getSubjects();
            });
            
            function getSubjects() {
                $.ajax({
                    url: "ws/rest/subjects/all",
                    async: true
                })
                        .done(function(data) {
                            var subjects = document.getElementById("subjects");
                            subjects.innerHTML = '';
                            for(var i=0; i < data.length; i++) {
                                var row = "<div class='checkbox'>";
                                row += "<label>";
                                row += "<input type='checkbox' name='subjects' value='";
                                row += data[i].id;
                                row += "'>";
                                row += data[i].name + " (Grade " + data[i].grade + ")";
                                row += "</label>";
                                row += "</div>";
                                subjects.innerHTML += row;
                            }
                        });
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
                                <form name="myform" method="post" action="#" onsubmit="return validateForm();">
                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Name <span style="color:#cc0000;"><b> *</b></span></label>
                                        <div class="col-xs-10">

                                            <input class="form-control" type="text" placeholder="Artisanal kale" name="nm" id="nm">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-2"><b>Gender </b><span style="color:#cc0000;"><b> *</b></span></div>
                                        <div class="col-lg-4">
                                            <select name="gender" class="form-control">
                                                <option value="1">Male</option>
                                                <option value="2">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <br>

                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">NIC <span style="color:#cc0000;"><b> *</b></span></label>
                                        <div class="col-xs-10">

                                            <input class="form-control" type="text" placeholder="XXXXXXXXXV" name="nic" id="nic">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-2 col-form-label">Address <span style="color:#cc0000;"> *</span></label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="text" placeholder="Peterson Lane, Col 05" name="add" id="add">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-tel-input" class="col-xs-2 col-form-label">Telephone<span style="color:#cc0000;"><b>*</b></span></label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="tel" placeholder="0XX-XXXXXXX" name="tp" id="tp">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="example-email-input" class="col-xs-2 col-form-label">Email</label>
                                        <div class="col-xs-10">
                                            <input class="form-control" type="email" placeholder="artisanal@example.com" id="example-email-input">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="qualifications" class="col-xs-2 col-form-label">Qualifications </label>
                                        <div class="col-xs-10">
                                            <input type="Description" class="form-control" id="qualifications">
                                        </div>
                                    </div>
                                    
                                    <!--Show all subjects-->
                                    <h4>Teaching subjects</h4>
                                    <div id="subjects" class="form-group row">
                                        
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary" style="float:right;"><h4> Register</h4> </button>
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
                                    var tp = document.myform.tp.value;
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
                                    var gender = document.myform.gender.value;
                                    var nic = document.myform.nic.value;
                                    var add = document.myform.add.value;
                                    var tp = document.myform.tp.value;
                                    console.log("DEBUG vname ->");
                                    if (nm === "" || gender === "" || nic === "" || add === "" || tp === "") {
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
