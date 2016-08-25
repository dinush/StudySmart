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
@Table(name = "classnews")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Classnews.findAll", query = "SELECT c FROM Classnews c"),
    @NamedQuery(name = "Classnews.findById", query = "SELECT c FROM Classnews c WHERE c.id = :id"),
    @NamedQuery(name = "Classnews.findByTitle", query = "SELECT c FROM Classnews c WHERE c.title = :title"),
    @NamedQuery(name = "Classnews.findByMessage", query = "SELECT c FROM Classnews c WHERE c.message = :message"),
    @NamedQuery(name = "Classnews.findByDate", query = "SELECT c FROM Classnews c WHERE c.date = :date"),
    @NamedQuery(name = "Classnews.findByTime", query = "SELECT c FROM Classnews c WHERE c.time = :time"),
    @NamedQuery(name = "Classnews.findByClass", query = "SELECT c FROM Classnews c WHERE c.class1 = :class2")})
public class Classnews implements Serializable {

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
    @JoinColumn(name = "addedby", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User addedby;
    @JoinColumn(name = "class", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Class2 class1;

    public Classnews() {
    }

    public Classnews(Integer id) {
        this.id = id;
    }

    public Classnews(Integer id, String title, String message) {
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
        if (!(object instanceof Classnews)) {
            return false;
        }
        Classnews other = (Classnews) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Classnews[ id=" + id + " ]";
    }
    
}
