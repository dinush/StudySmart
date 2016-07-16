<%-- 
    Document   : logincheck
    Created on : Jul 4, 2016, 10:57:56 PM
    Author     : dinush
--%>

<%
    Object user = session.getAttribute("username");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) user;
    int grade = (Integer) session.getAttribute("grade");
    int accesslevel = (Integer) session.getAttribute("accesslevel");
%>