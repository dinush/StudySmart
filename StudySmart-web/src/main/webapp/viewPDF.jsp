<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="lk.studysmart.apps.DBConn"%>
<%@page import="lk.studysmart.apps.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View File</title>
    </head>
    <body>
        
        <%  
            String id=(request.getParameter("id"));
            String action=(request.getParameter("action"));
            if(action =="delete"){
                    if(action =="delete"){
                    String value = request.getParameter("id");
                    int v =Integer.parseInt(value);

                
                    DBConn dbconn = new DBConn();
                    Connection conn = dbconn.Connection();
                    Statement myStatement = conn.createStatement();
                    String sqlString = "Delete file FROM file_Upload WHERE id = '"+v+"'";
                    
                    myStatement.executeUpdate(sqlString);
                
            }

            }else{
                Blob file = null;
                byte[ ] fileData = null ;

                try
                {    
                    DBConn dbconn=new DBConn();
                    Connection conn = dbconn.Connection();

                    String sqlString = "SELECT file FROM file_upload WHERE id = '"+id+"'";
                    Statement myStatement = conn.createStatement();

                    ResultSet rs=myStatement.executeQuery(sqlString);

                    if (rs.next()) 
                    {
                        file = rs.getBlob("file");
                        fileData = file.getBytes(1,(int)file.length());
                    } else 
                    {
                        out.println("file not found!");
                        return;
                    }

                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "inline");
                    response.setContentLength(fileData.length);

                    OutputStream output = response.getOutputStream();
                    output.write(fileData);

                    output.flush();

                } catch (SQLException ex) {Logger.getLogger(Logger.class.getName()).log(Level.SEVERE, null, ex);}
                
            } 
            %>
        
        <br><br>
        <a href="main_page.jsp">Go to Main Page...</a>     
    </body>
</html>