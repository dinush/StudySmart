/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.BufferedReader;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.AbstractMap;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
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
import lk.studysmart.apps.models.Assignment;
import lk.studysmart.apps.models.AssignmentMarks;
import lk.studysmart.apps.models.Attendance;
import lk.studysmart.apps.models.AttendancePK;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.TeacherTeaches;
import lk.studysmart.apps.models.TermMarks;
import lk.studysmart.apps.models.User;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.Utils;

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
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Show input attendance form
        switch (request.getParameter("action")) {
            case "attendance":
                // Send attendance input page
                if (request.getParameter("grade") != null) {
                    User lastMarkedUser = null;
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
                    Date date = Utils.getFormattedDate();
                    for (Object student : students) {
                        User s = (User) student;
                        AttendancePK apk = new AttendancePK(s.getUsername(), date);
                        Boolean attended = false;
                        try {
                            Attendance att = (Attendance) em.createNamedQuery("Attendance.findByUserAndDate")
                                    .setParameter("attendancePk", apk)
                                    .getSingleResult();
                            attended = att.getAttended();
                            lastMarkedUser = att.getMarkedBy();
                        } catch (NoResultException e) {
                            // do nothing
                        }
                        attendances.put(s, attended);
                    }
                    request.setAttribute("students", attendances);
                    request.setAttribute("lastmarkeduser", lastMarkedUser);
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
            case "checkattendancefor": {
                /*String studentId = request.getParameter("id");

                User student = (User) em.createNamedQuery("User.findByUsername")
                        .setParameter("username", studentId)
                        .getSingleResult();

                List days = em.createNamedQuery("Attendance.findByUsername")
                        .setParameter("username", studentId)
                        .getResultList();
                request.setAttribute("student", student);
                request.setAttribute("days", days);
                request.getRequestDispatcher("/viewattendance.jsp").forward(request, response);*/
                break;
            }
            case "termtestmarks": {
                if (user.getLevel() > 2) {  // Students and Parents are not allowed here
                    response.sendRedirect("index.jsp");
                }

                // after user selecting the subject and class to input marks for
                if (request.getParameter("selected") != null) {
                    int classid = Integer.parseInt(request.getParameter("teaches"));
                    int term = Integer.parseInt(request.getParameter("term"));
                    TeacherTeaches teaches = em.find(TeacherTeaches.class, classid);
                    List students = em.createNamedQuery("User.findByClass")
                            .setParameter("class2", teaches.getClass1())
                            .getResultList();

                    HashMap<User, String> marks = new HashMap<>();
                    for (Object student : students) {
                        User s = (User) student;
                        marks.put(s, null);
                        try {
                            List termMarks = em.createNamedQuery("TermMarks.findByAll")
                                    .setParameter("student", s)
                                    .setParameter("class2", teaches.getClass1())
                                    .setParameter("subject", teaches.getSubjectId())
                                    .setParameter("term", term)
                                    .getResultList();
                            if (termMarks.size() > 0) {
                                TermMarks termMark = (TermMarks) termMarks.get(0);

                                marks.replace(s, String.valueOf(termMark.getValue()));
                            }
                        } catch (NoResultException e) {

                        }
                    }
                    request.setAttribute("term", request.getParameter("term"));
                    request.setAttribute("marks", marks);
                    request.setAttribute("classid", teaches.getClass1().getId());
                    request.setAttribute("grade", teaches.getClass1().getGrade());
                    request.setAttribute("subclass", teaches.getClass1().getSubclass());
                    request.setAttribute("subjectid", teaches.getSubjectId().getIdSubject());
                    request.setAttribute("subjectname", teaches.getSubjectId().getName());
                    request.setAttribute("selected", true);
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

                StringBuilder buf = new StringBuilder();
                String line = null;
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
                JSONObject meta = jobj.getJSONObject("meta");
                Subject subject = em.find(Subject.class, meta.getString("subjectid"));
                Class2 class2 = em.find(Class2.class, meta.getInt("classid"));
                int term = meta.getInt("term");

                JSONArray values = jobj.getJSONArray("values");
                try {
                    utx.begin();
                    for (int i = 0; i < values.length(); i++) {
                        JSONObject item = values.getJSONObject(i);
                        User student = em.find(User.class, item.getString("studentid"));
                        int marks = item.getInt("marks");

                        // check if record exists
                        List<TermMarks> checklist = em.createNamedQuery("TermMarks.findByAll")
                                .setParameter("student", student)
                                .setParameter("class2", class2)
                                .setParameter("subject", subject)
                                .setParameter("term", term)
                                .getResultList();
                        TermMarks mrk;
                        
                        if (checklist.size() > 0) {
                            mrk = checklist.get(0);
                        } else {
                            mrk = new TermMarks();
                        }                        
                        mrk.setClass1(class2);
                        mrk.setMarkedby(user);
                        mrk.setStudent(student);
                        mrk.setSubject(subject);
                        mrk.setTerm(term);
                        mrk.setValue(marks);

                        em.merge(mrk);
                    }
                    utx.commit();
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                }
                /*
                String sclassid = request.getParameter("classid");
                String sterm = request.getParameter("term");
                int classid = Integer.parseInt(request.getParameter("classid"));
                int term = Integer.parseInt(request.getParameter("term"));
                String subjectid = request.getParameter("subjectid");

                Class2 class2 = em.find(Class2.class, classid);
                Subject subject = em.find(Subject.class, subjectid);

                // get all the students in that class
                List students = em.createNamedQuery("User.findByClass")
                        .setParameter("class2", class2)
                        .getResultList();

                for (Object st : students) {
                    try {
                        User student = (User) st;
                        int m = Integer.parseInt(request.getParameter(student.getUsername()));
                        List termMarks = em.createNamedQuery("TermMarks.findByAll")
                                .setParameter("student", student)
                                .setParameter("class2", class2)
                                .setParameter("subject", subject)
                                .setParameter("term", term)
                                .getResultList();

                        utx.begin();
                        if (termMarks.size() > 0) {
                            TermMarks tm = (TermMarks) termMarks.get(0);
                            tm.setValue(m);
                            tm.setMarkedby(user);
                            em.merge(tm);
                        } else {
                            TermMarks tm = new TermMarks();
                            tm.setStudent(student);
                            tm.setClass1(class2);
                            tm.setSubject(subject);
                            tm.setTerm(term);
                            tm.setValue(m);
                            tm.setMarkedby(user);
                            em.persist(tm);
                        }
                        utx.commit();

                    } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                        Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }

                response.sendRedirect("index.jsp");*/
                break;
            }
            case "assignmentmarks": {
                if (user.getLevel() == 2) {

                    List teachSubjects = em.createNamedQuery("TeacherTeaches.findByUser")
                            .setParameter("user", user)
                            .getResultList();

                    request.setAttribute("teaches", teachSubjects);
                    request.getRequestDispatcher("/enterAssignmentMarks.jsp").forward(request, response);
                }
                break;
            }
            case "assignmentMarksSave": {
                /**
                 * Make sure inputs are validated
                 */

                // check if assignment name exists.
                Assignment as = em.find(Assignment.class, request.getParameter("name"));
                if (as != null) {
                    response.sendRedirect("StudentManager?action=assignmentmarks&msg=Assignment name already exists.");
                    return;
                }

                Class2 class2 = em.find(Class2.class, Integer.parseInt(request.getParameter("class")));
                Subject subject = em.find(Subject.class, request.getParameter("subject"));

                Assignment assignment = new Assignment();
                assignment.setName(request.getParameter("name"));
                assignment.setMax(Integer.parseInt(request.getParameter("max")));
                assignment.setClass1(class2);
                assignment.setSubject(subject);

                try {
                    utx.begin();
                    em.persist(assignment);
                    utx.commit();
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                    response.sendRedirect("StudentManager?action=assignmentmarks&msg=Something went wrong.");
                    return;
                }

                Enumeration<String> params = request.getParameterNames();
                while (params.hasMoreElements()) {
                    String elem = params.nextElement();
                    if (!elem.startsWith("st##-")) {
                        continue;
                    }

                    int indexOfDelim = elem.indexOf("-");
                    String username = elem.substring(indexOfDelim + 1);
                    User student = em.find(User.class, username);
                    int mark = Integer.parseInt(request.getParameter(elem));
                    String comment = request.getParameter(username);

                    AssignmentMarks am = new AssignmentMarks();
                    am.setAssignment(assignment);
                    am.setStudent(student);
                    am.setMark(mark);
                    am.setComment(comment);
                    am.setAddedby(user);

                    try {
                        utx.begin();
                        em.persist(am);
                        utx.commit();
                    } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                        Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                response.sendRedirect("index.jsp");
                break;
            }
            default:
                break;
        }
    }

    private void attendanceDetailsToDB(List students, String[] attendees) throws NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException, ParseException {
        Date date = Utils.getFormattedDate();

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
