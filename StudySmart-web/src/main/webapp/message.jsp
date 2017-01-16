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
        <link rel="stylesheet" href="css/selectize.bootstrap2.css" />
        <!--        Sweet alert 2-->
        <script src="js/sweetalert.min.js"></script>
        <link rel="stylesheet" href="css/sweetalert.css" />

        <script src="js/jquery-2.0.0.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jqwidgets/jqxcore.js"></script>
        <script src="js/jqwidgets/jqxdatetimeinput.js"></script>
        <script src="js/jqwidgets/globalization/globalize.js"></script>
        <script src="js/selectize.min.js"></script>

        <script>
            $.ajax({
                <% if (user.getLevel() == 3) { %>
                url: "ws/search/students/all",
                <% } else { %>
                url: "ws/admin/get/user/all",
                <% } %>
                async: true
            })
                    .done(function (data) {
                        var receivers_sel = document.getElementById("receivers");
                        receivers_sel.innerHTML = "<option disabled selected value=''>Select reveicer(s)</option>";
                        for (var i = 0; i < data.length; i++) {
                            var row = "<option name='receivers' value='" + data[i].username + "'>" + data[i].name + " (" + data[i].username + ")</option>";
                            receivers_sel.innerHTML += row;
                        }
                        $('#receivers').selectize({
                            persist: false,
                            maxItems: null
                        });
                    });

            getInbox();

            function getInbox() {
                $.ajax({
                    url: "ws/rest/messages",
                    async: true
                })
                        .done(function (data) {
                            var msgs = document.getElementById("msgs");
                            var gmsgs = document.getElementById("gmsgs");
                            msgs.innerHTML = "";
                            gmsgs.innerHTML = "";
                            for (var i = 0; i < data.length; i++) {
                                var gmsg = "<div class='panel-border-bottom' id='mydiv" + i + "'>";
                                var msg = "<div class='panel-border-bottom' id='mydiv" + i + "'>";
                                if (data[i].type === 4) {

                                    gmsg += "<span class='glyphicon glyphicon-envelope' style='margin-right:5px'></span>";
                                    if ('<% out.print(user.getName());%>' === data[i].added_user_name) {
                                        gmsg += "<span class='glyphicon glyphicon-remove-circle pull-right' aria-hidden='true' onclick='deleteMsg(" + data[i].type + "," + data[i].id + "," + i + ")' style='cursor:pointer'></span>";
                                    }
                                    
                                if (data[i].title !== undefined) {
                                    msg += "<span class='text-info'><font size=4>" + data[i].title + "</font></span>";
                                    gmsg += "<span class='text-info'><font size=4>" + data[i].title + "</font></span>";
                                }
                                gmsg += "<br>";
                                gmsg += data[i].content;
                                gmsg += "<br>";
                                gmsg += "<small>";
                                gmsg += "Sent by " + data[i].added_user_name + " on " + data[i].added_date;
                                gmsg += "</small>";
                                gmsg += "</div>";

                                gmsgs.innerHTML += gmsg;

                                } else {
                                    msg += "<span class='glyphicon glyphicon-envelope' style='margin-right:5px'></span><span class='glyphicon glyphicon-remove-circle pull-right' aria-hidden='true' onclick='deleteMsg(" + data[i].type + "," + data[i].id + "," + i + ")' style='cursor:pointer'></span>";
                                    if (data[i].title !== undefined) {
                                        msg += "<span class='text-info'><font size=4>" + data[i].title + "</font></span>";
                                        gmsg += "<span class='text-info'><font size=4>" + data[i].title + "</font></span>";
                                    }
                                    msg += "<br>";
                                    msg += data[i].content;
                                    msg += "<br>";
                                    msg += "<small>";
                                    msg += "Sent by " + data[i].added_user_name + " on " + data[i].added_date;
                                    msg += "</small>";
                                    msg += "</div>";

                                    msgs.innerHTML += msg;

                                }
                                
                               

                                
                            }
                        });
            }

            function deleteMsg(msgtype, msgid, i) {
                var divid = "divid" + i;
                


                $.ajax({
                    url: "ws/rest/deletemsgs/" + msgid,
                    async: true,
                    type: 'DELETE',
                    success: function (res) {
                        swal({
                            title: "Message",
                            text: "Succesfully Deleted",
                            type: "error"

                        });

                        getInbox();
                    }
                });
                return false;






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
            <li>Message</li>
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
                                <% if (request.getParameter("msg") != null) { %>
                                <script>
                                    alert("<% out.print(request.getParameter("msg"));%>");
                                </script>
                                <% }%>

                                <h4>Write new message <span class="glyphicon glyphicon-chevron-down"></span></h4>
                                <form action="management?action=sendpersonalmsg" method="POST">
                                    Send message to: <br>
                                    <div class="col-xs-12">
                                        <select required name="receivers" id="receivers"></select>
                                    </div>

                                    Message: <br>
                                    <div class="col-xs-12">
                                        <textarea name="msg" id="msg"></textarea>
                                    </div>

                                    <input type="submit" value="Send" />
                                </form>

                                <hr class="col-xs-12">

                                <h4>Personal Message inbox <span class="glyphicon glyphicon-chevron-down"></span></h4>
                                <div id="msgs">

                                </div>
                                <br><br>

                                <!--                                Anupama-->
                                <h4> Group Message inbox <span class="glyphicon glyphicon-chevron-down"></span></h4>
                                <div id="gmsgs">

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
