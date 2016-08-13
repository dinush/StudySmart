/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author dinush
 */
@Embeddable
public class MarksPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "username")
    private String username;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "idSubject")
    private String idSubject;
    @Basic(optional = false)
    @NotNull
    @Column(name = "term")
    private int term;

    public MarksPK() {
    }

    public MarksPK(String username, String idSubject, int term) {
        this.username = username;
        this.idSubject = idSubject;
        this.term = term;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIdSubject() {
        return idSubject;
    }

    public void setIdSubject(String idSubject) {
        this.idSubject = idSubject;
    }

    public int getTerm() {
        return term;
    }

    public void setTerm(int term) {
        this.term = term;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (username != null ? username.hashCode() : 0);
        hash += (idSubject != null ? idSubject.hashCode() : 0);
        hash += (int) term;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MarksPK)) {
            return false;
        }
        MarksPK other = (MarksPK) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        if ((this.idSubject == null && other.idSubject != null) || (this.idSubject != null && !this.idSubject.equals(other.idSubject))) {
            return false;
        }
        if (this.term != other.term) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.MarksPK[ username=" + username + ", idSubject=" + idSubject + ", term=" + term + " ]";
    }
    
}
