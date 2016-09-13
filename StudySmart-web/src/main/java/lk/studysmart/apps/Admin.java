/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.text.ParseException;
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
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.StudentSubject;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.User;

/**
 *
 * @author dinush
 */
@WebServlet(name = "Admin", urlPatterns = {"/Admin"})
public class Admin extends HttpServlet {

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
            /**
             * Register a new student.
             */
            case "registerstudent": {
                registerStudent(request, response);
            }
            break;
            case "registerparent": {
                registerParent(request, response);
            }
            break;
            case "register/teacher": {
                registerTeacher(request, response);
            }
            break;
            default: {
                response.sendRedirect("index.jsp");
            }
        }
    }

    private void registerStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Date bdate = null;
        try {
            bdate = utils.Utils.getFormattedDate(request.getParameter("bdate"));
        } catch (ParseException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }

        Class2 class2 = em.find(Class2.class, Integer.parseInt(request.getParameter("class")));

        User student = new User();
        student.setUsername(request.getParameter("username"));
        student.setName(request.getParameter("name"));
        student.setBirthdate(bdate);
        student.setGender(request.getParameter("gender"));
        student.setEmail(request.getParameter("email"));
        student.setClass1(class2);
        student.setPassword("123");
        student.setLevel(3);

        utils.Utils.entityValidator(student);

        try {
            utx.begin();
            em.persist(student);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }

        // Process the subject enrollment. Data is in subjects array in HTTP POST
        String subjectids[] = request.getParameterValues("subjects[]");
        for (String subjectid : subjectids) {
            Subject subject = em.find(Subject.class, subjectid);
            StudentSubject ss = new StudentSubject();
            ss.setUserId(student);
            ss.setSubjectId(subject);
            try {
                utx.begin();
                em.persist(ss);
                utx.commit();
            } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
                return;
            }

        }
        response.sendRedirect("index.jsp");
    }

    private void registerParent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User parent = new User();
        parent.setPassword("123");
        parent.setLevel(4);
        parent.setUsername(request.getParameter("username"));
        parent.setName(request.getParameter("name"));
        parent.setGender(request.getParameter("gender"));
        parent.setNic(request.getParameter("nic"));
        parent.setAddress(request.getParameter("address"));
        parent.setOccupation(request.getParameter("occupation"));
        parent.setPhone(request.getParameter("phone"));
        parent.setEmail(request.getParameter("email"));

        try {
            utx.begin();
            em.persist(parent);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }

        // Mark students belongs to this parent.
        // Data is in students array in HTTP POST.
        String[] studentids = request.getParameterValues("students");
        for (String studentid : studentids) {
            User student = em.find(User.class, studentid);
            StudentParent sp = new StudentParent();
            sp.setParentid(parent);
            sp.setStudentid(student);

            try {
                utx.begin();
                em.persist(sp);
                utx.commit();
            } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
                return;
            }
        }
        response.sendRedirect("index.jsp");
    }

    private void registerTeacher(HttpServletRequest request, HttpServletResponse response) {
    
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
