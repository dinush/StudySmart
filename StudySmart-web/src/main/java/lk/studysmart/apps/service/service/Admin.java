/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

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
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import lk.studysmart.apps.models.User;

/**
 *
 * @author dinush
 */
@Stateless
@Path("admin")
public class Admin {
    
    @PersistenceContext
    EntityManager em;
    
    @DELETE
    @Path("removeuser/{username}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void removeUser(@PathParam("username") String username,
            @Context HttpServletRequest request) {
        
        User deleteUser = em.find(User.class, username);
        
        em.remove(deleteUser);
    }
    
}
