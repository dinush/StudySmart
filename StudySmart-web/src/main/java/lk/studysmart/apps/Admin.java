/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
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
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.Message;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.StudentSubject;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.TeacherTeaches;
import lk.studysmart.apps.models.User;
import utils.Utils;

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
        
        if (request.getParameter("action") == null) {   // In cases like POST/PUT
            String purpose = request.getParameter("purpose");
            if(purpose == null) {
                response.sendRedirect("/index.jsp");
            }
            switch (purpose) {
                case "changeExistingUser": {
                    try {
                        updateUserDetails(request);
                        response.getWriter().write("Successfully updated.");
                    } catch (ParseException | NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | IllegalStateException ex) {
                        Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
                        response.getWriter().write("Update failed.\n" + ex.getLocalizedMessage());
                    }
                }
                break;
            }
            
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
            case "register/principal": {
                try {
                    registerPrincipal(request);
                    response.sendRedirect("index.jsp?msg=User registered");
                } catch (HeuristicRollbackException | RollbackException | HeuristicMixedException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
                    Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
                    response.sendRedirect("index.jsp?msg=" + ex.getLocalizedMessage());
                }
            }
            break;
            case "register/admin": {
            try {
                registerAdmin(request);
                response.sendRedirect("index.jsp?msg=User registered");
            } catch (RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | SystemException | NotSupportedException ex) {
                Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("index.jsp?msg=Error: " + ex.getLocalizedMessage());
            }
            }
            break;
            case "news/general": {
                addGeneralNews(request);
                response.sendRedirect("index.jsp?msg=News Added Successfully");
            }
            break;
            case "changeUser": {
                forwardUserList(request, response, "/changeUser.jsp");
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
        response.sendRedirect("index.jsp?msg=User registration successfull");
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
        response.sendRedirect("index.jsp?msg=User registration successfull");
    }

    private void registerTeacher(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");
        String tel = request.getParameter("tp");
        String email = request.getParameter("email");
        String qualifications = request.getParameter("qualifications");
        // Construct <User>
        User teacher = new User();
        teacher.setUsername(username);
        teacher.setName(name);
        teacher.setGender(gender);
        teacher.setNic(nic);
        teacher.setAddress(address);
        teacher.setPhone(tel);
        teacher.setEmail(email);
        teacher.setQualifications(qualifications);
        teacher.setPassword("123"); // Default
        teacher.setLevel(2);
        // Persist
        try {
            utx.begin();
            em.persist(teacher);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Store subjects and classes
        String[] subjects = request.getParameterValues("subjects");
        for (String subjectid : subjects) {
            String[] classes = request.getParameterValues(subjectid + "_class");
            Subject subject = em.find(Subject.class, subjectid);
            for (String classid : classes) {
                Class2 class2 = em.find(Class2.class, Integer.parseInt(classid));
                // Construct model
                TeacherTeaches ttes = new TeacherTeaches();
                ttes.setUserId(teacher);
                ttes.setClass1(class2);
                ttes.setSubjectId(subject);
                try {
                    // Persist
                    utx.begin();
                    em.persist(ttes);
                    utx.commit();
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        }
        try {
            response.sendRedirect("index.jsp?msg=User registration successfull");
        } catch (IOException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void registerPrincipal(HttpServletRequest request) throws HeuristicRollbackException, RollbackException, HeuristicMixedException, SecurityException, IllegalStateException, SystemException, NotSupportedException {
        User principal = new User();
        principal.setUsername(request.getParameter("username"));
        principal.setName(request.getParameter("name"));
        principal.setGender(request.getParameter("gender"));
        principal.setNic(request.getParameter("nic"));
        principal.setAddress(request.getParameter("address"));
        principal.setPhone(request.getParameter("tp"));
        principal.setEmail(request.getParameter("email"));
        principal.setQualifications(request.getParameter("qualification"));
        principal.setPassword("123");
        principal.setLevel(1);
        
        utx.begin();
        em.persist(principal);
        try {
            utx.commit();
        } catch (HeuristicRollbackException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void registerAdmin(HttpServletRequest request) throws RollbackException, HeuristicMixedException, HeuristicRollbackException, SecurityException, IllegalStateException, SystemException, NotSupportedException {
        User admin = new User();
        
        admin.setLevel(0);
        admin.setPassword("123");
        admin.setUsername(request.getParameter("username"));
        admin.setName(request.getParameter("name"));
        admin.setGender(request.getParameter("gender"));
        admin.setNic(request.getParameter("nic"));
        admin.setAddress(request.getParameter("address"));
        admin.setPhone(request.getParameter("tp"));
        
        utx.begin();
        em.persist(admin);
        utx.commit();
    }
    
    private void addGeneralNews(HttpServletRequest request) {
        String str_msg = request.getParameter("msg");
        
        Message msg = new Message();
        msg.setContent(str_msg);
        msg.setAddeduser(user);
        msg.setAddeddate(Utils.getFormattedDate());
        msg.setAddedtime(Utils.getFormattedTime());
        msg.setType(5);
        
        try {
            utx.begin();
            em.persist(msg);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * Forward details about all the users.
     * @param request 
     */
    private void forwardUserList(HttpServletRequest request, HttpServletResponse response, String forwardUrl) throws ServletException, IOException {
        List<User> users = em.createNamedQuery("User.findAll").getResultList();
        
        request.setAttribute("users", users);
        getServletContext().getRequestDispatcher(forwardUrl).forward(request, response);
    }
    
    /**
     * Update details of existing user
     * @param request 
     */
    private void updateUserDetails(HttpServletRequest request) throws ParseException, NotSupportedException, SystemException, RollbackException, HeuristicMixedException, HeuristicRollbackException, IllegalStateException {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String password = request.getParameter("password"); // this will be null if password is not changing
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        Date birthday = utils.Utils.getFormattedDate(request.getParameter("birthday"));
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");
        
        User changingUser = em.find(User.class, username);
        changingUser.setName(name);
        if (password != null)
            changingUser.setPassword(password);
        changingUser.setEmail(email);
        changingUser.setGender(gender);
        changingUser.setBirthdate(birthday);
        changingUser.setAddress(address);
        changingUser.setNic(nic);
        changingUser.setPhone(phone);
        
        utx.begin();
        em.merge(changingUser);
        try {
            utx.commit();
        } catch (HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
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
