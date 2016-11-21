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
 * @author dinush
 */
@Entity
@Table(name = "AssignmentMarks")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AssignmentMarks.findAll", query = "SELECT a FROM AssignmentMarks a"),
    @NamedQuery(name = "AssignmentMarks.findById", query = "SELECT a FROM AssignmentMarks a WHERE a.id = :id"),
    @NamedQuery(name = "AssignmentMarks.findByMark", query = "SELECT a FROM AssignmentMarks a WHERE a.mark = :mark"),
    @NamedQuery(name = "AssignmentMarks.findByComment", query = "SELECT a FROM AssignmentMarks a WHERE a.comment = :comment"),
    @NamedQuery(name = "AssignmentMarks.findByAssignment", query = "SELECT a FROM AssignmentMarks a WHERE a.assignment = :assignment"),
    @NamedQuery(name = "AssignmentMarks.findByStudent", query = "SELECT a FROM AssignmentMarks a WHERE a.student = :student")})
public class AssignmentMarks implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "mark")
    private int mark;
    @Column(name = "comment")
    private String comment;
    @JoinColumn(name = "addedby", referencedColumnName = "username")
    @ManyToOne
    private User addedby;
    @JoinColumn(name = "assignment", referencedColumnName = "name")
    @ManyToOne(optional = false)
    private Assignment assignment;
    @JoinColumn(name = "student", referencedColumnName = "username")
    @ManyToOne(optional = false)
    private User student;

    public AssignmentMarks() {
    }

    public AssignmentMarks(Integer id) {
        this.id = id;
    }

    public AssignmentMarks(Integer id, int mark, String comment) {
        this.id = id;
        this.mark = mark;
        this.comment = comment;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public User getAddedby() {
        return addedby;
    }

    public void setAddedby(User addedby) {
        this.addedby = addedby;
    }

    public Assignment getAssignment() {
        return assignment;
    }

    public void setAssignment(Assignment assignment) {
        this.assignment = assignment;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
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
        if (!(object instanceof AssignmentMarks)) {
            return false;
        }
        AssignmentMarks other = (AssignmentMarks) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.AssignmentMarks[ id=" + id + " ]";
    }
    
}
