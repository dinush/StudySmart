/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "Assignment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assignment.findAll", query = "SELECT a FROM Assignment a"),
    @NamedQuery(name = "Assignment.findById", query = "SELECT a FROM Assignment a WHERE a.id = :id"),
    @NamedQuery(name = "Assignment.findByName", query = "SELECT a FROM Assignment a WHERE a.name = :name"),
    @NamedQuery(name = "Assignment.findByMax", query = "SELECT a FROM Assignment a WHERE a.max = :max")})
public class Assignment implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "name")
    private int name;
    @Basic(optional = false)
    @NotNull
    @Column(name = "max")
    private int max;
    @JoinColumn(name = "class", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Class2 class1;
    @JoinColumn(name = "subject", referencedColumnName = "idSubject")
    @ManyToOne(optional = false)
    private Subject subject;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "assignment")
    private Collection<AssignmentMarks> assignmentMarksCollection;

    public Assignment() {
    }

    public Assignment(Integer id) {
        this.id = id;
    }

    public Assignment(Integer id, int name, int max) {
        this.id = id;
        this.name = name;
        this.max = max;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getName() {
        return name;
    }

    public void setName(int name) {
        this.name = name;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public Class2 getClass1() {
        return class1;
    }

    public void setClass1(Class2 class1) {
        this.class1 = class1;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    @XmlTransient
    public Collection<AssignmentMarks> getAssignmentMarksCollection() {
        return assignmentMarksCollection;
    }

    public void setAssignmentMarksCollection(Collection<AssignmentMarks> assignmentMarksCollection) {
        this.assignmentMarksCollection = assignmentMarksCollection;
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
        if (!(object instanceof Assignment)) {
            return false;
        }
        Assignment other = (Assignment) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Assignment[ id=" + id + " ]";
    }
    
}
