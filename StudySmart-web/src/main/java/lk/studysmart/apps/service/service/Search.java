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
import lk.studysmart.apps.models.User;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author dinush
 */
@Stateless
@Path("search")
public class Search {
    @PersistenceContext(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private EntityManager em;
    
    @GET
    @Path("user/exact/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    public String searchByUsername(@PathParam("username") String username, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        // Get possible users
        List<User> users = em.createNamedQuery("User.findByUsername")
                .setParameter("username", username)
                .getResultList();
        // Put into JSON
        JSONArray jarr = new JSONArray();
        for(User user:users) {
            JSONObject jobj = new JSONObject();
            jobj.put("username", user.getUsername());
            jobj.put("name", user.getName());
            jobj.put("level", user.getLevel());
            jobj.put("email", user.getEmail());
            jobj.put("class", user.getClass1().getGrade());
            jobj.put("subclass", user.getClass1().getSubclass());
            jobj.put("gender", user.getGender());
            jobj.put("birthdate", user.getBirthdate());
            jobj.put("nic", user.getNic());
            jobj.put("address", user.getAddress());
            jobj.put("occupation", user.getOccupation());
            jobj.put("tp", user.getPhone());
            jobj.put("qualifications", user.getQualifications());
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
}