/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.BufferedReader;
import java.io.IOException;
import java.text.ParseException;
import java.util.Enumeration;
import java.util.List;
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
import lk.studysmart.apps.models.Assignment;
import lk.studysmart.apps.models.AssignmentMarks;
import lk.studysmart.apps.models.Attendance;
import lk.studysmart.apps.models.AttendanceClass;
import lk.studysmart.apps.models.AttendanceClassPK;
import lk.studysmart.apps.models.AttendancePK;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.Message;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.Subject;
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

    protected String getRequestData(HttpServletRequest request) throws IOException {

        StringBuilder buf = new StringBuilder();
        String line;
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            buf.append(line);
        }

        return buf.toString();
    }
    
    protected void sendPersonalMsg(String title, String content, User toUsr, User fromUsr) {
        Message msg = new Message();
        msg.setAddeddate(Utils.getFormattedDate());
        msg.setAddedtime(Utils.getFormattedTime());
        msg.setAddeduser(fromUsr);
        msg.setContent(content);
        msg.setTargetuser(toUsr);
        msg.setTitle(title);
        msg.setType(1);
        
        try {
            utx.begin();
            em.persist(msg);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

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
        // if user is not signed in, send to the login page
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        switch (action) {
            case "attendancemarked": {
                // Show input attendance form
                // Send attendance details to the database.
                JSONObject data = new JSONObject(getRequestData(request));
                JSONObject meta = data.getJSONObject("meta");

                // set or update attendance marked status for the class
                Class2 class2 = em.find(Class2.class, meta.getInt("classid"));
                AttendanceClassPK acpk = new AttendanceClassPK(class2.getId(), Utils.getFormattedDate());
                AttendanceClass ac = new AttendanceClass(acpk);
                ac.setMarkedby(user);
                try {
                    utx.begin();
                    em.merge(ac);
                    utx.commit();
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                // Send individual attendance records to the database
                JSONArray values = data.getJSONArray("values");
                for (int i = 0; i < values.length(); i++) {
                    JSONObject value = values.getJSONObject(i);
                    AttendancePK att_pk = new AttendancePK(value.getString("studentid"), Utils.getFormattedDate());
                    Attendance att = new Attendance(att_pk);
                    att.setMarkedBy(user);
                    att.setAttended((value.getInt("attended") == 1 ? Boolean.TRUE : Boolean.FALSE));

                    try {
                        utx.begin();
                        em.merge(att);
                        utx.commit();
                    } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                        Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            }
            break;
            case "termtestmarkssave": {
                // Send term test marks data to database
                JSONObject jobj = new JSONObject(getRequestData(request));
                JSONObject meta = jobj.getJSONObject("meta");
                Subject subject = em.find(Subject.class, meta.getString("subjectid"));
                Class2 class2 = em.find(Class2.class, meta.getInt("classid"));
                int term = meta.getInt("term");

                JSONArray values = jobj.getJSONArray("values");
                try {
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
                            // Record exists. Load it for update
                            mrk = checklist.get(0);
                        } else {
                            // Record does not exist. Make a new one.
                            mrk = new TermMarks();
                        }
                        mrk.setClass1(class2);
                        mrk.setMarkedby(user);
                        mrk.setStudent(student);
                        mrk.setSubject(subject);
                        mrk.setTerm(term);
                        mrk.setValue(marks);

                        utx.begin();
                        em.merge(mrk);
                        utx.commit();
                        
                        // Send message to student stating that the term test marks are added.
                        String title = "Term " + term + " marks";
                        String content = "Term " + term + " marks added for " + subject.getName();
                        sendPersonalMsg(title, content, student, user);
                        // Send message to Parent stating that the term test marks are added.
                        List<StudentParent> stu_par = em.createNamedQuery("StudentParent.findByStudentId")
                                .setParameter("student", student)
                                .getResultList();
                        if(stu_par.size() > 0) {
                            content += " (student: " + student.getName() + " [" + student.getUsername() + "])"; // add student info
                            sendPersonalMsg(title, content, stu_par.get(0).getParentid(), user);
                        }       
                    }
                    
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                }
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
                 * Save assignment marks to the database. Make sure inputs are
                 * validated.
                 */

                // check if assignment name exists.
                Assignment as = em.find(Assignment.class, request.getParameter("name"));
                if (as != null) {
                    // It exists. Abort and notify the user.
                    response.sendRedirect("StudentManager?action=assignmentmarks&msg=Assignment name already exists.");
                    return;
                }

                Class2 class2 = em.find(Class2.class, Integer.parseInt(request.getParameter("class")));
                Subject subject = em.find(Subject.class, request.getParameter("subject"));

                // New assignment record.
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

                // New assignment individual records addition.
                Enumeration<String> params = request.getParameterNames();
                while (params.hasMoreElements()) {
                    String elem = params.nextElement();
                    // If the element is not a student name (they have 'st##-' prefix), skip it.
                    if (!elem.startsWith("st##-")) {
                        continue;
                    }

                    // Extract the username (after the identification prefix).
                    int indexOfDelim = elem.indexOf("-");
                    String username = elem.substring(indexOfDelim + 1);
                    User student = em.find(User.class, username);
                    int mark = Integer.parseInt(request.getParameter(elem));
                    String comment = request.getParameter(username);
                    // Record individual assignment marks
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
            }
            break;            
            case "SingleStudentAttendance": {
                /**
                 * Show attendance for a student in a static way.
                 */

                // Get request parameters
                String username = request.getParameter("user");
                String from = request.getParameter("from");
                String to = request.getParameter("to");
                
                User student = em.find(User.class, username);
                request.setAttribute("student", student);
                // Get attendance details
                try {
                    List<Attendance> lstAtt = em.createNamedQuery("Attendance.findByUserAndDateRange")
                            .setParameter("username", username)
                            .setParameter("from", Utils.getFormattedDate(from))
                            .setParameter("to", Utils.getFormattedDate(to))
                            .getResultList();
                    
                    request.setAttribute("lstAtt", lstAtt);
                    request.setAttribute("student-username", username);
                    request.setAttribute("student-name", student.getName());
                    request.setAttribute("student-class", "Grade " + student.getClass1().getGrade() + " " + student.getClass1().getSubclass());
                    request.setAttribute("from", from);
                    request.setAttribute("to", to);
                    
                    request.getRequestDispatcher("/AttendanceSingle.jsp").forward(request, response);
                } catch (ParseException ex) {
                    Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
            default:
                System.out.println("Unhandled route");
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
