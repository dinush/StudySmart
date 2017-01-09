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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "termmarks")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TermMarks.findAll", query = "SELECT t FROM TermMarks t ORDER BY t.term"),
    @NamedQuery(name = "TermMarks.findById", query = "SELECT t FROM TermMarks t WHERE t.id = :id ORDER BY t.term"),
    @NamedQuery(name = "TermMarks.findByTerm", query = "SELECT t FROM TermMarks t WHERE t.term = :term ORDER BY t.term"),
    @NamedQuery(name = "TermMarks.findByValue", query = "SELECT t FROM TermMarks t WHERE t.value = :value ORDER BY t.term"),
    @NamedQuery(name = "TermMarks.findByTermClassSubject", query = "SELECT t FROM TermMarks t WHERE t.term = :term AND t.class1 = :class2 AND t.subject = :subject ORDER BY t.term"),
    @NamedQuery(name = "TermMarks.findByUserSubject", query = "SELECT t FROM TermMarks t WHERE t.student = :username AND t.subject = :subject ORDER BY t.term"),
    @NamedQuery(name = "TermMarks.findByAll", query = "SELECT t FROM TermMarks t WHERE t.student = :student AND t.class1 = :class2 AND t.subject = :subject AND t.term = :term ORDER BY t.term")})
public class TermMarks implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "term")
    private int term;
    @Basic(optional = false)
    @NotNull
    @Column(name = "value")
    private int value;
    @JoinColumn(name = "class", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Class2 class1;
    @JoinColumn(name = "markedby", referencedColumnName = "username")
    @OneToOne
    private User markedby;
    @JoinColumn(name = "student", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User student;
    @JoinColumn(name = "subject", referencedColumnName = "idSubject")
    @OneToOne(optional = false)
    private Subject subject;

    public TermMarks() {
    }

    public TermMarks(Integer id) {
        this.id = id;
    }

    public TermMarks(Integer id, int term, int value) {
        this.id = id;
        this.term = term;
        this.value = value;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getTerm() {
        return term;
    }

    public void setTerm(int term) {
        this.term = term;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public Class2 getClass1() {
        return class1;
    }

    public void setClass1(Class2 class1) {
        this.class1 = class1;
    }

    public User getMarkedby() {
        return markedby;
    }

    public void setMarkedby(User markedby) {
        this.markedby = markedby;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
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
        if (!(object instanceof TermMarks)) {
            return false;
        }
        TermMarks other = (TermMarks) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.TermMarks[ id=" + id + " ]";
    }
    
}
