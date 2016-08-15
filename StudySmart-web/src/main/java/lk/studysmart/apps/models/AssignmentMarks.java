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
@Table(name = "AssignmentMarks")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AssignmentMarks.findAll", query = "SELECT a FROM AssignmentMarks a"),
    @NamedQuery(name = "AssignmentMarks.findByUsername", query = "SELECT a FROM AssignmentMarks a WHERE a.assignmentMarksPK.username = :username"),
    @NamedQuery(name = "AssignmentMarks.findByIdSubject", query = "SELECT a FROM AssignmentMarks a WHERE a.assignmentMarksPK.idSubject = :idSubject"),
    @NamedQuery(name = "AssignmentMarks.findByAssignment", query = "SELECT a FROM AssignmentMarks a WHERE a.assignmentMarksPK.assignment = :assignment"),
    @NamedQuery(name = "AssignmentMarks.findByMarks", query = "SELECT a FROM AssignmentMarks a WHERE a.marks = :marks")})
public class AssignmentMarks implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected AssignmentMarksPK assignmentMarksPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "marks")
    private int marks;

    public AssignmentMarks() {
    }

    public AssignmentMarks(AssignmentMarksPK assignmentMarksPK) {
        this.assignmentMarksPK = assignmentMarksPK;
    }

    public AssignmentMarks(AssignmentMarksPK assignmentMarksPK, int marks) {
        this.assignmentMarksPK = assignmentMarksPK;
        this.marks = marks;
    }

    public AssignmentMarks(String username, String idSubject, String assignment) {
        this.assignmentMarksPK = new AssignmentMarksPK(username, idSubject, assignment);
    }

    public AssignmentMarksPK getAssignmentMarksPK() {
        return assignmentMarksPK;
    }

    public void setAssignmentMarksPK(AssignmentMarksPK assignmentMarksPK) {
        this.assignmentMarksPK = assignmentMarksPK;
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
        hash += (assignmentMarksPK != null ? assignmentMarksPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AssignmentMarks)) {
            return false;
        }
        AssignmentMarks other = (AssignmentMarks) object;
        if ((this.assignmentMarksPK == null && other.assignmentMarksPK != null) || (this.assignmentMarksPK != null && !this.assignmentMarksPK.equals(other.assignmentMarksPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.AssignmentMarks[ assignmentMarksPK=" + assignmentMarksPK + " ]";
    }
    
}
