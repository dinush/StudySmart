/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "Marks")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Marks.findAll", query = "SELECT m FROM Marks m"),
    @NamedQuery(name = "Marks.findByUsername", query = "SELECT m FROM Marks m WHERE m.marksPK.username = :username"),
    @NamedQuery(name = "Marks.findByIdSubject", query = "SELECT m FROM Marks m WHERE m.marksPK.idSubject = :idSubject"),
    @NamedQuery(name = "Marks.findByTerm", query = "SELECT m FROM Marks m WHERE m.marksPK.term = :term"),
    @NamedQuery(name = "Marks.findByMarks", query = "SELECT m FROM Marks m WHERE m.marks = :marks")})
public class Marks implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected MarksPK marksPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "marks")
    private int marks;

    public Marks() {
    }

    public Marks(MarksPK marksPK) {
        this.marksPK = marksPK;
    }

    public Marks(MarksPK marksPK, int marks) {
        this.marksPK = marksPK;
        this.marks = marks;
    }

    public Marks(String username, String idSubject, int term) {
        this.marksPK = new MarksPK(username, idSubject, term);
    }

    public MarksPK getMarksPK() {
        return marksPK;
    }

    public void setMarksPK(MarksPK marksPK) {
        this.marksPK = marksPK;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (marksPK != null ? marksPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Marks)) {
            return false;
        }
        Marks other = (Marks) object;
        if ((this.marksPK == null && other.marksPK != null) || (this.marksPK != null && !this.marksPK.equals(other.marksPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Marks[ marksPK=" + marksPK + " ]";
    }
    
}
