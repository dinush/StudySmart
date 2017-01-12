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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Kaveesh
 */
//Queries 
@Entity
@Table(name = "url")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Url.findAll", query = "SELECT u FROM Url u"),
    @NamedQuery(name = "Url.findByIdURL", query = "SELECT u FROM Url u WHERE u.idURL = :idURL"),
    @NamedQuery(name = "Url.findByGrade", query = "SELECT u FROM Url u WHERE u.grade = :grade"),
    @NamedQuery(name = "Url.findByTopic", query = "SELECT u FROM Url u WHERE u.topic = :topic"),
    @NamedQuery(name = "Url.findByUrl", query = "SELECT u FROM Url u WHERE u.url = :url"),
    @NamedQuery(name = "Url.findByGradeAndSubject", query = "SELECT u FROM Url u WHERE u.grade = :grade and u.subject = :subject")
})
public class Url implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idURL")
    private Integer idURL;
    @Basic(optional = false)
    @NotNull
    @Column(name = "grade")
    private int grade;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "topic")
    private String topic;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 300)
    @Column(name = "url")
    private String url;
    @JoinColumn(name = "subject", referencedColumnName = "idSubject")
    @ManyToOne(optional = false)
    private Subject subject;
    @JoinColumn(name = "username", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User username;

    public Url() {
    }

    public Url(Integer idURL) {
        this.idURL = idURL;
    }

    public Url(Integer idURL, int grade, String topic, String url) {
        this.idURL = idURL;
        this.grade = grade;
        this.topic = topic;
        this.url = url;
    }

    public Integer getIdURL() {
        return idURL;
    }

    public void setIdURL(Integer idURL) {
        this.idURL = idURL;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public User getUsername() {
        return username;
    }

    public void setUsername(User username) {
        this.username = username;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idURL != null ? idURL.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Url)) {
            return false;
        }
        Url other = (Url) object;
        if ((this.idURL == null && other.idURL != null) || (this.idURL != null && !this.idURL.equals(other.idURL))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Url[ idURL=" + idURL + " ]";
    }
    
}
