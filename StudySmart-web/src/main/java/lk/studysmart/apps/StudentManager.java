/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.naming.InitialContext;
import javax.naming.NamingException;
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
import lk.studysmart.apps.models.Attendance;
import lk.studysmart.apps.models.AttendancePK;
import lk.studysmart.apps.models.User;

/**
 *
 * @author dinush
 */
@WebServlet(name = "StudentManager", urlPatterns = {"/StudentManager"})
public class StudentManager extends HttpServlet {
    
    @PersistenceUnit(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU");
    
    @Resource
    UserTransaction utx;
    
    @PersistenceContext
    EntityManager em;

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
        
        User user = (User) request.getSession().getAttribute("user");
        
        List resultList = em.createNamedQuery("User.findByGradeAndLevel")
                .setParameter("grade", user.getGrade())
                .setParameter("level", 3)
                .getResultList();
                
        // Show input attendance form
        if(request.getParameter("action").equals("attendance")) {   // Send attendance input page
            request.setAttribute("students", resultList);
            request.getRequestDispatcher("/attendance.jsp").forward(request, response);
            
        // Input attendance details to database
        } else if(request.getParameter("action").equals("attendancemarked")) {  
            try {                
                // Insert attendance details to db
                String[] attendees = request.getParameterValues("attendance");
                attendanceDetailsToDB(attendees);
                response.sendRedirect("index.jsp");
            } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        // View students belongs to parent
        } else if(request.getParameter("action").equals("checkattendance")) {
            if(user.getLevel() == 4) {    //Parent
                List studentList = em.createNamedQuery("StudentParent.findByParentId")
                        .setParameter("parentid", user.getUsername())
                        .getResultList();
                // if only one student belongs to this parent, show his attendance.
                if(studentList.size() == 1) {
                    User student = (User) studentList.get(0);
                    response.sendRedirect("StudentManager?action=checkattendancefor&id=" + student.getUsername());
                }
            }
            
        // View attendance for specific student
        } else if (request.getParameter("action").equals("checkattendancefor")){
            
        }
    }
    
    private void attendanceDetailsToDB(String[] attendees) throws NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException{
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                Date date = new Date();
                
//                UserTransaction transaction = (UserTransaction) new InitialContext().lookup("java:comp/UserTransaction");
                
                for(String attendee : attendees) {
                    AttendancePK attendancePK = new AttendancePK(attendee, date);
                    Attendance attendance = new Attendance(attendancePK);
                    attendance.setAttended(Boolean.TRUE);
                    
                    utx.begin();
                    em.persist(attendance);
                    utx.commit();
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