/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URLDecoder;
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
import javax.servlet.ServletInputStream;
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
import lk.studysmart.apps.models.User;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author dinush
 */
@WebServlet(name = "ChangeUser", urlPatterns = {"/ChangeUser"})
public class ChangeUser extends HttpServlet {

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
        
        // Find the user first
        String stringParams = convertStreamToString(request.getInputStream());
        JSONObject jsonParams = new JSONObject(stringParams);
        User cUser = em.find(User.class, jsonParams.getString("username"));
        
        // Change the details
        cUser.setName(jsonParams.getString("name"));
        try {
            String password = jsonParams.getString("password");
            cUser.setPassword(password);
        } catch (JSONException ex1) {/* Password is null. (Don't change)*/ }
        try {
            cUser.setEmail(jsonParams.getString("email"));
        } catch (JSONException ex) {
            cUser.setEmail(null);
        }
        try {
            cUser.setGender(jsonParams.getString("gender"));
        } catch (JSONException ex) {
            cUser.setGender(null);
        }
        
        try {
            cUser.setBirthdate(utils.Utils.stringToDate(jsonParams.getString("birthday")));
        } catch (ParseException ex) {
            Logger.getLogger(ChangeUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            cUser.setBirthdate(null);
        }
        
        try {
            cUser.setAddress(jsonParams.getString("address"));
        } catch (JSONException ex) {
            cUser.setAddress(null);
        }
        try {
            cUser.setNic(jsonParams.getString("nic"));
        } catch (JSONException ex) {
            cUser.setNic(null);
        }
        try {
            cUser.setPhone(jsonParams.getString("phone"));
        } catch (JSONException ex) {
            cUser.setPhone(null);
        }

        try {
            utx.begin();
            em.merge(cUser);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
            Logger.getLogger(ChangeUser.class.getName()).log(Level.SEVERE, null, ex);
        } 
        
        response.getWriter().write("Successfully updated");
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

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
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

    private String convertStreamToString(ServletInputStream inputStream) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
        
        String params = bufferedReader.readLine();
        params = URLDecoder.decode(params, "UTF-8");
        
        return params;
    }
}
