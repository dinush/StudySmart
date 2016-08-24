<%-- 
    Document   : logincheck
    Created on : Jul 4, 2016, 10:57:56 PM
    Author     : dinush
--%>

<%@page import="lk.studysmart.apps.models.User"%>
<%
    Object u = session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = (User) u;
    
    int acc_level = user.getLevel();
%>