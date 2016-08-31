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
        <script src="js/jqwidgets/jqxcalendar.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script type = "text/javascript" >
            $(document).ready(function () {
                $("#jqxcalendar").jqxCalendar({width: '100%', height: '250px'});
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
                    <%
                        out.print(user.getName());
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
                                    <li role="presentation" ><a href="registerParent.jsp">Parent</a></li>
                                    <li role="presentation"><a href="registerTeacher.jsp">Teacher</a></li>
                                    <li role="presentation" class="active"><a href="#">Principal</a></li>
                                    <li role="presentation"><a href="registerSystemAdmin.jsp">System Admin</a></li>
                                 </ul> 
                                <br>
                                 <h1><span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="label label-primary">Add New Principal</span></h1>
                                    
                               
                                <br>
                                <!--adding student registration-->
                                
                                <br>
                                <form name="myform" method="post" action="#" onsubmit="return validateForm();">
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">Name:</label>
                                    <div class="col-xs-10">
                                        <span style="color:#cc0000;"><b> *</b></span>
                                      <input class="form-control" type="text" placeholder="Amanda Baddage" name="nm" id="nm">
                                    </div>
                                </div>
                               
                                 <div class="row">
                                    <div class="col-lg-2"><b>Gender: </b></div>
                                    <div class="col-lg-4">
                                        <select name="class" class="form-control">
                                            <option placeholder="1">Male</option>
                                            <option placeholder="2">Female</option>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                
                                 <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">NIC: </label>
                                    <div class="col-xs-10">
                                        <span style="color:#cc0000;"><b> *</b></span>
                                      <input class="form-control" type="text" placeholder="XXXXXXXXXV" name="nic" id="nic">
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-text-input" class="col-xs-2 col-form-label">Address:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="text" placeholder="Artisanal kale" id="example-text-input">
                                    </div>
                                </div>
                               
                                <div class="form-group row">
                                    <label for="example-tel-input" class="col-xs-2 col-form-label">Telephone:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="tel" placeholder="0XX-XXXXXXX" name="tp" id="tp">
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-email-input" class="col-xs-2 col-form-label">Email:</label>
                                    <div class="col-xs-10">
                                      <input class="form-control" type="email" placeholder="artisanal@example.com" id="example-email-input">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">No. of years in this position:</label>
                                    <input type="text" class="form-control"  id="formGroupExampleInput" placeholder="5" style="width:510px; margin-left:108px">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Working in our school since:</label>
                                    <input type="date" class="form-control" id="formGroupExampleInput" placeholder="8/26/2015" style="width:510px; margin-left:108px">
                                </div>
                                
                                <div class="form-group">
                                      <label for="exampleInputPassword1">Qualifications: </label>
                                      <textarea type="Description" class="form-control" id="InputDescription" style="margin-left:107px; width:510px;" placeholder="01. Qualification 1"></textarea>
                                </div>
                               
                                
                               
                                <br>
                                
                                
                                <button type="submit" class="btn btn-primary" style="margin-left:520px;"><h4> Register</h4> </button>
                            <!-- finishing student registration-->
                                </form>
                            </div>
                            
                          <!--validation-->

                            <script>
                                function validateEmail()  
                                {  
                                var x=document.myform.email.value;  
                                var atposition=x.indexOf("@");  
                                var dotposition=x.lastIndexOf(".");  
                                if (x!==""){
                                    if (atposition<1 || dotposition<atposition+2 || dotposition+2>=x.length){  
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
                                    if ((re.test(tp) === false)&& tp!==""){
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

                                function validateForm(){
                             
                                var validation = true;
                                if ((validateName() && validateTP() && validateEmail()) === true){
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
