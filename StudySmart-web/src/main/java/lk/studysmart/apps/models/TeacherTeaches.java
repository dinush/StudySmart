/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "TeacherTeaches")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TeacherTeaches.findAll", query = "SELECT t FROM TeacherTeaches t"),
    @NamedQuery(name = "TeacherTeaches.findById", query = "SELECT t FROM TeacherTeaches t WHERE t.id = :id"),
    @NamedQuery(name = "TeacherTeaches.findByUser", query = "SELECT t FROM TeacherTeaches t WHERE t.userId = :user"),
    @NamedQuery(name = "TeacherTeaches.findByClass", query = "SELECT t FROM TeacherTeaches t WHERE t.class1 = :class2")})
public class TeacherTeaches implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @JoinColumn(name = "class", referencedColumnName = "id")
    @ManyToOne
    private Class2 class1;
    @JoinColumn(name = "subjectId", referencedColumnName = "idSubject")
    @ManyToOne(optional = false)
    private Subject subjectId;
    @JoinColumn(name = "userId", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User userId;

    public TeacherTeaches() {
    }

    public TeacherTeaches(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Class2 getClass1() {
        return class1;
    }

    public void setClass1(Class2 class1) {
        this.class1 = class1;
    }

    public Subject getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(Subject subjectId) {
        this.subjectId = subjectId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TeacherTeaches)) {
            return false;
        }
        TeacherTeaches other = (TeacherTeaches) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.TeacherTeaches[ id=" + id + " ]";
    }
    
}
