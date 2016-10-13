/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

import java.util.List;
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
import lk.studysmart.apps.models.Assignment;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.StudentSubject;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.TermMarks;
import lk.studysmart.apps.models.User;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author dinush
 */
@Stateless
@Path("acadamic")
public class Acadamic {
    @PersistenceContext(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private EntityManager em;
    
    /**
     * Get term test marks for user and given subject
     * @param username
     * @param term
     * @param subjectid
     * @param request
     * @return 
     */
    @GET
    @Path("marks/terms/{username}/{subject}/")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTermMarks(@PathParam("username") String username, @PathParam("term") Integer term, @PathParam("subject") String subjectid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        User student = em.find(User.class, username);
        Subject subject = em.find(Subject.class, subjectid);
        
        List<TermMarks> lst_mrks = em.createNamedQuery("TermMarks.findByUserSubject")
                .setParameter("username", student)
                .setParameter("subject", subject)
                .getResultList();
        
        JSONArray jarr_mrks = new JSONArray();
        for(TermMarks mrks:lst_mrks) {
            JSONObject jobj_mrks = new JSONObject();
            jobj_mrks.put("term", mrks.getTerm());
            jobj_mrks.put("value", mrks.getValue());
            jobj_mrks.put("marker_uname", mrks.getMarkedby().getUsername());
            jobj_mrks.put("marker_name", mrks.getMarkedby().getName());
            jarr_mrks.put(jobj_mrks);
        }
        return jarr_mrks.toString();
    }
    
    /**
     * Get subjects enrolled by the given student
     * @param uname
     * @param request
     * @return 
     */
    @GET
    @Path("subjects/{uname}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getEnrolledSubjectsOfStudent(@PathParam("uname") String uname, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        User u = em.find(User.class, uname);
        
        List<StudentSubject> lst_stusub = em.createNamedQuery("StudentSubject.findByUser")
                .setParameter("user", u)
                .getResultList();
        
        JSONArray jarr_subs = new JSONArray();
        for(StudentSubject stusub:lst_stusub) {
            JSONObject jobj_sub = new JSONObject();
            jobj_sub.put("sbj_id", stusub.getSubjectId().getIdSubject());
            jobj_sub.put("sbj_name", stusub.getSubjectId().getName());
            jarr_subs.put(jobj_sub);
        }
        
        return jarr_subs.toString();
    }
    
    /**
     * Get list of assignments for the given class
     * @param classid
     * @param request
     * @return 
     */
    @GET
    @Path("assignments/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAssignmentsForClass(@PathParam("classid") String classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        Class2 class2 = em.find(Class2.class, classid);
        
        // Get the list of assignment
        List<Assignment> assignments = em.createNamedQuery("Assignment.findByClass2")
                .setParameter("class2", class2)
                .getResultList();
        
        // Put into JSON
        JSONArray jarr = new JSONArray();
        for (Assignment assignment : assignments) {
            JSONObject jobj = new JSONObject();
            jobj.put("name", assignment.getName());
            jobj.put("subjectid", assignment.getSubject().getIdSubject());
            jobj.put("subjectname", assignment.getSubject().getName());
            jobj.put("max", assignment.getMax());
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
}
