/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
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
@Path("admin")
public class Admin {
    
    @PersistenceContext
    EntityManager em;
    
    @GET
    @Path("get/user/all")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllUsers(@Context HttpServletRequest request) {
        List<User> users = (List<User>) em.createNamedQuery("User.findAll")
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        for (User user : users) {
            JSONObject jobj = new JSONObject();
            jobj.put("username", user.getUsername());
            jobj.put("name", user.getName());
            jobj.put("email", user.getEmail());
            jobj.put("level", user.getLevel());
            jobj.put("class", user.getClass1());
            jobj.put("gender", user.getGender());
            jobj.put("birthdate", user.getBirthdate() != null ? utils.Utils.getFormattedDateString(user.getBirthdate()) : null);
            jobj.put("nic", user.getNic());
            jobj.put("address", user.getAddress());
            jobj.put("occupation", user.getOccupation());
            jobj.put("phone", user.getPhone());
            jobj.put("qualifications", user.getQualifications());
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
    
    @DELETE
    @Path("removeuser/{username}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void removeUser(@PathParam("username") String username,
            @Context HttpServletRequest request) {
        
        User deleteUser = em.find(User.class, username);
        
        em.remove(deleteUser);
    }
    
}
