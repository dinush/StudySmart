/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author dinush
 */
@javax.ws.rs.ApplicationPath("ws")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(lk.studysmart.apps.service.service.Acadamic.class);
        resources.add(lk.studysmart.apps.service.service.AssignmentFacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.AssignmentMarksFacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.Class2FacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.RestServices.class);
        resources.add(lk.studysmart.apps.service.service.Search.class);
        resources.add(lk.studysmart.apps.service.service.StudentParentFacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.StudentSubjectFacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.SubjectFacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.TeacherTeachesFacadeREST.class);
        resources.add(lk.studysmart.apps.service.service.TermMarksFacadeREST.class);
    }
    
}
