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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
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
@Table(name = "class")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Class.findAll", query = "SELECT c FROM Class2 c"),
    @NamedQuery(name = "Class.findById", query = "SELECT c FROM Class2 c WHERE c.id = :id"),
    @NamedQuery(name = "Class.findByGrade", query = "SELECT c FROM Class2 c WHERE c.grade = :grade"),
    @NamedQuery(name = "Class.findBySubclass", query = "SELECT c FROM Class2 c WHERE c.subclass = :subclass"),
    @NamedQuery(name = "Class.findByGradeAndSubclass", query = "SELECT c FROM Class2 c WHERE c.grade = :grade AND c.subclass = :subclass")})

public class Class2 implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "class2")
    private Collection<AttendanceClass> attendanceClassCollection;

    @OneToMany(mappedBy = "class1")
    private Collection<Message> messageCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "class1")
    private Collection<Assignment> assignmentCollection;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "class1")
    private Collection<TermMarks> termMarksCollection;

    @OneToMany(mappedBy = "class1")
    private Collection<TeacherTeaches> teacherTeachesCollection;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "grade")
    private int grade;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1)
    @Column(name = "subclass")
    private String subclass;
    @OneToMany(mappedBy = "class1")
    private Collection<User> userCollection;

    public Class2() {
    }

    public Class2(Integer id) {
        this.id = id;
    }

    public Class2(Integer id, int grade, String subclass) {
        this.id = id;
        this.grade = grade;
        this.subclass = subclass;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getSubclass() {
        return subclass;
    }

    public void setSubclass(String subclass) {
        this.subclass = subclass;
    }

    @XmlTransient
    public Collection<User> getUserCollection() {
        return userCollection;
    }

    public void setUserCollection(Collection<User> userCollection) {
        this.userCollection = userCollection;
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
        if (!(object instanceof Class2)) {
            return false;
        }
        Class2 other = (Class2) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Class[ id=" + id + " ]";
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

    @XmlTransient
    public Collection<Assignment> getAssignmentCollection() {
        return assignmentCollection;
    }

    public void setAssignmentCollection(Collection<Assignment> assignmentCollection) {
        this.assignmentCollection = assignmentCollection;
    }

    @XmlTransient
    public Collection<Message> getMessageCollection() {
        return messageCollection;
    }

    public void setMessageCollection(Collection<Message> messageCollection) {
        this.messageCollection = messageCollection;
    }

    @XmlTransient
    public Collection<AttendanceClass> getAttendanceClassCollection() {
        return attendanceClassCollection;
    }

    public void setAttendanceClassCollection(Collection<AttendanceClass> attendanceClassCollection) {
        this.attendanceClassCollection = attendanceClassCollection;
    }
    
}
