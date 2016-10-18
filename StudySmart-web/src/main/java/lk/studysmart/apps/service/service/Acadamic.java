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
import lk.studysmart.apps.models.AssignmentMarks;
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
     * @param subjectid
     * @param request
     * @return 
     */
    @GET
    @Path("assignments/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAssignmentsForClass(@PathParam("classid") Integer classid, @PathParam("subjectid") String subjectid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        Class2 class2 = em.find(Class2.class, classid);
        Subject subject = em.find(Subject.class, subjectid);
        
        // Get the list of assignment
        List<Assignment> assignments = em.createNamedQuery("Assignment.findByClass2AndSubject")
                .setParameter("class2", class2)
                .setParameter("subject", subject)
                .getResultList();
        
        // Put into JSON
        JSONArray jarr = new JSONArray();
        for (Assignment assignment : assignments) {
            JSONObject jobj = new JSONObject();
            jobj.put("name", assignment.getName());
            jobj.put("subjectid", assignment.getSubject().getIdSubject());
            jobj.put("classid", class2.getId());
            jobj.put("max", assignment.getMax());
//            jobj.put("date", assignments)     TO-DO
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
    
    @GET
    @Path("assignment/marks/{assignment}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAssignmentMarks(@PathParam("assignment") String assignment_id, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        Assignment assignment = em.find(Assignment.class, assignment_id);
        
        List<AssignmentMarks> marks = em.createNamedQuery("AssignmentMarks.findByAssignment")
                .setParameter("assignment", assignment)
                .getResultList();
        
        // For statical calculation
        int highest = 0, lowest = assignment.getMax();
        int[] raw_marks = new int[marks.size()];
        int sum_of_marks = 0;
        
        JSONObject root = new JSONObject();
        root.put("name", assignment.getName());
        root.put("max", assignment.getMax());
        JSONArray jarr = new JSONArray();
        for( int i=0; i < marks.size(); i++ ) {
            AssignmentMarks rec = marks.get(i);
            JSONObject jobj = new JSONObject();
            jobj.put("id", rec.getId());
            jobj.put("student_username", rec.getStudent().getUsername());
            jobj.put("student_name", rec.getStudent().getName());
            jobj.put("marks", rec.getMark());
            jobj.put("comment", rec.getComment());
            jobj.put("author_username", rec.getAddedby().getUsername());
            jobj.put("author_name", rec.getAddedby().getName());
            jarr.put(jobj);
            raw_marks[i] = rec.getMark();
            sum_of_marks += rec.getMark();
            
            // Find the highest and the lowest
            if( raw_marks[i] < lowest )
                lowest = raw_marks[i];
            if( raw_marks[i] > highest )
                highest = raw_marks[i];
        }
        
        root.put("highest", highest);
        root.put("lowest", lowest);
        
        // Mean
        int mean = sum_of_marks / marks.size();
        root.put("mean", mean);
        
        // Calculating standard deviation
        int deviations = 0;
        for( int i=0; i < marks.size(); i++ ) {
            deviations += (raw_marks[i] - mean) ^ 2;
        }
        double standard_deviation = Math.sqrt(deviations / raw_marks.length);
        
        root.put("standard_deviation", standard_deviation);
        root.put("marks", jarr);
        
        return root.toString();
    }
}
