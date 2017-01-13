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
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.Upload;
import lk.studysmart.apps.models.User;
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
    @Path("get/internal/{subjectid}/")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Upload> getInternalResources(@PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request) {
        
        Subject subject = em.find(Subject.class, subjectid);
        
        List<Upload> upload = em.createNamedQuery("Upload.findBySubject")
                .setParameter("subject", subject)
                .getResultList();
        
        return upload;
    }
}
