/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "Attendance")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Attendance.findAll", query = "SELECT a FROM Attendance a"),
    @NamedQuery(name = "Attendance.findByUsername", query = "SELECT a FROM Attendance a WHERE a.attendancePK.username = :username"),
    @NamedQuery(name = "Attendance.findByDate", query = "SELECT a FROM Attendance a WHERE a.attendancePK.date = :date"),
    @NamedQuery(name = "Attendance.findByAttended", query = "SELECT a FROM Attendance a WHERE a.attended = :attended"),
    @NamedQuery(name = "Attendance.findByUserAndDate", query = "SELECT a FROM Attendance a WHERE a.attendancePK = :attendancePk"),
    @NamedQuery(name = "Attendance.findByUserAndDateRange", query = "SELECT a FROM Attendance a WHERE a.attendancePK.username = :username AND a.attendancePK.date BETWEEN :from AND :to")})
public class Attendance implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected AttendancePK attendancePK;
    @Column(name = "attended")
    private Boolean attended;
    @JoinColumn(name = "markedBy", referencedColumnName = "username")
    @ManyToOne
    private User markedBy;
    @JoinColumn(name = "username", referencedColumnName = "username", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;

    public Attendance() {
    }

    public Attendance(AttendancePK attendancePK) {
        this.attendancePK = attendancePK;
    }

    public Attendance(String username, Date date) {
        this.attendancePK = new AttendancePK(username, date);
    }

    public AttendancePK getAttendancePK() {
        return attendancePK;
    }

    public void setAttendancePK(AttendancePK attendancePK) {
        this.attendancePK = attendancePK;
    }

    public Boolean getAttended() {
        return attended;
    }

    public void setAttended(Boolean attended) {
        this.attended = attended;
    }

    public User getMarkedBy() {
        return markedBy;
    }

    public void setMarkedBy(User markedBy) {
        this.markedBy = markedBy;
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
        hash += (attendancePK != null ? attendancePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Attendance)) {
            return false;
        }
        Attendance other = (Attendance) object;
        if ((this.attendancePK == null && other.attendancePK != null) || (this.attendancePK != null && !this.attendancePK.equals(other.attendancePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Attendance[ attendancePK=" + attendancePK + " ]";
    }
    
}
