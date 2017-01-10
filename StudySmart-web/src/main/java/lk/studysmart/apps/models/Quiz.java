/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.models;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.PersistenceUnit;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dinush
 */
@Entity
@Table(name = "quiz")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Quiz.findById", query = "SELECT q FROM Quiz q WHERE q.teacher = :teacher")
})
public class Quiz implements Serializable {

    @PersistenceUnit(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "idQuiz")
    private Integer id;
    @Column(name = "question")
    private String question;
    @Column(name = "option1")
    private String option1;
    @Column(name = "option2")
    private String option2;
    @Column(name = "option3")
    private String option3;
    @Column(name = "option4")
    private String option4;
    @Column(name = "answers")
    private String answers;
    @Column(name = "username")
    private String teacher;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
        if (!(object instanceof Quiz)) {
            return false;
        }
        Quiz other = (Quiz) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Quiz[ id=" + id + " ]";
    }
    
}
