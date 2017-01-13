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
import lk.studysmart.apps.models.Internalresources;
import lk.studysmart.apps.models.Subject;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author dinush
 */
@Stateless
@Path("resources")
public class Resources {
    @PersistenceContext(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private EntityManager em;
    
    @GET
    @Path("get/list/internal/{subjectid}/")
    @Produces(MediaType.APPLICATION_JSON)
    public String getInternalResources(@PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request) {
        
        Subject subject = em.find(Subject.class, subjectid);
        
        JSONArray jarray = new JSONArray();
        
        List<Internalresources> resources = em.createNamedQuery("Resource.findBySubject")
                .setParameter("subject", subject)
                .getResultList();
        
        for ( int i=0; i < resources.size(); i++ ){
            JSONObject jobj = new JSONObject();
            jobj.put("id", resources.get(i).getId());
            jobj.put("uploader_username", resources.get(i).getUser().getUsername());
            jobj.put("uploader_name", resources.get(i).getUser().getName());
            jobj.put("subject_id", resources.get(i).getSubject().getIdSubject());
            jobj.put("subject_name", resources.get(i).getSubject().getName());
            jobj.put("filename", resources.get(i).getFilename());
            jobj.put("description", resources.get(i).getDescription());
            
            jarray.put(jobj);
        }
        
        return jarray.toString();
    }
}
