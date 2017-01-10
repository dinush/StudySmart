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
        <script src="js/jqwidgets/globalization/globalize.js"></script>
<!--        Sweet alert 2-->
        <script src="js/sweetalert.min.js"></script>
        
        <link rel="stylesheet" href="css/sweetalert.css" />

        <script type="text/javascript" src="js/rs_embhl.js"></script>
        
        <script type="text/javascript">
            
           


            function sendPacket() {
                var packet = {};
                packet['meta'] = {};
                packet['meta']['mypost'] = $('#mypost').val();
            <% String myclass = request.getParameter("class"); %>;
            <% String mysub = request.getParameter("subject"); %>;

                packet['meta']['mylesson'] = '<% out.print(request.getParameter("lesson")); %>';
                packet['meta']['myclass'] = '<% out.print(request.getParameter("class")); %>';
                packet['meta']['mysubject'] = '<% out.print(request.getParameter("subject")); %>';
                packet['meta']['myid'] = '<% out.print(request.getParameter("catid")); %>';

                $.ajax({
                    async: true,
                    type: "POST",
                    url: "ForumPosts",
                    data: JSON.stringify(packet),
                    contentType: "text/plain"

                })
                        .done(function (data) {
                            swal({
                                title: "Success",   
                                text: "Succesfully Posted !",   
                                type: "success" 
                          });
                            getDiscussion();

                        });

                return false;


            }
            
            function deletePost(postid){
                
                $.ajax({
                    url: "ws/rest/forumdeletepost/" + postid,
                    async: true,
                    type: 'DELETE',
                    success: function(res) {
                        swal({
                            title: "",   
                            text: "Succesfully Deleted !",   
                            type: "error" 
                      });
                        getDiscussion();
                        
                    }
                });
                
                return false;
                
            }

            function getDiscussion() {
                var lessonid = '<% out.print(request.getParameter("lesson")); %>';
                var classid = '<% out.print(request.getParameter("class")); %>';
                var subjectid = '<% out.print(request.getParameter("subject"));%>';

                console.log(classid);
                $.ajax({
                    url: "ws/rest/forum/" + lessonid + "/" + classid + "/" + subjectid,
                    async: true
                })
                        .done(function (data) {
                            var discussion = document.getElementById("discussion");
                            discussion.innerHTML = '';

                            for (var i = 0; i < data.length; i++) {
                                var html = "<div class='panel  panel-info'>";
                                html += "<div class='panel-heading'>";
                                html += data[i].postaddedby + " on ";
                                html += data[i].postdate + " @ " + data[i].posttime;
                                html += "<span class='glyphicon glyphicon-remove-circle pull-right' aria-hidden='true' onclick='deletePost(" + data[i].postid + ")' style='cursor:pointer'></span>";
                                html += "</div>";
                                html += "<div class='panel-body'>";
                                html += data[i].post;
                                html += "</div>"; 
                                html += "</div>";
                                discussion.innerHTML += html;
                            }
                        });
            }

            $(function () {
                getDiscussion();
            });

        </script>
        <title>StudySmart</title>
    </head>
    <div id="speak" style="position:fixed; left:37%; top:57px; z-index:1000000"></div>
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

                                    <!-- my editting-->
                                    <div class="panel" style="background-color:#336699" >
                                        <div class="panel-heading">
                                            <h1 class="panel-title"><i><b><font color="white">Discussion Forum</font></b></i></h1>
                                        </div>
                                    </div>

                                    <a href="http://app.readspeaker.com/cgi-bin/rsent?customerid=5204&amp;lang=en_us&amp;speed=140&amp;readid=speak&amp;url=http://localhost:8080/StudySmart-web/forumposts.jsp" 
                                        onclick="readpage(this.href, 'speak'); return false;"
                                        target="_blank"></a>
                                    
                                    <div id="discussion">

                                    </div>

                                    <button type="button" class="btn btn-primary btn-md" data-toggle="modal" style="align:right" data-target="#myModal">
                                        Add Your Post
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" >Add your post</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <textarea class="form-control" id="mypost" placeholder="Try to input multiple lines here..."></textarea>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary" onclick="return sendPacket()">Submit</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--                                my editting ends here-->

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
