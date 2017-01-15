<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="lk.studysmart.apps.DBConn"%>
<%@page import="lk.studysmart.apps.models.User"%>

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
        <script>
            function deleteFile(id) {
                var ret = confirm("Are you sure to delete this file?");
                if (!ret)
                    return;
                $.ajax({ 
                    url: "ws/resources/internal/delete/" + id,
                    async: true,
                    type: "DELETE"
                }) .done(function(data) {
                    location.reload();
                });
            }
        </script>
    <title>Upload Files</title>
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

                            <div class="col-md-8">

                                <table class='table'>
                                    <thead> 
                                    <th colspan="3">Uploaded Files</th>        
                                    </thead>
                                    <tbody>
                                        <tr>
<<<<<<< HEAD
                                                <td><center><b>Id</b></center><td><center><b>Title</b></center></td><td><center><b>File</b></center></td>
                                        </tr>
                                        <%
                                        try
                                        {

                                                User user1 = (User) request.getSession().getAttribute("user");
                                                String username = user1.getUsername();
                                                DBConn dbconn=new DBConn();
                                                Connection myconnection= dbconn.Connection();

                                                String sqlString = "SELECT * FROM file_upload where uid = '"+username+"'";
                                                Statement myStatement = myconnection.createStatement();
                                                ResultSet rs=myStatement.executeQuery(sqlString);

                                                if(!rs.isBeforeFirst())
                                                {
                                                        %>
                                                                <tr>
                                                                <td colspan="3"><center><%out.print("No Files!"); %></center></td>
                                                                </tr>
                                                        <%
                                                }    

                                                while(rs.next())
                                                {   
                                            %>
                                                <tr>
                                                        <td><center><%out.print(rs.getString("id")); %></center></td>
                                                        <td><center><%out.print(rs.getString("file_name")); %></center></td>
                                                        <td><center><a target="blank" href='viewPDF.jsp?id=<%out.print(rs.getString("id"));%>'>View</a></center></td>
                                                        <td><center><a target="blank" href='viewPDF.jsp?action=delete&id=<%out.print(rs.getString("id"));%>'>Delete</a></center></td>
                                                
                                                </tr>
                                            <%
                                                    }
                                            %>
=======
                                            <td><center><b>Id</b></center><td><center><b>Title</b></center></td><td><center><b>File</b></center></td>
                                    </tr>
                                    <%
                                        try {

                                            User user1 = (User) request.getSession().getAttribute("user");
                                            String username = user1.getUsername();
                                            DBConn dbconn = new DBConn();
                                            Connection myconnection = dbconn.Connection();

                                            String sqlString = "SELECT * FROM file_upload where uid = '" + username + "'";
                                            Statement myStatement = myconnection.createStatement();
                                            ResultSet rs = myStatement.executeQuery(sqlString);

                                            if (!rs.isBeforeFirst()) {
                                    %>
                                    <tr>
                                        <td colspan="3"><center><%out.print("No Files!"); %></center></td>
                                    </tr>
                                    <%
                                        }

                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><center><%out.print(rs.getString("id")); %></center></td>
                                    <td><center><%out.print(rs.getString("file_name")); %></center></td>
                                    <td><center><a target="blank" href='viewPDF.jsp?id=<%out.print(rs.getString("id"));%>'>View</a></center></td>
                                    <td><center><a target="blank" onclick="deleteFile('<%out.print(rs.getString("id"));%>')">Delete</a></center></td>

                                    </tr>
                                    <%
                                        }
                                    %>
>>>>>>> c4bd76e8667f5bce0140897072b7183747a92549

                                    </tbody> 
                                </table>

                                <%
                                        rs.close();
                                        myStatement.close();
                                        myconnection.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                %>

                            </div>

                            <div id="main-content"  >
                                <form method="post" action="PDFUpload" enctype="multipart/form-data">
                                    <div style="margin-left:10px;">
                                        <h1><span class="glyphicon glyphicon-file" style="color:#336699;"></span>Upload your documents</h1>
                                        <br>
                                    
                                    <div class="form-group">
                                        <label for="file_name">File Name</label>
                                        <input type="text" class="form-control" id="file_name" placeholder="i.e My File" name="file_name">
                                    </div>                                  
                                    <div class="form-group">
                                        <label for="exampleInputFile">Select File</label>
                                        <input class="btn btn-default" type="file" id="upload_file" name="upload_file">
                                        <p class="help-block">Select only PDF files.</p>
                                    </div>

                                    <button type="submit" class="btn btn-default" >Upload</button>
                                    </div>
                                    <br>
                                    
                                </form>

                            </div>
                        </div>

                    </div>

                </td>
            </tr>
        </table>
    </div>
    <div class="col-md-4">
        <%@ include file="WEB-INF/jspf/Infopanel.jspf" %>
    </div>

</body>
</html>
