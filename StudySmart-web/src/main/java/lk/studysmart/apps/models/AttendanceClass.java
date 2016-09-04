/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import java.util.Date;
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
@Table(name = "AttendanceClass")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AttendanceClass.findAll", query = "SELECT a FROM AttendanceClass a"),
    @NamedQuery(name = "AttendanceClass.findByClass1", query = "SELECT a FROM AttendanceClass a WHERE a.attendanceClassPK.class1 = :class1"),
    @NamedQuery(name = "AttendanceClass.findByDate", query = "SELECT a FROM AttendanceClass a WHERE a.attendanceClassPK.date = :date")})
public class AttendanceClass implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected AttendanceClassPK attendanceClassPK;
    @JoinColumn(name = "class", referencedColumnName = "id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Class2 class2;
    @JoinColumn(name = "markedby", referencedColumnName = "username")
    @ManyToOne
    private User markedby;

    public AttendanceClass() {
    }

    public AttendanceClass(AttendanceClassPK attendanceClassPK) {
        this.attendanceClassPK = attendanceClassPK;
    }

    public AttendanceClass(int class1, Date date) {
        this.attendanceClassPK = new AttendanceClassPK(class1, date);
    }

    public AttendanceClassPK getAttendanceClassPK() {
        return attendanceClassPK;
    }

    public void setAttendanceClassPK(AttendanceClassPK attendanceClassPK) {
        this.attendanceClassPK = attendanceClassPK;
    }

    public Class2 getClass2() {
        return class2;
    }

    public void setClass2(Class2 class2) {
        this.class2 = class2;
    }

    public User getMarkedby() {
        return markedby;
    }

    public void setMarkedby(User markedby) {
        this.markedby = markedby;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (attendanceClassPK != null ? attendanceClassPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AttendanceClass)) {
            return false;
        }
        AttendanceClass other = (AttendanceClass) object;
        if ((this.attendanceClassPK == null && other.attendanceClassPK != null) || (this.attendanceClassPK != null && !this.attendanceClassPK.equals(other.attendanceClassPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.AttendanceClass[ attendanceClassPK=" + attendanceClassPK + " ]";
    }
    
}
