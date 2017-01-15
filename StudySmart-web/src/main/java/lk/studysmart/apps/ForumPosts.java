/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
import lk.studysmart.apps.models.Forumposts;
import lk.studysmart.apps.models.User;
import org.json.JSONObject;

/**
 *
 * @author Acer E-15
 */
    @WebServlet(name = "ForumPosts", urlPatterns = {"/ForumPosts"})
public class ForumPosts extends HttpServlet {

    
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
        user = (User) request.getSession().getAttribute("user");
        response.setContentType("text/html;charset=UTF-8");
        StringBuilder builder = new StringBuilder();
        String line = new String();
        
        BufferedReader reader = new BufferedReader(request.getReader());
        
        while ((line = reader.readLine())!= null){
            builder.append(line);
        }
        
        JSONObject jobj = new JSONObject(builder.toString());
        JSONObject meta = jobj.getJSONObject("meta");
        String mypost = meta.getString("mypost");
        String mylesson = meta.getString("mylesson");
        String myclass = meta.getString("myclass");
        Integer myid = meta.getInt("myid");
        String mysubject = meta.getString("mysubject");
        Date mydate = utils.Utils.getFormattedDate();
        String time = utils.Utils.getFormattedTime();
        
        lk.studysmart.apps.models.Categories cat = em.find(lk.studysmart.apps.models.Categories.class, myid);
        
        lk.studysmart.apps.models.Forumposts forum = new Forumposts();
        forum.setAddedBy(user.getUsername());
        forum.setCatName(mylesson);
        forum.setClass1(myclass);
        forum.setDate(mydate);
        forum.setTime(time);
        forum.setSubject(mysubject);
        forum.setPost(mypost);
        forum.setCatid(cat);
        
        lk.studysmart.apps.models.Message msg = new lk.studysmart.apps.models.Message();
        
        boolean seen = false;
        String newstitle = "Discussion";   
        String d = utils.Utils.getFormattedDateString(mydate);

        String content = user.getName() + " posted a reply on the discussion on " + mysubject + " under " + mylesson + " on " + d + "@" + time;
        
        msg.setSeen(seen);
        msg.setTitle("New forum post on " + mysubject);
        msg.setContent(content);
        msg.setAddedtime(time);
        msg.setAddeddate(mydate);
        msg.setTitle(newstitle);
        msg.setAddeduser(user);
        lk.studysmart.apps.models.Class2 cls = em.find(lk.studysmart.apps.models.Class2.class, Integer.parseInt(myclass));
        msg.setClass1(cls);
        msg.setType(4);
        
        try {
            utx.begin();
            em.persist(forum);
            em.persist(msg);
            utx.commit();
        
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(ForumPosts.class.getName()).log(Level.SEVERE, null, ex);
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
