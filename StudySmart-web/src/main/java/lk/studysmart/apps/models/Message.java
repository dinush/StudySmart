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
@Table(name = "message")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Message.findAll", query = "SELECT m FROM Message m ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findById", query = "SELECT m FROM Message m WHERE m.id = :id ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findBySeen", query = "SELECT m FROM Message m WHERE m.seen = :seen ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByTitle", query = "SELECT m FROM Message m WHERE m.title = :title ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByContent", query = "SELECT m FROM Message m WHERE m.content = :content ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByUrl", query = "SELECT m FROM Message m WHERE m.url = :url ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByTargetdate", query = "SELECT m FROM Message m WHERE m.targetdate = :targetdate ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByTargettime", query = "SELECT m FROM Message m WHERE m.targettime = :targettime ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByAddeddate", query = "SELECT m FROM Message m WHERE m.addeddate = :addeddate ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByAddedtime", query = "SELECT m FROM Message m WHERE m.addedtime = :addedtime ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByType", query = "SELECT m FROM Message m WHERE m.type = :type ORDER BY m.addeddate DESC ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByUserlevel", query = "SELECT m FROM Message m WHERE m.userlevel = :userlevel ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByGrade", query = "SELECT m FROM Message m WHERE m.grade = :grade ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByClass", query = "SELECT m FROM Message m WHERE m.class1 = :class2 ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByAddedUser", query = "SELECT m FROM Message m WHERE m.addeduser = :user ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByFourOrs", query = "SELECT m FROM Message m WHERE (m.targetuser = :user OR m.userlevel = :userlevel OR m.class1 = :class2 OR m.grade = :grade) AND (m.type <> 5) ORDER BY m.addeddate DESC, m.addedtime DESC"),
    @NamedQuery(name = "Message.findByTypeAndTargetUser", query = "SELECT m FROM Message m WHERE m.type = :type and m.targetuser = :user ORDER BY m.addeddate DESC, m.addedtime DESC")})
public class Message implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "seen")
    private boolean seen;
    @Size(max = 512)
    @Column(name = "title")
    private String title;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 5000)
    @Column(name = "content")
    private String content;
    @Size(max = 5000)
    @Column(name = "url")
    private String url;
    @Column(name = "targetdate")
    @Temporal(TemporalType.DATE)
    private Date targetdate;
    @Size(max = 50)
    @Column(name = "targettime")
    private String targettime;
    @Basic(optional = false)
    @NotNull
    @Column(name = "addeddate")
    @Temporal(TemporalType.DATE)
    private Date addeddate;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "addedtime")
    private String addedtime;
    @Basic(optional = false)
    @NotNull
    @Column(name = "type")
    private int type;
    @Column(name = "userlevel")
    private Integer userlevel;
    @Column(name = "grade")
    private Integer grade;
    @JoinColumn(name = "addeduser", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User addeduser;
    @JoinColumn(name = "class", referencedColumnName = "id")
    @ManyToOne
    private Class2 class1;
    @JoinColumn(name = "targetuser", referencedColumnName = "username")
    @ManyToOne
    private User targetuser;

    public Message() {
    }

    public Message(Integer id) {
        this.id = id;
    }

    public Message(Integer id, boolean seen, String content, Date addeddate, String addedtime, int type) {
        this.id = id;
        this.seen = seen;
        this.content = content;
        this.addeddate = addeddate;
        this.addedtime = addedtime;
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public boolean getSeen() {
        return seen;
    }

    public void setSeen(boolean seen) {
        this.seen = seen;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Date getTargetdate() {
        return targetdate;
    }

    public void setTargetdate(Date targetdate) {
        this.targetdate = targetdate;
    }

    public String getTargettime() {
        return targettime;
    }

    public void setTargettime(String targettime) {
        this.targettime = targettime;
    }

    public Date getAddeddate() {
        return addeddate;
    }

    public void setAddeddate(Date addeddate) {
        this.addeddate = addeddate;
    }

    public String getAddedtime() {
        return addedtime;
    }

    public void setAddedtime(String addedtime) {
        this.addedtime = addedtime;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Integer getUserlevel() {
        return userlevel;
    }

    public void setUserlevel(Integer userlevel) {
        this.userlevel = userlevel;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public User getAddeduser() {
        return addeduser;
    }

    public void setAddeduser(User addeduser) {
        this.addeduser = addeduser;
    }

    public Class2 getClass1() {
        return class1;
    }

    public void setClass1(Class2 class1) {
        this.class1 = class1;
    }

    public User getTargetuser() {
        return targetuser;
    }

    public void setTargetuser(User targetuser) {
        this.targetuser = targetuser;
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
        if (!(object instanceof Message)) {
            return false;
        }
        Message other = (Message) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Message[ id=" + id + " ]";
    }
    
}
