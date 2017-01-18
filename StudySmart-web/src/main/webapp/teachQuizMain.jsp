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
        <script src="js/sweetalert.min.js"></script>
        <link rel="stylesheet" href="css/sweetalert.css" />

        <script>
            function getSubjects() {

                $.ajax({
                    url: "ws/rest/teacher/<% out.print(user.getUsername());%>/subjects",
                    async: true
                })
                //Get teacher enrolled subjects 
                        .done(function (data) {
                            var select_subject = document.getElementById("subject");
                            var subjects_html = "";
                            for (var i = 0; i < data.length; i++) {
                                var subject_html = "<option value='"
                                        + data[i].id + "'>Grade "
                                        + data[i].grade + " "
                                        + data[i].name + "</option>";
                                subjects_html += subject_html;
                            }

                            select_subject.innerHTML = subjects_html;
                            
                        });
            }
            //System automaticlly display teacher enrolled subjects
            $(function () {
                getSubjects();
            });
        </script>
        
        <% if( request.getParameter("status") != null && request.getParameter("status").equalsIgnoreCase("success")){%>
        <script type="text/javascript"> 
            alert("Quiz Successfully added");
            swal({
                  title: "",
                  text: "Succesfully Posted !",
                  type: "success"
            });
        </script>
        <% } %>
        <% if (request.getParameter("") != null) { %>
        <script>
            $(function() {
                swal({
                        title: "<% out.print(request.getParameter("ststus")); %>",
                        type: "success"
                      });
             });
        </script>
        <% } %>
        

        <title>StudySmart</title>
    </head>
    <body>
        <div class="container">
            <%@include file="WEB-INF/jspf/PageHeader.jspf" %>
            <!-- Path -->
            <ol class="breadcrumb">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="teachVLEMUI.jsp">VLE</a></li>
                <li>Create quiz</li>
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
                                    <div class="flat-panel">
                                        <div class="flat-panel-head">
                                            Creating a new quiz
                                        </div>
                                        <div class="flat-panel-body">
                                            <!--Send information to the QuizInsertion servet in apps -->
                                            <form method="post" action="QuizInsertion" class="form-horizontal">
                                                <div class="form-group">
                                                    <label for="subject" class="col-sm-3 control-label">Select Subject</label>     
                                                    <div class="col-sm-9">
                                                        <select class="form-control" id="subject" name="subject" >
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="question" class="col-sm-3 control-label">Question</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" id="question" name="question" placeholder="Question">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="opt1" class="col-sm-3 control-label">Option 1</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" id="opt1" name="opt1" placeholder="Option 1">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="opt2" class="col-sm-3 control-label">Option 2</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" id="opt2" name="opt2" placeholder="Option 2">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="opt3" class="col-sm-3 control-label">Option 3</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" id="opt3" name="opt3" placeholder="Option 3">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="opt4" class="col-sm-3 control-label">Option 4</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" id="opt4" name="opt4" placeholder="Option 4">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ans" class="col-sm-3 control-label">Correct Answer #</label>
                                                    <div class="col-sm-9">
                                                        <input type="number" class="form-control" id="ans" name="ans" placeholder="Correct answer number" max="4" min="1">
                                                    </div>
                                                </div>

                                                <br>

                                                <button type="submit" class="btn btn-primary col-sm-offset-10" style="width: 100px;">Submit</button>
                                            </form>
                                        </div>
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
