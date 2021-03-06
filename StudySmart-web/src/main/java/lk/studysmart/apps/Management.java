/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
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
import org.json.JSONArray;
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
                addClassMsg(request);
            }
            break;
            case "seen": {
                // mark message as seen
                // example input data, [{id:4},...]
                markMsgAsSeen(request);
            }
            break;
            case "profile": {
                // Send user data to the view
                getUserProfile(request);
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
            }
            break;
            case "changeProfile": {
                // Change user details to provided values in the request
                try {
                    changeUserProfile(request);
                } catch (ParseException ex) {
                    Logger.getLogger(Management.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
            break;
            case "sendpersonalmsg": {
                sendPersonalMsg(request);
                response.sendRedirect("index.jsp?msg=Message sent");
            }
            break;
            case "changePassword": {
                changePassword(request, response);
                /** Redirect is handled in the method called */
            }
        }
    }

    /**
     * Marks a msg as seen
     *
     * @param request
     * @throws IOException
     */
    private void markMsgAsSeen(HttpServletRequest request) throws IOException {
        String data = Utils.bufferedToString(request.getReader());
        if (data == null) // Exception in reading function
        {
            return;
        }

        JSONArray jarr = new JSONArray(data);
        for (int i = 0; i < jarr.length(); i++) {  // Process seens
            JSONObject jobj = jarr.getJSONObject(i);
            int id = jobj.getInt("id");

            Message msg = em.find(Message.class, id);
            msg.setSeen(true);

            try {
                utx.begin();
                em.merge(msg);
                utx.commit();
            } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                Logger.getLogger(Management.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void addClassMsg(HttpServletRequest request) throws IOException {
        // Read data from the POST
        String data = Utils.bufferedToString(request.getReader());
        if (data == null) {
            return;
        }

        // Get required attributes
        JSONObject jobj = new JSONObject(data);
        String title = jobj.getString("title");
        String content = jobj.getString("content");
        String date = jobj.getString("date");
        String urls = jobj.getString("urls");
        Class2 class2 = em.find(Class2.class, Integer.parseInt(jobj.getString("classid")));

        Message message = new Message();
        message.setType(4); // Class level msg
        message.setTitle(title);
        message.setContent(content);
        message.setUrl(urls);
        try {   // Get current time.
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

    private void getUserProfile(HttpServletRequest request) throws ServletException, IOException {
        String username = request.getParameter("username");
        if (username == null) {
            return;
        }

        User user2 = em.find(User.class, username);

        request.setAttribute("username", user2.getUsername());
        request.setAttribute("name", user2.getName());
        request.setAttribute("email", user2.getEmail());
        request.setAttribute("gender", user2.getGender());
        // Optional values and user level specifics
        if (user2.getClass1() != null) {
            request.setAttribute("class", "Grade " + user2.getClass1().getGrade() + " " + user2.getClass1().getSubclass());
        }
        if (user2.getBirthdate() != null) {
            request.setAttribute("birthdate", Utils.getFormattedDateString(user2.getBirthdate()));
        }
        if (user2.getAddress() != null) {
            request.setAttribute("address", user2.getAddress());
        }
        if (user2.getNic() != null) {
            request.setAttribute("nic", user2.getNic());
        }
        if (user2.getOccupation() != null) {
            request.setAttribute("occupation", user2.getOccupation());
        }
        if (user2.getPhone() != null) {
            request.setAttribute("tp", user2.getPhone());
        }
        if (user2.getQualifications() != null) {
            request.setAttribute("qualifications", user2.getQualifications());
        }

    }

    private void changeUserProfile(HttpServletRequest request) throws ParseException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String birthdate = request.getParameter("birthdate");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");
        String occupation = request.getParameter("occupation");
        String tp = request.getParameter("tp");
        String qualifications = request.getParameter("qualifications");

        User user2 = em.find(User.class, username);
        user2.setEmail(email);
        user2.setName(name);
        user2.setGender(gender);
        user2.setBirthdate(Utils.getFormattedDate(birthdate));
        user2.setNic(nic);
        user2.setAddress(address);
        user2.setOccupation(occupation);
        user2.setPhone(tp);
        user2.setQualifications(qualifications);

        try {
            utx.begin();
            em.merge(user2);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(Management.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String current_pw = request.getParameter("current_password");
        String new_pw = request.getParameter("new_password");
        /* Repeat password is checked in the frontend */
        
        if (!user.getPassword().equals(current_pw)) {
            response.sendRedirect("changePassword.jsp?msg=Current password is wrong");
            return;
        }
        
        user.setPassword(new_pw);
        
        try {
            utx.begin();
            em.merge(user);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
            Logger.getLogger(Management.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        response.sendRedirect("index.jsp?msg=Password changed");
    }
    
    protected void sendPersonalMsg(HttpServletRequest request) throws IOException {
        User from = user;
        String[] receivers = request.getParameterValues("receivers");
        for (String receiver : receivers) {
            User to = em.find(User.class, receiver);
            Message msg = new Message();
            msg.setAddeddate(Utils.getFormattedDate());
            msg.setAddedtime(Utils.getFormattedTime());
            msg.setAddeduser(from);
            msg.setContent(request.getParameter("msg"));
            msg.setTargetuser(to);
            msg.setType(1);
            try {
                utx.begin();
                em.persist(msg);
                utx.commit();
            } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
            }
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
