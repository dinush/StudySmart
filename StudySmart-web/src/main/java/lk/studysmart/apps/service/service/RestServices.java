/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.beans.property.SimpleMapProperty;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import lk.studysmart.apps.models.Attendance;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.Message;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.StudentSubject;
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
@Stateless
@Path("rest")
public class RestServices {
    
    @PersistenceContext(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private EntityManager em;
    
    
    /**
     * Get students in a specific classroom AND enrolled for the given subject.
     * @param classid
     * @param subjectid
     * @param request
     * @return 
     */
    @GET
    @Path("student/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getStudents(@PathParam("classid") Integer classid, @PathParam("subjectid") String subjectid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        Subject subject = em.find(Subject.class, subjectid);
        Class2 class2 = em.find(Class2.class, classid);
        
        JSONArray jarray = new JSONArray();
        
        List<StudentSubject> studentSubjects = em.createNamedQuery("StudentSubject.findBySubject")
                .setParameter("subject", subject)
                .getResultList();
        
        for (StudentSubject ss : studentSubjects) {
            User user = ss.getUserId();
            if (!user.getClass1().equals(class2)) 
                continue;
            
            JSONObject jobj = new JSONObject();
            jobj.put("username",ss.getUserId().getUsername());
            jobj.put("name", ss.getUserId().getName());
            jarray.put(jobj);
        }
        
        return jarray.toString();
    }
    
    /**
     * Get the subjects which are taught by the teacher and for the specific classroom. 
     * @param classid
     * @param request
     * @return 
     */
    @GET
    @Path("teacher/{teacherid}/subjects/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTeachingSubjects(@PathParam("teacherid") String teacherid, @PathParam("classid") Integer classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        User teacher = em.find(User.class, teacherid);
        Class2 class2 = em.find(Class2.class, classid);
        List<TeacherTeaches> teaching = em.createNamedQuery("TeacherTeaches.findByUserClass")
                .setParameter("user", teacher)
                .setParameter("class2", class2)
                .getResultList();
        
        JSONArray jarray = new JSONArray();
        
        for (TeacherTeaches teaches : teaching) {
            Subject subject = teaches.getSubjectId();
            JSONObject jobj = new JSONObject();
            jobj.put("id", subject.getIdSubject());
            jobj.put("name", subject.getName());
            jarray.put(jobj);
        }
        return jarray.toString();
    }
    
    /**
     * Get Classes taught by a teacher
     * @param teacherid
     * @param request
     * @return 
     */
    @GET
    @Path("teacher/{teacherid}/classes")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTeacherSubjects(@PathParam("teacherid") String teacherid, @Context HttpServletRequest request) {
        User teacher = em.find(User.class, teacherid);
        List<TeacherTeaches> tch_clss = em.createNamedQuery("TeacherTeaches.findByUser")
                .setParameter("user", teacher)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        
        for (TeacherTeaches tt:tch_clss) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", tt.getClass1().getId());
            jobj.put("name", "Grade " + tt.getClass1().getGrade() + " " + tt.getClass1().getSubclass());
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
    
    /**
     * Get subject which are related to the given class
     * @param classid
     * @param request
     * @return 
     */
    @GET
    @Path("subjects/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSubjectsBelongsToClass(@PathParam("classid") Integer classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        Class2 class2 = em.find(Class2.class, classid);
        
        List<Subject> subjects = em.createNamedQuery("Subject.findByGrade")
                .setParameter("grade", class2.getGrade())
                .getResultList();
        
        JSONArray jarray = new JSONArray();
        
        for (Subject subject : subjects) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", subject.getIdSubject());
            jobj.put("name", subject.getName());
            jarray.put(jobj);
        }
        return jarray.toString();
    }
    
    /**
     * Get all the classes
     * @param request
     * @return 
     */
    @GET
    @Path("classes")
    @Produces(MediaType.APPLICATION_JSON)
    public String getClasses(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        List<Class2> classes = em.createNamedQuery("Class.findAll")
                .getResultList();
        
        JSONArray jarray = new JSONArray();
        
        for (Class2 class2 : classes) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", class2.getId());
            jobj.put("name", class2.getGrade() + " " + class2.getSubclass());
            jarray.put(jobj);
        }
        
        return jarray.toString();
    }
    
    /**
     * Get all the students
     * @param request
     * @return 
     */
    @GET
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    public String getParentlessStudents(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        List<User> students = em.createNamedQuery("User.findByLevel")
                .setParameter("level", 3)
                .getResultList();
        
        JSONArray jarray = new JSONArray();
        
        for (User student : students) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", student.getUsername());
            jobj.put("name", student.getName());
            jarray.put(jobj);
        }
        
