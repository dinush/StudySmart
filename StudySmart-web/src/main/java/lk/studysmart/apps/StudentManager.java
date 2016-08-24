/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.AbstractMap;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
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
import lk.studysmart.apps.models.AssignmentMarks;
import lk.studysmart.apps.models.AssignmentMarksPK;
import lk.studysmart.apps.models.Attendance;
import lk.studysmart.apps.models.AttendancePK;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.Marks;
import lk.studysmart.apps.models.MarksPK;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.TeacherTeaches;
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

        // Show input attendance form
        switch (request.getParameter("action")) {
            case "attendance":
                // Send attendance input page
                if (request.getParameter("grade") != null) {
                    int grade = Integer.valueOf(request.getParameter("grade"));
                    String subclass = request.getParameter("subclass");
                    request.setAttribute("grade", request.getParameter("grade"));
                    request.setAttribute("subclass", subclass);

                    List class2 = em.createNamedQuery("Class.findByGradeAndSubclass")
                            .setParameter("grade", grade)
                            .setParameter("subclass", subclass)
                            .getResultList();

                    List students = em.createNamedQuery("User.findByClass")
                            .setParameter("class2", (Class2) class2.get(0))
                            .getResultList();

                    HashMap<User, Boolean> attendances = new HashMap<User, Boolean>();
                    Date date = getFormattedDate();
                    for (Object student : students) {
                        User s = (User) student;
                        AttendancePK apk = new AttendancePK(s.getUsername(), date);
                        Boolean attended = false;
                        try {
                            Attendance att = (Attendance) em.createNamedQuery("Attendance.findByUserAndDate")
                                    .setParameter("attendancePk", apk)
                                    .getSingleResult();
                            attended = att.getAttended();
                        } catch (NoResultException e) {
                            // do nothing
                        }
                        attendances.put(s, attended);
                    }
                    request.setAttribute("students", attendances);
                }

                request.getRequestDispatcher("/attendance.jsp").forward(request, response);

                // Input attendance details to database
                break;
            case "attendancemarked":
                try {
                    String subclass = request.getParameter("subclass");
                    int grade = Integer.parseInt(request.getParameter("grade"));
                    Class2 class2 = (Class2) em.createNamedQuery("Class.findByGradeAndSubclass")
                            .setParameter("grade", grade)
                            .setParameter("subclass", subclass)
                            .getSingleResult();

                    List students = em.createNamedQuery("User.findByClass")
                            .setParameter("class2", class2)
                            .getResultList();

                    // Insert attendance details to db
                    String[] attendees = request.getParameterValues("attendance");
                    attendanceDetailsToDB(students, attendees);
                    response.sendRedirect("index.jsp");
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | ParseException ex) {
                    Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            // View students belongs to parent
            case "checkattendance": {
                List students = em.createNamedQuery("StudentParent.findByParentId")
                        .setParameter("parentid", user)
                        .getResultList();

                if (students.size() < 1) {
                    // WTF. There is no child registered for this parent.
                    response.sendRedirect("index.jsp");
                }
                // if only one student belongs to this parent, show his attendance.
                if (students.size() == 1) {
                    StudentParent belonging = (StudentParent) students.get(0);
                    response.sendRedirect("StudentManager?action=checkattendancefor&id=" + belonging.getStudentid().getUsername());
                }

                // View attendance for specific student
                break;
            }
            case "checkattendancefor": {
                String studentId = request.getParameter("id");

                User student = (User) em.createNamedQuery("User.findByUsername")
                        .setParameter("username", studentId)
                        .getSingleResult();

                List days = em.createNamedQuery("Attendance.findByUsername")
                        .setParameter("username", studentId)
                        .getResultList();
                request.setAttribute("student", student);
                request.setAttribute("days", days);
                request.getRequestDispatcher("/viewattendance.jsp").forward(request, response);
                break;
            }
            case "termtestmarks": {
                if (user.getLevel() > 2) {  // Students and Parents are not allowed here
                    response.sendRedirect("index.jsp");
                }
                List teachesfor = em.createNamedQuery("TeacherTeaches.findByUser")
                        .setParameter("user", user)
                        .getResultList();
                int len = teachesfor.size();
                request.setAttribute("teachesfor", teachesfor);
                request.getRequestDispatcher("/termTestMark.jsp").forward(request, response);
                
                break;
            }
            case "termtestmarkssave": {
                // Save marks to Database
                /*               if (request.getParameter("term") == null) {
                    response.sendRedirect("index.jsp");
                }
                // Get students in that class
                List<User> students = em.createNamedQuery("User.findByGradeAndLevel")
                        .setParameter("grade", user.getGrade())
                        .setParameter("level", 3)
                        .getResultList();
                for (User student : students) {
                    int mark = Integer.parseInt(request.getParameter(student.getUsername()));
                    MarksPK marksPK = new MarksPK(student.getUsername(), user.getSubject(), Integer.parseInt(request.getParameter("term")));
                    Marks marks = new Marks(marksPK, mark);

                    try {
                        utx.begin();
                        em.persist(marks);
                        utx.commit();
                    } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                        Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                response.sendRedirect("index.jsp");*/
                break;
            }
            case "assignmentmarks": {

                /*               if (user.getLevel() > 2) {  // Students and Parents are not allowed here
                    response.sendRedirect("index.jsp");
                }       // Get students in that class
                List studentList = em.createNamedQuery("User.findByGradeAndLevel")
                        .setParameter("grade", user.getGrade())
                        .setParameter("level", 3)
                        .getResultList();
                request.setAttribute("students", studentList);
                request.getRequestDispatcher("/assignmentmarks.jsp").forward(request, response);*/
                break;
            }
            case "assignmentMarksSave": {
                // Save marks to Database
                /*              if (request.getParameter("assignmentName") == null) {
                    response.sendRedirect("index.jsp");
                }
                String assignment = request.getParameter("assignmentName");
                // Get students in that class
                List<User> students = em.createNamedQuery("User.findByGradeAndLevel")
                        .setParameter("grade", user.getGrade())
                        .setParameter("level", 3)
                        .getResultList();
                for (User student : students) {
                    int mark = Integer.parseInt(request.getParameter(student.getUsername()));
                    AssignmentMarksPK assignmentMarksPK = new AssignmentMarksPK(student.getUsername(), user.getSubject(), assignment);
                    AssignmentMarks assignmentMarks = new AssignmentMarks(assignmentMarksPK, mark);

                    try {
                        utx.begin();
                        em.persist(assignmentMarks);
                        utx.commit();
                    } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                        Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                response.sendRedirect("index.jsp");*/
                break;
            }
            default:
                break;
        }
    }

    private Date getFormattedDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date = null;
        try {
            date = dateFormat.parse(dateFormat.format(new Date()));
        } catch (ParseException ex) {
            Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return date;
    }

    private void attendanceDetailsToDB(List students, String[] attendees) throws NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException, ParseException {
        Date date = getFormattedDate();

//                UserTransaction transaction = (UserTransaction) new InitialContext().lookup("java:comp/UserTransaction");
        for (Object student : students) {
            User s = (User) student;
            AttendancePK attendancePK = new AttendancePK(s.getUsername(), date);
            boolean attended = (attendees != null && Arrays.asList(attendees).contains(s.getUsername()));
            Attendance existing = em.find(Attendance.class, attendancePK);
            if (existing != null) {
                // record exists. update it
                utx.begin();
                existing.setAttended(attended);
                existing.setMarkedBy(user);

                em.merge(existing);
                utx.commit();
                return;
            }
            // no existing record. record a new one.
            Attendance attendance = new Attendance(attendancePK);
            attendance.setAttended(attended);
            attendance.setMarkedBy(user);

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
