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
import javax.persistence.Id;
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
@Entity
@Table(name = "test1")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Test1.findAll", query = "SELECT t FROM Test1 t"),
    @NamedQuery(name = "Test1.findByFname", query = "SELECT t FROM Test1 t WHERE t.fname = :fname"),
    @NamedQuery(name = "Test1.findBySname", query = "SELECT t FROM Test1 t WHERE t.sname = :sname")})
public class Test1 implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "fname")
    private String fname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "sname")
    private String sname;

    public Test1() {
    }

    public Test1(String fname) {
        this.fname = fname;
    }

    public Test1(String fname, String sname) {
        this.fname = fname;
        this.sname = sname;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (fname != null ? fname.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Test1)) {
            return false;
        }
        Test1 other = (Test1) object;
        if ((this.fname == null && other.fname != null) || (this.fname != null && !this.fname.equals(other.fname))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Test1[ fname=" + fname + " ]";
    }
    
}
