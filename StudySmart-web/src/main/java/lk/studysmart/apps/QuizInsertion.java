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
        String sGrade = request.getParameter("grade");
        int grade = Integer.valueOf(sGrade);
        
        // get Q1 details
        String q1 = request.getParameter("q1");
        String q11Option = request.getParameter("a11");
        String q12Option = request.getParameter("a12");
        String q13Option = request.getParameter("a13");
        String q14Option = request.getParameter("a14");
        String q1Answer = request.getParameter("a1");
        
        // get Q2 details
        String q2 = request.getParameter("q2");
        String q21Option = request.getParameter("a21");
        String q22Option = request.getParameter("a22");
        String q23Option = request.getParameter("a23");
        String q24Option = request.getParameter("a24");
        String q2Answer = request.getParameter("a2");
        
        // get Q3 details
        String q3 = request.getParameter("q3");
        String q31Option = request.getParameter("a31");
        String q32Option = request.getParameter("a32");
        String q33Option = request.getParameter("a33");
        String q34Option = request.getParameter("a34");
        String q3Answer = request.getParameter("a3");
        
        // get Q4 details
        String q4 = request.getParameter("q4");
        String q41Option = request.getParameter("a41");
        String q42Option = request.getParameter("a42");
        String q43Option = request.getParameter("a43");
        String q44Option = request.getParameter("a44");
        String q4Answer = request.getParameter("a4");
        
        // get Q5 details
        String q5 = request.getParameter("q5");
        String q51Option = request.getParameter("a51");
        String q52Option = request.getParameter("a52");
        String q53Option = request.getParameter("a53");
        String q54Option = request.getParameter("a54");
        String q5Answer = request.getParameter("a5");
        
        
        //set attributes' values to objects
        Quiz quiz1 = new Quiz();
        quiz1.setSubject(subjectid);
        quiz1.setOption1(q11Option);
        quiz1.setOption2(q12Option);
        quiz1.setOption3(q13Option);
        quiz1.setOption4(q14Option);
        quiz1.setAnswers(q1Answer);
        quiz1.setUsername(user);
        quiz1.setQuestion(q1);
        quiz1.setGrade(grade);
        
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
        
        Quiz quiz2 = new Quiz();
        quiz2.setSubject(subjectid);
        quiz2.setOption1(q21Option);
        quiz2.setOption2(q22Option);
        quiz2.setOption3(q23Option);
        quiz2.setOption4(q24Option);
        quiz2.setAnswers(q2Answer);
        quiz2.setUsername(user);
        quiz2.setQuestion(q2);
        quiz2.setGrade(grade);
        
        try {
            utils.Utils.entityValidator(quiz2);
            utx.begin();
            em.persist(quiz2);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
             Logger.getLogger(QuizInsertion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Quiz quiz3 = new Quiz();
        quiz3.setSubject(subjectid);
        quiz3.setOption1(q31Option);
        quiz3.setOption2(q32Option);
        quiz3.setOption3(q33Option);
        quiz3.setOption4(q34Option);
        quiz3.setAnswers(q3Answer);
        quiz3.setUsername(user);
        quiz3.setQuestion(q3);
        quiz3.setGrade(grade);
        
        try {
            utils.Utils.entityValidator(quiz3);
            utx.begin();
            em.persist(quiz3);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
             Logger.getLogger(QuizInsertion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Quiz quiz4 = new Quiz();
        quiz4.setSubject(subjectid);
        quiz4.setOption1(q41Option);
        quiz4.setOption2(q42Option);
        quiz4.setOption3(q43Option);
        quiz4.setOption4(q44Option);
        quiz4.setAnswers(q4Answer);
        quiz4.setUsername(user);
        quiz4.setQuestion(q4);
        quiz4.setGrade(grade);
        
        try {
            utils.Utils.entityValidator(quiz4);
            utx.begin();
            em.persist(quiz4);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
             Logger.getLogger(QuizInsertion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        Quiz quiz5 = new Quiz();
        quiz5.setSubject(subjectid);
        quiz5.setOption1(q51Option);
        quiz5.setOption2(q52Option);
        quiz5.setOption3(q53Option);
        quiz5.setOption4(q54Option);
        quiz5.setAnswers(q5Answer);
        quiz5.setUsername(user);
        quiz5.setQuestion(q5);
        quiz5.setGrade(grade);
        
        try {
            utils.Utils.entityValidator(quiz5);
            utx.begin();
            em.persist(quiz5);
            utx.commit();
        } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
             Logger.getLogger(QuizInsertion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        response.sendRedirect("teachVLEMUI.jsp");
        
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
