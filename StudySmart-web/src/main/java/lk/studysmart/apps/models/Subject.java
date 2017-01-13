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
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "subject")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Subject.findAll", query = "SELECT s FROM Subject s"),
    @NamedQuery(name = "Subject.findByIdSubject", query = "SELECT s FROM Subject s WHERE s.idSubject = :idSubject"),
    @NamedQuery(name = "Subject.findByName", query = "SELECT s FROM Subject s WHERE s.name = :name"),
    @NamedQuery(name = "Subject.findByGrade", query = "SELECT s FROM Subject s WHERE s.grade = :grade")})
public class Subject implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "subject")
    private Collection<Internalresources> internalresourcesCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "subject")
    private Collection<Url> urlCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "subject")
    private Collection<Assignment> assignmentCollection;

    @OneToOne(cascade = CascadeType.ALL, mappedBy = "subject")
    private TermMarks termMarks;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "subject")
    private Collection<TermMarks> termMarksCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "subjectId")
    private Collection<TeacherTeaches> teacherTeachesCollection;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "idSubject")
    private String idSubject;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2)
    @Column(name = "grade")
    private int grade;

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }
    

    public Subject() {
    }

    public Subject(String idSubject) {
        this.idSubject = idSubject;
    }

    public Subject(String idSubject, String name) {
        this.idSubject = idSubject;
        this.name = name;
    }

    public String getIdSubject() {
        return idSubject;
    }

    public void setIdSubject(String idSubject) {
        this.idSubject = idSubject;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idSubject != null ? idSubject.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Subject)) {
            return false;
        }
        Subject other = (Subject) object;
        if ((this.idSubject == null && other.idSubject != null) || (this.idSubject != null && !this.idSubject.equals(other.idSubject))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Subject[ idSubject=" + idSubject + " ]";
    }

    @XmlTransient
    public Collection<TeacherTeaches> getTeacherTeachesCollection() {
        return teacherTeachesCollection;
    }

    public void setTeacherTeachesCollection(Collection<TeacherTeaches> teacherTeachesCollection) {
        this.teacherTeachesCollection = teacherTeachesCollection;
    }

    @XmlTransient
    public Collection<TermMarks> getTermMarksCollection() {
        return termMarksCollection;
    }

    public void setTermMarksCollection(Collection<TermMarks> termMarksCollection) {
        this.termMarksCollection = termMarksCollection;
    }

    public TermMarks getTermMarks() {
        return termMarks;
    }

    public void setTermMarks(TermMarks termMarks) {
        this.termMarks = termMarks;
    }

    @XmlTransient
    public Collection<Assignment> getAssignmentCollection() {
        return assignmentCollection;
    }

    public void setAssignmentCollection(Collection<Assignment> assignmentCollection) {
        this.assignmentCollection = assignmentCollection;
    }

    @XmlTransient
    public Collection<Url> getUrlCollection() {
        return urlCollection;
    }

    public void setUrlCollection(Collection<Url> urlCollection) {
        this.urlCollection = urlCollection;
    }

    @XmlTransient
    public Collection<Internalresources> getInternalresourcesCollection() {
        return internalresourcesCollection;
    }

    public void setInternalresourcesCollection(Collection<Internalresources> internalresourcesCollection) {
        this.internalresourcesCollection = internalresourcesCollection;
    }
    
}
