/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

import java.util.List;
import java.util.Map;
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
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.StudentSubject;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.TeacherTeaches;
import lk.studysmart.apps.models.User;
import org.json.JSONArray;
import org.json.JSONObject;

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
    @Path("teacher/subjects/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTeachingSubjects(@PathParam("classid") Integer classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null)
            return "Not authorized";
        
        Class2 class2 = em.find(Class2.class, classid);
        List<TeacherTeaches> teaching = em.createNamedQuery("TeacherTeaches.findByClass")
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
     * Get all the classes in the school
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
}
