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


        <script>

            function sendPacket() {
                var packet = {};
                packet['meta'] = {};
                packet['meta']['cat_name'] = $('#cat_name').val();
                packet['meta']['cat_description'] = $('#cat_description').val();


                $.ajax({
                    type: "POST",
                    async: true,
                    url: "Categories",
                    data: JSON.stringify(packet),
                    contentType: "text/plain"
                })
                        .done(function (data) {
                            alert("successfully updated");
                        });

                return false;


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

                                    <!--editing starts here-->
                                    <h3><b><i><u> Create New Category </u></i></b></h3>
                                    <br>
                                    <form class="form-inline" onsubmit="return sendPacket()">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">
                                                <div class="form-group">

                                                    <input type="text" name="cat_name" class="form-control" id="cat_name" placeholder="New Category Name">
                                                </div>
                                            </div>
                                            <div class="panel-body">

                                                <div class="form-group">

                                                    <textarea type="Description" rows="5" cols="80" name="cat_description" class="form-control" id="cat_description" placeholder="New Category Description"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary" style="float:right;"><h4> Submit</h4> </button>
                                    </form>

                                    <!--ends here-->
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

    </body>
</html>
