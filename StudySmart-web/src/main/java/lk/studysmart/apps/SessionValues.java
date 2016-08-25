/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps;

import java.util.List;
import javax.persistence.EntityManager;
import javax.servlet.http.HttpSession;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.User;

/**
 *
 * @author dinush
 */
public class SessionValues {
    
    public static List getNews(HttpSession session, User user) {
        System.out.println("class news get");
        EntityManager em = (EntityManager) session.getAttribute("entitymanager");
        if (em == null)
            return null;
        
        em.clear();
        Class2 class2 = user.getClass1();
        
        List classnews = em.createNamedQuery("Classnews.findByClass")
                .setParameter("class2", class2)
                .getResultList();
        return classnews;
    }
    
}
