/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.Message;
import lk.studysmart.apps.models.User;
import org.json.JSONObject;
import utils.Utils;

/**
 *
 * @author dinush
 */
@WebServlet(name = "Management", urlPatterns = {"/management"})
public class Management extends HttpServlet {

    @PersistenceUnit(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU");

    @Resource
    UserTransaction utx;

    @PersistenceContext
    EntityManager em;

    protected User user;

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

        user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (request.getParameter("action")) {
            case "class-msg-add": { // Add class level msg
                StringBuilder buf = new StringBuilder();
                String line;
                try {
                    BufferedReader reader = request.getReader();
                    while ((line = reader.readLine()) != null) {
                        buf.append(line);
                    }
                } catch (Exception e) {
                    // error
                    return;
                }

                JSONObject jobj = new JSONObject(buf.toString());
                String title = jobj.getString("title");
                String content = jobj.getString("content");
                String date = jobj.getString("date");
                Class2 class2 = em.find(Class2.class, jobj.getInt("classid"));

                Message message = new Message();
                message.setType(4);
                message.setTitle(title);
                message.setContent(content);
                try {
                    message.setTargetdate(Utils.getFormattedDate(date));
                } catch (ParseException ex) {
                    Logger.getLogger(Management.class.getName()).log(Level.SEVERE, null, ex);
                }
                message.setAddeduser(user);
                message.setAddeddate(Utils.getFormattedDate());
                message.setAddedtime(Utils.getFormattedTime());
                message.setClass1(class2);

                try {
                    utx.begin();
                    em.persist(message);
                    utx.commit();
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(Management.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
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