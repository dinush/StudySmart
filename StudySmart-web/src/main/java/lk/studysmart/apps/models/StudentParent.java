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
import lk.studysmart.apps.models.User;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "Student_Parent")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "StudentParent.findAll", query = "SELECT s FROM StudentParent s"),
    @NamedQuery(name = "StudentParent.findById", query = "SELECT s FROM StudentParent s WHERE s.id = :id"),
    @NamedQuery(name = "StudentParent.findByStudentId", query = "SELECT s FROM StudentParent s WHERE s.studentid = :student"),
    @NamedQuery(name = "StudentParent.findByParentId", query = "SELECT s FROM StudentParent s WHERE s.parentid = :parent")})
public class StudentParent implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "_id")
    private Integer id;
    @JoinColumn(name = "parentid", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User parentid;
    @JoinColumn(name = "studentid", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User studentid;

    public StudentParent() {
    }

    public StudentParent(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getParentid() {
        return parentid;
    }

    public void setParentid(User parentid) {
        this.parentid = parentid;
    }

    public User getStudentid() {
        return studentid;
    }

    public void setStudentid(User studentid) {
        this.studentid = studentid;
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
        if (!(object instanceof StudentParent)) {
            return false;
        }
        StudentParent other = (StudentParent) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.service.service.StudentParent[ id=" + id + " ]";
    }
    
}
