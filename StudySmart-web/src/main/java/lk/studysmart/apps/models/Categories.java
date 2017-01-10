/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Acer E-15
 */
@Entity
@Table(name = "categories")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Categories.findAll", query = "SELECT c FROM Categories c"),
    @NamedQuery(name = "Categories.findByCatId", query = "SELECT c FROM Categories c WHERE c.catId = :catId"),
    @NamedQuery(name = "Categories.findByCatName", query = "SELECT c FROM Categories c WHERE c.catName = :catName"),
    @NamedQuery(name = "Categories.findByCatDescription", query = "SELECT c FROM Categories c WHERE c.catDescription = :catDescription"),
    @NamedQuery(name = "Categories.findByCatBy", query = "SELECT c FROM Categories c WHERE c.catBy = :catBy"),
    @NamedQuery(name = "Categories.findByTeacher", query = "SELECT c FROM Categories c WHERE c.catBy = :catBy AND c.class1 = :class1 AND c.subject = :subject"),
    @NamedQuery(name = "Categories.findByClass1", query = "SELECT c FROM Categories c WHERE c.class1 = :class1"),
    @NamedQuery(name = "Categories.findBySubject", query = "SELECT c FROM Categories c WHERE c.subject = :subject"),
    @NamedQuery(name = "Categories.findByCatDate", query = "SELECT c FROM Categories c WHERE c.catDate = :catDate")})
public class Categories implements Serializable {

    @OneToMany(mappedBy = "catid")
    private Collection<Forumposts> forumpostsCollection;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "cat_id")
    private Integer catId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "cat_name")
    private String catName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "cat_description")
    private String catDescription;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 8)
    @Column(name = "cat_by")
    private String catBy;
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
    @Column(name = "cat_date")
    @Temporal(TemporalType.DATE)
    private Date catDate;

    public Categories() {
    }

    public Categories(Integer catId) {
        this.catId = catId;
    }

    public Categories(Integer catId, String catName, String catDescription, String catBy, String class1, String subject) {
        this.catId = catId;
        this.catName = catName;
        this.catDescription = catDescription;
        this.catBy = catBy;
        this.class1 = class1;
        this.subject = subject;
    }

    public Integer getCatId() {
        return catId;
    }

    public void setCatId(Integer catId) {
        this.catId = catId;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getCatDescription() {
        return catDescription;
    }

    public void setCatDescription(String catDescription) {
        this.catDescription = catDescription;
    }

    public String getCatBy() {
        return catBy;
    }

    public void setCatBy(String catBy) {
        this.catBy = catBy;
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

    public Date getCatDate() {
        return catDate;
    }

    public void setCatDate(Date catDate) {
        this.catDate = catDate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (catId != null ? catId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Categories)) {
            return false;
        }
        Categories other = (Categories) object;
        if ((this.catId == null && other.catId != null) || (this.catId != null && !this.catId.equals(other.catId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Categories[ catId=" + catId + " ]";
    }

    @XmlTransient
    public Collection<Forumposts> getForumpostsCollection() {
        return forumpostsCollection;
    }

    public void setForumpostsCollection(Collection<Forumposts> forumpostsCollection) {
        this.forumpostsCollection = forumpostsCollection;
    }
    
}
