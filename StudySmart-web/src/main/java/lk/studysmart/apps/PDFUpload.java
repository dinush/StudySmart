/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import lk.studysmart.apps.models.User;

@WebServlet(name = "PDFUpload", urlPatterns = {"/PDFUpload"})
@MultipartConfig(maxFileSize = 16177215)
public class PDFUpload extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("PDF_Upload.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        InputStream inputStream = null;
        HttpSession session = null;

        User user = (User) request.getSession().getAttribute("user");
        String username = user.getUsername();
        System.out.println(username);
        String fileName = (request.getParameter("file_name"));
        Part filePart = request.getPart("upload_file");
        System.out.println("Uploaded successfully");

        if (filePart != null) {
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            inputStream = filePart.getInputStream();
        }

        try {
            DBConn dbconn = new DBConn();
            Connection conn = dbconn.Connection();

            String sql = "INSERT INTO file_upload (uid, file_name, file) values (?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, fileName);

            if (inputStream != null) {
                statement.setBinaryStream(3, inputStream, (int) filePart.getSize());
            }

            int row = statement.executeUpdate();

            response.setContentType("text/html;charset=UTF-8");
            List<String[]> ls = new ArrayList<>();
            request.setAttribute("user", username);
//            PrintWriter out = response.getWriter();

            if (row > 0) {
//                String sqlString = "SELECT * FROM files";
//                Statement myStatement = conn.createStatement();
//                ResultSet rs = myStatement.executeQuery(sqlString);
//                String [] data = null;
//                while(rs.next()){
//                    data[0] = rs.getString("uid");
//                    data[1] = rs.getString("file_name");
//                    
//                    ls.add(data);
//                }
//                                
//                
//                conn.close();
//                request.setAttribute("files", ls);
                conn.close();
                request.getSession().setAttribute("err", "File uploaded succssfully!");
                RequestDispatcher rs = request.getRequestDispatcher("PDF_Upload.jsp");
                rs.include(request, response);
            } else {

                conn.close();
                request.getSession().setAttribute("err", "Could not upload your file!");
                RequestDispatcher rs = request.getRequestDispatcher("PDF_Upload.jsp");
                rs.include(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
