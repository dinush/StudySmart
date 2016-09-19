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
    
    @GET
    @Path("marks/term/{username}/{term}/{subject}/")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTermMarks(@PathParam("username") String username, @PathParam("term") Integer term, @PathParam("subject") String subjectid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        User student = em.find(User.class, username);
        Subject subject = em.find(Subject.class, subjectid);
        
        List<TermMarks> lst_mrks = em.createNamedQuery("TermMarks.findByTermUserSubject")
                .setParameter("term", term)
                .setParameter("username", student)
                .setParameter("subject", subject)
                .getResultList();
        
        JSONObject jobj_mrks = new JSONObject();
        if(lst_mrks.isEmpty()) 
            return null;
        
        jobj_mrks.put("value", lst_mrks.get(0).getValue());
        jobj_mrks.put("marker_uname", lst_mrks.get(0).getMarkedby().getUsername());
        jobj_mrks.put("marker_name", lst_mrks.get(0).getMarkedby().getName());
        
        return jobj_mrks.toString();
    }
    
    @GET
    @Path("subjects/{uname}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTermMarks(@PathParam("uname") String uname, @Context HttpServletRequest request) {
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
}
