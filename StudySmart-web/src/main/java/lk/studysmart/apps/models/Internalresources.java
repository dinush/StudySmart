/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

 Created Model according to the table internal resources

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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "internalresources")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Internalresources.findAll", query = "SELECT i FROM Internalresources i")
    , @NamedQuery(name = "Internalresources.findById", query = "SELECT i FROM Internalresources i WHERE i.id = :id")
    , @NamedQuery(name = "Internalresources.findByFilename", query = "SELECT i FROM Internalresources i WHERE i.filename = :filename")
    , @NamedQuery(name = "Internalresources.findBySubject", query = "SELECT i FROM Internalresources i WHERE i.subject = :subject")
    , @NamedQuery(name = "Internalresources.findByDescription", query = "SELECT i FROM Internalresources i WHERE i.description = :description")})
public class Internalresources implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "filename")
    private String filename;
    @Size(max = 250)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "filecontent")
    private byte[] blob;
    @JoinColumn(name = "subject", referencedColumnName = "idSubject")
    @ManyToOne(optional = false)
    private Subject subject;
    @JoinColumn(name = "user", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User user;

    public Internalresources() {
    }

    public Internalresources(Integer id) {
        this.id = id;
    }

    public Internalresources(Integer id, String filename, byte[] blob) {
        this.id = id;
        this.filename = filename;
        this.blob = blob;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte[] getBlob() {
        return blob;
    }

    public void setBlob(byte[] blob) {
        this.blob = blob;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
        if (!(object instanceof Internalresources)) {
            return false;
        }
        Internalresources other = (Internalresources) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Internalresources[ id=" + id + " ]";
    }
    
}
