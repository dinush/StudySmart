/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.io.PrintWriter;
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
import lk.studysmart.apps.models.Quiz;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.User;

/**
 *
 * @author Kaveesh
 */
@WebServlet(name = "QuizInsertion", urlPatterns = {"/QuizInsertion"})
public class QuizInsertion extends HttpServlet {
    
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
        
        //Get userID 
        user = (User) request.getSession().getAttribute("user");
        
        //Getting data from frontend to Servlet
        String subjectid = request.getParameter("subject");
        Subject subject = em.find(Subject.class, subjectid);
        
        // get Q1 details
        String q1 = request.getParameter("question");
        String q11Option = request.getParameter("opt1");
        String q12Option = request.getParameter("opt2");
        String q13Option = request.getParameter("opt3");
        String q14Option = request.getParameter("opt4");
        String q1Answer = request.getParameter("ans");
        
        
        //set attributes' values to objects
        Quiz quiz1 = new Quiz();
        quiz1.setSubject(subject);
        quiz1.setOption1(q11Option);
        quiz1.setOption2(q12Option);
        quiz1.setOption3(q13Option);
        quiz1.setOption4(q14Option);
        quiz1.setAnswers(q1Answer);
        quiz1.setUsername(user);
        quiz1.setQuestion(q1);
        
        //User Transaction
        try {
            //trascation
            utils.Utils.entityValidator(quiz1);
            utx.begin();
            em.persist(quiz1);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
             Logger.getLogger(QuizInsertion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        //Redirest the page after completion of quiz entering
        response.sendRedirect("teachQuizMain.jsp?status=success");
        
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
