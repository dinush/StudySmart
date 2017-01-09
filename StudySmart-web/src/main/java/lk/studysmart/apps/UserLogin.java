/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lk.studysmart.apps.models.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author dinush
 */
@WebServlet(name = "UserLogin", urlPatterns = {"/userlogin"})
public class UserLogin extends HttpServlet {
    
    public static final String HASHED_PASSWORD_PREFIX = "bcrypt:";
    
    @PersistenceUnit(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU");

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            EntityManager em = emf.createEntityManager();
            List resultList = em.createNamedQuery("User.findByUsername")
                    .setParameter("username", request.getParameter("username"))
                    .getResultList();
            
            if (resultList.isEmpty()) {
                response.sendRedirect("login.jsp?msg=Wrong Username");
                return;
            }
            
            User user = (User) resultList.get(0);
            
            String password = user.getPassword();
            boolean validPassword = false;
            
            if (password.startsWith(HASHED_PASSWORD_PREFIX)) {
                validPassword = BCrypt.checkpw(request.getParameter("password"), password);
            } else {
                validPassword = password.equals(request.getParameter("password"));
            }
            
            if (!validPassword) {
                response.sendRedirect("login.jsp?msg=Wrong Password");
                return;
            } 
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("entitymanager", em);
            response.sendRedirect("index.jsp");
                
                       
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
