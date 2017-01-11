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
 * @author Kaveesh
 */
@Entity
@Table(name = "quiz")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Quiz.findAll", query = "SELECT q FROM Quiz q"),
    @NamedQuery(name = "Quiz.findByIdQuiz", query = "SELECT q FROM Quiz q WHERE q.idQuiz = :idQuiz"),
    @NamedQuery(name = "Quiz.findBySubject", query = "SELECT q FROM Quiz q WHERE q.subject = :subject"),
    @NamedQuery(name = "Quiz.findByQuestion", query = "SELECT q FROM Quiz q WHERE q.question = :question"),
    @NamedQuery(name = "Quiz.findByOption1", query = "SELECT q FROM Quiz q WHERE q.option1 = :option1"),
    @NamedQuery(name = "Quiz.findByOption2", query = "SELECT q FROM Quiz q WHERE q.option2 = :option2"),
    @NamedQuery(name = "Quiz.findByOption3", query = "SELECT q FROM Quiz q WHERE q.option3 = :option3"),
    @NamedQuery(name = "Quiz.findByOption4", query = "SELECT q FROM Quiz q WHERE q.option4 = :option4"),
    @NamedQuery(name = "Quiz.findByAnswers", query = "SELECT q FROM Quiz q WHERE q.answers = :answers"),
    @NamedQuery(name = "Quiz.findByGrade", query = "SELECT q FROM Quiz q WHERE q.grade = :grade")})
public class Quiz implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idQuiz")
    private Integer idQuiz;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Subject")
    private String subject;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 500)
    @Column(name = "question")
    private String question;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "option1")
    private String option1;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "option2")
    private String option2;
    @Size(max = 200)
    @Column(name = "option3")
    private String option3;
    @Size(max = 200)
    @Column(name = "option4")
    private String option4;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "answers")
    private String answers;
    @Basic(optional = false)
    @NotNull
    @Column(name = "grade")
    private int grade;
    @JoinColumn(name = "username", referencedColumnName = "username")
    @ManyToOne
    private User username;

    public Quiz() {
    }

    public Quiz(Integer idQuiz) {
        this.idQuiz = idQuiz;
    }

    public Quiz(Integer idQuiz, String subject, String question, String option1, String option2, String answers, int grade) {
        this.idQuiz = idQuiz;
        this.subject = subject;
        this.question = question;
        this.option1 = option1;
        this.option2 = option2;
        this.answers = answers;
        this.grade = grade;
    }

    public Integer getIdQuiz() {
        return idQuiz;
    }

    public void setIdQuiz(Integer idQuiz) {
        this.idQuiz = idQuiz;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getOption1() {
        return option1;
    }

    public void setOption1(String option1) {
        this.option1 = option1;
    }

    public String getOption2() {
        return option2;
    }

    public void setOption2(String option2) {
        this.option2 = option2;
    }

    public String getOption3() {
        return option3;
    }

    public void setOption3(String option3) {
        this.option3 = option3;
    }

    public String getOption4() {
        return option4;
    }

    public void setOption4(String option4) {
        this.option4 = option4;
    }

    public String getAnswers() {
        return answers;
    }

    public void setAnswers(String answers) {
        this.answers = answers;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public User getUsername() {
        return username;
    }

    public void setUsername(User username) {
        this.username = username;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idQuiz != null ? idQuiz.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Quiz)) {
            return false;
        }
        Quiz other = (Quiz) object;
        if ((this.idQuiz == null && other.idQuiz != null) || (this.idQuiz != null && !this.idQuiz.equals(other.idQuiz))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "lk.studysmart.apps.models.Quiz[ idQuiz=" + idQuiz + " ]";
    }
    
}
