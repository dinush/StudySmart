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
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.PathSegment;
import lk.studysmart.apps.models.Marks;
import lk.studysmart.apps.models.MarksPK;

/**
 *
 * @author dinush
 */
@Stateless
@Path("lk.studysmart.apps.models.marks")
public class MarksFacadeREST extends AbstractFacade<Marks> {

    @PersistenceContext(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    private MarksPK getPrimaryKey(PathSegment pathSegment) {
        /*
         * pathSemgent represents a URI path segment and any associated matrix parameters.
         * URI path part is supposed to be in form of 'somePath;username=usernameValue;idSubject=idSubjectValue;term=termValue'.
         * Here 'somePath' is a result of getPath() method invocation and
         * it is ignored in the following code.
         * Matrix parameters are used as field names to build a primary key instance.
         */
        lk.studysmart.apps.models.MarksPK key = new lk.studysmart.apps.models.MarksPK();
        javax.ws.rs.core.MultivaluedMap<String, String> map = pathSegment.getMatrixParameters();
        java.util.List<String> username = map.get("username");
        if (username != null && !username.isEmpty()) {
            key.setUsername(username.get(0));
        }
        java.util.List<String> idSubject = map.get("idSubject");
        if (idSubject != null && !idSubject.isEmpty()) {
            key.setIdSubject(idSubject.get(0));
        }
        java.util.List<String> term = map.get("term");
        if (term != null && !term.isEmpty()) {
            key.setTerm(new java.lang.Integer(term.get(0)));
        }
        return key;
    }

    public MarksFacadeREST() {
        super(Marks.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(Marks entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") PathSegment id, Marks entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") PathSegment id) {
        lk.studysmart.apps.models.MarksPK key = getPrimaryKey(id);
        super.remove(super.find(key));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Marks find(@PathParam("id") PathSegment id) {
        lk.studysmart.apps.models.MarksPK key = getPrimaryKey(id);
        return super.find(key);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Marks> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Marks> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces(MediaType.TEXT_PLAIN)
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
