/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Acer E-15
 */
@Entity
@Table(name = "forumposts")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Forumposts.findAll", query = "SELECT f FROM Forumposts f"),
    @NamedQuery(name = "Forumposts.findByClass1", query = "SELECT f FROM Forumposts f WHERE f.class1 = :class1"),
    @NamedQuery(name = "Forumposts.findBySubject", query = "SELECT f FROM Forumposts f WHERE f.subject = :subject"),
    @NamedQuery(name = "Forumposts.findByCatName", query = "SELECT f FROM Forumposts f WHERE f.catName = :catName"),
    @NamedQuery(name = "Forumposts.findByAddedBy", query = "SELECT f FROM Forumposts f WHERE f.addedBy = :addedBy"),
    @NamedQuery(name = "Forumposts.findByPost", query = "SELECT f FROM Forumposts f WHERE f.post = :post"),
    @NamedQuery(name = "Forumposts.findByDate", query = "SELECT f FROM Forumposts f WHERE f.date = :date"),
    @NamedQuery(name = "Forumposts.findByTime", query = "SELECT f FROM Forumposts f WHERE f.time = :time"),
    @NamedQuery(name = "Forumposts.findByClassSubjectLesson", query = "SELECT f FROM Forumposts f WHERE f.class1 = :class1 AND f.subject = :subject AND f.catName = :catName"),
    @NamedQuery(name = "Forumposts.findById", query = "SELECT f FROM Forumposts f WHERE f.id = :id")})
public class Forumposts implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 5)
    @Column(name = "class")
    private String class1;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "subject")
    private String subject;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "cat_name")
    private String catName;
    @Size(max = 50)
    @Column(name = "added_by")
    private String addedBy;
    @Size(max = 5000)
    @Column(name = "post")
    private String post;
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "time")
    private String time;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    public Forumposts() {
    }

    public Forumposts(Integer id) {
        this.id = id;
    }

    public Forumposts(Integer id, String class1, String subject, String catName, String time) {
        this.id = id;
        this.class1 = class1;
        this.subject = subject;
        this.catName = catName;
        this.time = time;
    }

    public String getClass1() {
        return class1;
    }

    public void setClass1(String class1) {
        this.class1 = class1;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(String addedBy) {
        this.addedBy = addedBy;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
        if (!(object instanceof Forumposts)) {
            return false;
        }
        Forumposts other = (Forumposts) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Forumposts[ id=" + id + " ]";
    }
    
}
