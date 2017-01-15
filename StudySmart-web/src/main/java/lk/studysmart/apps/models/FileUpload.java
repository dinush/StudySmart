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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "file_upload")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FileUpload.findAll", query = "SELECT f FROM FileUpload f")
    , @NamedQuery(name = "FileUpload.findById", query = "SELECT f FROM FileUpload f WHERE f.id = :id")
    , @NamedQuery(name = "FileUpload.findByFileName", query = "SELECT f FROM FileUpload f WHERE f.fileName = :fileName")
    , @NamedQuery(name = "FileUpload.findByUser", query = "SELECT f FROM FileUpload f WHERE f.uid = :user")})
public class FileUpload implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Size(max = 20)
    @Column(name = "file_name")
    private String fileName;
    @Lob
    @Column(name = "file")
    private byte[] file;
    @JoinColumn(name = "uid", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User uid;

    public FileUpload() {
    }

    public FileUpload(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public byte[] getFile() {
        return file;
    }

    public void setFile(byte[] file) {
        this.file = file;
    }

    public User getUid() {
        return uid;
    }

    public void setUid(User uid) {
        this.uid = uid;
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
        if (!(object instanceof FileUpload)) {
            return false;
        }
        FileUpload other = (FileUpload) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.FileUpload[ id=" + id + " ]";
    }
    
}