        return jarray.toString();
    }
    
    /**
     * Get attendance between date period and specific user
     * @param studentid
     * @param from
     * @param to
     * @param request
     * @return 
     */
    @GET
    @Path("attendance/{studentid}/{from}/{to}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAttendanceByUseridDate(@PathParam("studentid") String studentid, @PathParam("from") String from, @PathParam("to") String to, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        from = from.replace("%", "/");
        to = to.replace("%2F", "/");
        
        Date dFrom, dTo;
        try {
            dFrom = Utils.getFormattedDate(from);
            dTo = Utils.getFormattedDate(to);
        } catch (ParseException ex) {
            Logger.getLogger(RestServices.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
        List<Attendance> att_datas = em.createNamedQuery("Attendance.findByUserAndDateRange")
                .setParameter("username", studentid)
                .setParameter("from", dFrom)
                .setParameter("to", dTo)
                .getResultList();
        
        JSONArray jarray = new JSONArray();
        
        for (Attendance att : att_datas) {
            JSONObject jobj = new JSONObject();
            jobj.put("date", Utils.getFormattedDateString(att.getAttendancePK().getDate()));
            jobj.put("attended", att.getAttended());
            jobj.put("markedby", att.getMarkedBy().getName());
            jobj.put("markedbyid", att.getMarkedBy().getUsername());
            
            jarray.put(jobj);
        }
        
        return jarray.toString();
    }
    
    /**
     * Get students belong to specific parent
     * @param parentid
     * @param request
     * @return 
     */
    @GET
    @Path("parent/{parentid}/students")
    @Produces(MediaType.APPLICATION_JSON)
    public String getStudentsBelongToParent(@PathParam("parentid") String parentid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        User parent = em.find(User.class, parentid);
        
        List<StudentParent> spl = em.createNamedQuery("StudentParent.findByParentId")
                .setParameter("parent", parent)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        
        for(StudentParent sp : spl) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", sp.getStudentid().getUsername());
            jobj.put("name", sp.getStudentid().getName());
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
    
    /**
     * Get Term test marks by term AND class AND subject
     * @param term
     * @param classid
     * @param subjectid
     * @param request
     * @return 
     */
    @GET
    @Path("termmarks/all/{term}/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTermmarksByTermClassSubject(
            @PathParam("term") Integer term, 
            @PathParam("classid") Integer classid, 
            @PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request) {
        
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        Class2 class2 = em.find(Class2.class, classid);
        Subject subject = em.find(Subject.class, subjectid);
        
        // get all the students in the class
        List<User> students = em.createNamedQuery("User.findByClassLevel")
                .setParameter("class2", class2)
                .setParameter("level", 3)
                .getResultList();
        
        // Get students who has enrolled for the specific subject
        List<User> enrolls = em.createNamedQuery("StudentSubject.findBySubjectGetUser")
                .setParameter("subject", subject)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        // filter students who has entrolled  for the specific subject
        for(User st:students) {
            if (!enrolls.contains(st)) 
                continue;
            
            JSONObject jobj = new JSONObject();
            jobj.put("studentid", st.getUsername());
            jobj.put("studentname", st.getName());
            
            // If marks exists, add them
            List<TermMarks> marks = em.createNamedQuery("TermMarks.findByAll")
                    .setParameter("student", st)
                    .setParameter("class2", class2)
                    .setParameter("subject", subject)
                    .setParameter("term", term)
                    .getResultList();            
            if (!marks.isEmpty()) {
                jobj.put("marks", marks.get(0).getValue());
                jobj.put("markedbyid", marks.get(0).getMarkedby().getUsername());
                jobj.put("markedbyname", marks.get(0).getMarkedby().getName());
            }
            
            jarr.put(jobj);            
        }
        
        return jarr.toString();
    }
    
    /**
     * Get all the messages related to the user.
     * If the user is a parent, students messages are shown. (student username is sent by a param, which is null otherwise).
     * @param request
     * @param studentid 
     * @return 
     */
    @GET
    @Path("messages/{studentid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getClassNews(@PathParam("studentid") String studentid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        User user = (User) request.getSession().getAttribute("user");
        Class2 class2 = user.getClass1();
        if (class2 == null) {
            if(user.getLevel() == 4) { 
                // Use child's class
                User student = em.find(User.class, studentid);
                class2 = student.getClass1();
            } else {
                // build an impossible class ;)
                class2 = new Class2();
                class2.setGrade(-1);
                class2.setSubclass("zz");
            }
        }
        
        List<Message> msgs = em.createNamedQuery("Message.findByFourOrs")
                .setParameter("user", user)
                .setParameter("userlevel", user.getLevel())
                .setParameter("class2", class2)
                .setParameter("grade", class2)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        for(Message msg:msgs) {
            JSONObject jobj = new JSONObject();
            jobj.put("seen", msg.getSeen());
            jobj.put("title", msg.getTitle());
            jobj.put("content", msg.getContent());
            jobj.put("target-date", msg.getTargetdate());
            jobj.put("target-time", msg.getTargettime());
            jobj.put("added-user-id", msg.getAddeduser().getUsername());
            jobj.put("added-user-name", msg.getAddeduser().getName());
            jobj.put("added-date", msg.getAddeddate());
            jobj.put("added-time", msg.getAddedtime());
            jobj.put("type", msg.getType());
            
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
}
