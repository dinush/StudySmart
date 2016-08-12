/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import lk.studysmart.apps.models.StudentParent;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "User")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "User.count", query = "SELECT COUNT(u) FROM User u"),
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
    @NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username"),
    @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email = :email"),
    @NamedQuery(name = "User.findByGradeAndLevel", query = "SELECT u FROM User u WHERE u.grade = :grade AND u.level = :level")
})
public class User implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "parentid")
    private Collection<StudentParent> studentParentCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "studentid")
    private Collection<StudentParent> studentParentCollection1;

    @Basic(optional = false)
    @NotNull
    @Column(name = "level")
    private int level;
    @JoinTable(name = "Child_Parent", joinColumns = {
        @JoinColumn(name = "studentid", referencedColumnName = "username")}, inverseJoinColumns = {
        @JoinColumn(name = "parentid", referencedColumnName = "username")})
    @ManyToMany
    private Collection<User> userCollection;
    @ManyToMany(mappedBy = "userCollection")
    private Collection<User> userCollection1;
    
    @PersistenceUnit(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "username")
    private String username;
    @Column(name = "password")
    private String password;
    @Column(name = "email")
    private String email;
    @Column(name = "name")
    private String name;
    @Column(name = "grade")
    private Integer grade;    
    @Column(name = "subject")
    private String subject;

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (username != null ? username.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof User)) {
            return false;
        }
        User other = (User) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.User[ id=" + username + " ]";
    }

    public User() {
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    @XmlTransient
    public Collection<User> getUserCollection() {
        return userCollection;
    }

    public void setUserCollection(Collection<User> userCollection) {
        this.userCollection = userCollection;
    }

    @XmlTransient
    public Collection<User> getUserCollection1() {
        return userCollection1;
    }

    public void setUserCollection1(Collection<User> userCollection1) {
        this.userCollection1 = userCollection1;
    }

    @XmlTransient
    public Collection<StudentParent> getStudentParentCollection() {
        return studentParentCollection;
    }

    public void setStudentParentCollection(Collection<StudentParent> studentParentCollection) {
        this.studentParentCollection = studentParentCollection;
    }

    @XmlTransient
    public Collection<StudentParent> getStudentParentCollection1() {
        return studentParentCollection1;
    }

    public void setStudentParentCollection1(Collection<StudentParent> studentParentCollection1) {
        this.studentParentCollection1 = studentParentCollection1;
    }
    
}
