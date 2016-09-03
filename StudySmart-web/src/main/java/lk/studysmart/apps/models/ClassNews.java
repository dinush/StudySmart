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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
 * @author dinush
 */
@Entity
@Table(name = "ClassNews")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ClassNews.findAll", query = "SELECT c FROM ClassNews c"),
    @NamedQuery(name = "ClassNews.findById", query = "SELECT c FROM ClassNews c WHERE c.id = :id"),
    @NamedQuery(name = "ClassNews.findByTitle", query = "SELECT c FROM ClassNews c WHERE c.title = :title"),
    @NamedQuery(name = "ClassNews.findByMessage", query = "SELECT c FROM ClassNews c WHERE c.message = :message"),
    @NamedQuery(name = "ClassNews.findByDate", query = "SELECT c FROM ClassNews c WHERE c.date = :date"),
    @NamedQuery(name = "ClassNews.findByTime", query = "SELECT c FROM ClassNews c WHERE c.time = :time"),
    @NamedQuery(name = "ClassNews.findByAddeddate", query = "SELECT c FROM ClassNews c WHERE c.addeddate = :addeddate"),
    @NamedQuery(name = "ClassNews.findByAddedtime", query = "SELECT c FROM ClassNews c WHERE c.addedtime = :addedtime")})
public class ClassNews implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "title")
    private String title;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "message")
    private String message;
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Column(name = "time")
    @Temporal(TemporalType.TIME)
    private Date time;
    @Column(name = "addeddate")
    @Temporal(TemporalType.DATE)
    private Date addeddate;
    @Column(name = "addedtime")
    @Temporal(TemporalType.TIME)
    private Date addedtime;
    @JoinColumn(name = "addedby", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User addedby;
    @JoinColumn(name = "class", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Class2 class1;

    public ClassNews() {
    }

    public ClassNews(Integer id) {
        this.id = id;
    }

    public ClassNews(Integer id, String title, String message) {
        this.id = id;
        this.title = title;
        this.message = message;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Date getAddeddate() {
        return addeddate;
    }

    public void setAddeddate(Date addeddate) {
        this.addeddate = addeddate;
    }

    public Date getAddedtime() {
        return addedtime;
    }

    public void setAddedtime(Date addedtime) {
        this.addedtime = addedtime;
    }

    public User getAddedby() {
        return addedby;
    }

    public void setAddedby(User addedby) {
        this.addedby = addedby;
    }

    public Class2 getClass1() {
        return class1;
    }

    public void setClass1(Class2 class1) {
        this.class1 = class1;
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
        if (!(object instanceof ClassNews)) {
            return false;
        }
        ClassNews other = (ClassNews) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.ClassNews[ id=" + id + " ]";
    }
    
}
