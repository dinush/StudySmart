/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studysmart.apps.service.service;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import lk.studysmart.apps.models.Attendance;
import lk.studysmart.apps.models.AttendanceClass;
import lk.studysmart.apps.models.AttendanceClassPK;
import lk.studysmart.apps.models.AttendancePK;
import lk.studysmart.apps.models.Categories;
import lk.studysmart.apps.models.Class2;
import lk.studysmart.apps.models.Forumposts;
import lk.studysmart.apps.models.Message;
import lk.studysmart.apps.models.Quiz;
import lk.studysmart.apps.models.StudentParent;
import lk.studysmart.apps.models.StudentSubject;
import lk.studysmart.apps.models.Subject;
import lk.studysmart.apps.models.TeacherTeaches;
import lk.studysmart.apps.models.TermMarks;
import lk.studysmart.apps.models.Url;
import lk.studysmart.apps.models.User;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.Utils;

/**
 *
 * @author dinush
 */
@Stateless
@Path("rest")
public class RestServices {

    @PersistenceContext(unitName = "lk.studysmart_StudySmart-web_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    /**
     * Get students in a class and their attendance for today (if marked).
     *
     * @param classid
     * @param request
     * @return
     */
    @GET
    @Path("student/attendance/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getStudentsInClass(@PathParam("classid") Integer classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        Class2 class2 = em.find(Class2.class, classid);
        List<User> students = em.createNamedQuery("User.findByClass")
                .setParameter("class2", class2)
                .getResultList();
        JSONArray jarr = new JSONArray();
        Date date = Utils.getFormattedDate();
        AttendanceClassPK acpk = new AttendanceClassPK(class2.getId(), date);
        AttendanceClass ac = em.find(AttendanceClass.class, acpk);

        // First element of the array is the information about the previous marking
        JSONObject meta = new JSONObject();
        // Previous attendance marked person might be null.
        if (ac != null) {
            meta.put("marked_name", ac.getMarkedby().getName());
        } else {
            meta.put("marked_name", "n/a");
        }
        jarr.put(meta);
        // Put individual attendance into JSON Array
        for (User student : students) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", student.getUsername());
            jobj.put("name", student.getName());
            Boolean attended = false;
            AttendancePK apk = new AttendancePK(student.getUsername(), date);
            try {
                Attendance att = (Attendance) em.createNamedQuery("Attendance.findByUserAndDate")
                        .setParameter("attendancePk", apk)
                        .getSingleResult();
                attended = att.getAttended();
                jobj.put("controlled", false);  // Mark this as a recorded value. Do not controll by the UI.
            } catch (NoResultException e) {
                jobj.put("controlled", true);   // Controll this record in ui.
            }
            jobj.put("attended", attended);
            jarr.put(jobj);
        }

        return jarr.toString();
    }

    /**
     * Get attendance details of students in a class in a period of date.
     *
     * @param classid
     * @param from
     * @param to
     * @return
     */
    @GET
    @Path("student/attendance/{classid}/{from}/{to}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getClassStudentsAttendanceInAPeriod(@PathParam("classid") Integer classid, @PathParam("from") String from, @PathParam("to") String to, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        Class2 class2 = em.find(Class2.class, classid);

        // Get students in that class
        List<User> students = em.createNamedQuery("User.findByClassLevel")
                .setParameter("class2", class2)
                .setParameter("level", 3)
                .getResultList();

        JSONArray jarrContainer = new JSONArray();

        // Get individual attendance details
        for (User student : students) {
            try {
                List<Attendance> lstAtten = em.createNamedQuery("Attendance.findByUserAndDateRange")
                        .setParameter("username", student.getUsername())
                        .setParameter("from", Utils.getFormattedDate(from))
                        .setParameter("to", Utils.getFormattedDate(to))
                        .getResultList();

                JSONObject jobjStudent = new JSONObject();
                jobjStudent.put("username", student.getUsername());
                jobjStudent.put("name", student.getName());

                // Put attendance details day-by-day to JSON.
                JSONArray jarrAtts = new JSONArray();
                for (Attendance att : lstAtten) {
                    JSONObject jobjAtt = new JSONObject();
                    jobjAtt.put("date", att.getAttendancePK().getDate());
                    jobjAtt.put("attended", att.getAttended());
                    jobjAtt.put("markedbyusername", att.getMarkedBy().getUsername());
                    jobjAtt.put("markedbyname", att.getMarkedBy().getName());

                    jarrAtts.put(jobjAtt);
                }

                // Put all attendance details into student details JSON object.
                jobjStudent.put("attendance", jarrAtts);

                // Put single complete into main array.
                jarrContainer.put(jobjStudent);
            } catch (ParseException ex) {
                Logger.getLogger(RestServices.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            }
        }

        return jarrContainer.toString();
    }

    /**
     * Get students in a specific classroom AND enrolled for the given subject.
     * (Also returns marks for the term tests)
     *
     * @param classid
     * @param subjectid
     * @param request
     * @return
     */
    @GET
    @Path("student/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getStudentsByClassAndSubject(@PathParam("classid") Integer classid, @PathParam("subjectid") String subjectid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        Subject subject = em.find(Subject.class, subjectid);
        Class2 class2 = em.find(Class2.class, classid);

        JSONObject jobjRoot = new JSONObject();
        JSONArray jarray = new JSONArray();

        List<StudentSubject> studentSubjects = em.createNamedQuery("StudentSubject.findBySubject")
                .setParameter("subject", subject)
                .getResultList();

        DecimalFormat numberFormat = new DecimalFormat("#.0000");   // Format to limit to 4 floating point values
        List[] stat_marks = {new ArrayList(), new ArrayList(), new ArrayList()}; // To calculate mean and standard deviation
        int[] stat_total = {0, 0, 0};
        int[] max = {0, 0, 0};
        int[] min = {100, 100, 100};
        for (StudentSubject ss : studentSubjects) {
            User user = ss.getUserId();
            if (user.getClass1() != null && !user.getClass1().equals(class2)) {
                continue;
            }

            JSONObject jobj = new JSONObject();
            jobj.put("username", ss.getUserId().getUsername());
            jobj.put("name", ss.getUserId().getName());
            jobj.put("subject", ss.getSubjectId().getIdSubject());

            /**
             * Get extra student details *** EXPERIMENTAL ***
             */
            // Get term test marks (for all 3 terms)
            List<TermMarks> termMarks = em.createNamedQuery("TermMarks.findByUserSubject")
                    .setParameter("username", ss.getUserId())
                    .setParameter("subject", subject)
                    .getResultList();
            JSONArray jarrTerms = new JSONArray();
            for (int i = 0; i < termMarks.size(); i++) {
                int marks = termMarks.get(i).getValue();
                stat_marks[i].add(marks);
                stat_total[i] += marks;
                JSONObject jobjTerm = new JSONObject();
                jobjTerm.put("term", termMarks.get(i).getTerm());
                jobjTerm.put("marks", marks);
                jobjTerm.put("marker_username", termMarks.get(i).getMarkedby().getUsername());
                jobjTerm.put("marker_name", termMarks.get(i).getMarkedby().getName());
                jarrTerms.put(jobjTerm);
            }
            jobj.put("term_marks", jarrTerms);

            /**
             * End of extra student details
             */
            jarray.put(jobj);
        }
        jobjRoot.put("raw", jarray);

        // Calculate 3 means and standard deviations
        JSONArray jarrStat = new JSONArray();
        for (int j = 0; j < 3; j++) {
            int n = stat_marks[j].size();
            if (n == 0) {
                continue;
            }
            double mean = stat_total[j] / (double) n;

            // Calculating standard deviation
            double deviation = 0;
            for (int k = 0; k < n; k++) {
                int stat_mark = (int) stat_marks[j].get(k);
                deviation += Math.pow(stat_mark - mean, 2);
                if (max[j] < stat_mark) // In search of maximum marks for this term
                {
                    max[j] = stat_mark;
                }
                if (min[j] > stat_mark) // In search of minimum marks for this term
                {
                    min[j] = stat_mark;
                }
            }
            double std_dev = Math.sqrt(deviation / n);

            // JSON structure
            JSONObject jobjStat = new JSONObject();
            jobjStat.put("term", j + 1);
            jobjStat.put("mean", numberFormat.format(mean));
            jobjStat.put("standard_deviation", numberFormat.format(std_dev));
            jobjStat.put("max", max[j]);
            jobjStat.put("min", min[j]);
            jarrStat.put(jobjStat);
        }
        jobjRoot.put("stats", jarrStat);

        return jobjRoot.toString();
    }

    /**
     * Get the subjects which are taught by the teacher and for the specific
     * classroom.
     *
     * @param teacherid
     * @param classid
     * @param request
     * @return
     */
    @GET
    @Path("teacher/{teacherid}/subjects/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTeachingSubjectsByClass(@PathParam("teacherid") String teacherid, @PathParam("classid") Integer classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        User teacher = em.find(User.class, teacherid);
        Class2 class2 = em.find(Class2.class, classid);
        List<TeacherTeaches> teaching = em.createNamedQuery("TeacherTeaches.findByUserClass")
                .setParameter("user", teacher)
                .setParameter("class2", class2)
                .getResultList();

        JSONArray jarray = new JSONArray();

        for (TeacherTeaches teaches : teaching) {
            Subject subject = teaches.getSubjectId();
            JSONObject jobj = new JSONObject();
            jobj.put("id", subject.getIdSubject());
            jobj.put("name", subject.getName());
            jarray.put(jobj);
        }
        return jarray.toString();
    }
    
    /**
     * Get the subjects taught by a teacher
     * @param teacherid
     * @param request
     * @return 
     */
    @GET
    @Path("teacher/{teacherid}/subjects")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSubjectsTaughtByATeacher(
            @PathParam("teacherid") String teacherid,
            @Context HttpServletRequest request
    ) 
    {
        User teacher = em.find(User.class, teacherid);
        
        List<TeacherTeaches> teaches = em.createNamedQuery("TeacherTeaches.findByUser")
                .setParameter("user", teacher)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        for (int i=0; i < teaches.size(); i++) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", teaches.get(i).getSubjectId().getIdSubject());
            jobj.put("name", teaches.get(i).getSubjectId().getName());
            jobj.put("grade", teaches.get(i).getSubjectId().getGrade());
            
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }

    /**
     * Get Classes taught by a teacher
     *
     * @param teacherid
     * @param request
     * @return
     */
    @GET
    @Path("teacher/{teacherid}/classes")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTeacherSubjects(@PathParam("teacherid") String teacherid, @Context HttpServletRequest request) {
        User teacher = em.find(User.class, teacherid);
        List<TeacherTeaches> tch_clss = em.createNamedQuery("TeacherTeaches.findByUser")
                .setParameter("user", teacher)
                .getResultList();

        JSONArray jarr = new JSONArray();

        for (TeacherTeaches tt : tch_clss) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", tt.getClass1().getId());
            jobj.put("name", "Grade " + tt.getClass1().getGrade() + " " + tt.getClass1().getSubclass());
            jarr.put(jobj);
        }

        return jarr.toString();
    }
    
    @GET
    @Path("subjects/student/{studentid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSubjectsByStudent(
            @PathParam("studentid") String studentid,
            @Context HttpServletRequest request
    ) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        
        User student = em.find(User.class, studentid);
        
        List<StudentSubject> studentSubjects = em.createNamedQuery("StudentSubject.findByUser")
                .setParameter("user", student)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        for (StudentSubject stu_sub : studentSubjects) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", stu_sub.getSubjectId().getIdSubject());
            jobj.put("name", stu_sub.getSubjectId().getName());
            jobj.put("grade", stu_sub.getSubjectId().getGrade());
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }

    /**
     * Get subject which are related to the given class
     *
     * @param classid
     * @param request
     * @return
     */
    @GET
    @Path("subjects/{classid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getSubjectsBelongsToClass(@PathParam("classid") Integer classid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        Class2 class2 = em.find(Class2.class, classid);

        List<Subject> subjects = em.createNamedQuery("Subject.findByGrade")
                .setParameter("grade", class2.getGrade())
                .getResultList();

        JSONArray jarray = new JSONArray();

        for (Subject subject : subjects) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", subject.getIdSubject());
            jobj.put("name", subject.getName());
            jarray.put(jobj);
        }
        return jarray.toString();
    }

    /**
     * Get all the classes
     *
     * @param request
     * @return
     */
    @GET
    @Path("classes")
    @Produces(MediaType.APPLICATION_JSON)
    public String getClasses(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        List<Class2> classes = em.createNamedQuery("Class.findAll")
                .getResultList();

        JSONArray jarray = new JSONArray();

        for (Class2 class2 : classes) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", class2.getId());
            jobj.put("name", class2.getGrade() + " " + class2.getSubclass());
            jarray.put(jobj);
        }

        return jarray.toString();
    }

    /**
     * Get classes by grade.
     *
     * @param grade
     * @param request
     * @return
     */
    @GET
    @Path("classes/{grade}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getClassesByGrade(@PathParam("grade") Integer grade, @Context HttpServletRequest request) {
        List<Class2> classes = em.createNamedQuery("Class.findByGrade")
                .setParameter("grade", grade)
                .getResultList();

        JSONArray jarr = new JSONArray();
        for (Class2 class2 : classes) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", class2.getId());
            jobj.put("grade", class2.getGrade());
            jobj.put("subclass", class2.getSubclass());
            jarr.put(jobj);
        }

        return jarr.toString();
    }

    /**
     * Get all the students
     *
     * @param request
     * @return
     */
    @GET
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    public String getParentlessStudents(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        List<User> students = em.createNamedQuery("User.findByLevel")
                .setParameter("level", 3)
                .getResultList();

        JSONArray jarray = new JSONArray();

        for (User student : students) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", student.getUsername());
            jobj.put("name", student.getName());
            jarray.put(jobj);
        }

        return jarray.toString();
    }

    /**
     * Get attendance between date period and specific user
     *
     * @param studentid
     * @param from
     * @param to
     * @param request
     * @return
     */
    @GET
    @Path("attendance/{studentid}/{from}/{to}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAttendanceByUseridDate(@PathParam("studentid") String studentid, @PathParam("from") String from, @PathParam("to") String to, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        // Dates are URI encoded.
        from = from.replace("%", "/");
        to = to.replace("%2F", "/");

        // Format the dates
        Date dFrom, dTo;
        try {
            dFrom = Utils.getFormattedDate(from);
            dTo = Utils.getFormattedDate(to);
        } catch (ParseException ex) {
            Logger.getLogger(RestServices.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

        // Query from the database
        List<Attendance> att_datas = em.createNamedQuery("Attendance.findByUserAndDateRange")
                .setParameter("username", studentid)
                .setParameter("from", dFrom)
                .setParameter("to", dTo)
                .getResultList();

        JSONArray jarray = new JSONArray();
        // Make individual objects into JSON objects
        for (Attendance att : att_datas) {
            JSONObject jobj = new JSONObject();
            jobj.put("date", Utils.getFormattedDateString(att.getAttendancePK().getDate()));
            jobj.put("attended", att.getAttended());
            jobj.put("markedby", att.getMarkedBy().getName());
            jobj.put("markedbyid", att.getMarkedBy().getUsername());

            jarray.put(jobj);
        }

        return jarray.toString();
    }

    /**
     * Get students belong to specific parent
     *
     * @param parentid
     * @param request
     * @return
     */
    @GET
    @Path("parent/{parentid}/students")
    @Produces(MediaType.APPLICATION_JSON)
    public String getStudentsBelongToParent(@PathParam("parentid") String parentid, @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        User parent = em.find(User.class, parentid);

        List<StudentParent> spl = em.createNamedQuery("StudentParent.findByParentId")
                .setParameter("parent", parent)
                .getResultList();

        JSONArray jarr = new JSONArray();
        // Make JSON objects
        for (StudentParent sp : spl) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", sp.getStudentid().getUsername());
            jobj.put("name", sp.getStudentid().getName());
            jarr.put(jobj);
        }

        return jarr.toString();
    }

    /**
     * Get Term test marks by term AND class AND subject
     *
     * @param term
     * @param classid
     * @param subjectid
     * @param request
     * @return
     */
    @GET
    @Path("termmarks/all/{term}/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTermmarksByTermClassSubject(
            @PathParam("term") Integer term,
            @PathParam("classid") Integer classid,
            @PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request) {

        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        Class2 class2 = em.find(Class2.class, classid);
        Subject subject = em.find(Subject.class, subjectid);

        // get all the students in the class
        List<User> students = em.createNamedQuery("User.findByClassLevel")
                .setParameter("class2", class2)
                .setParameter("level", 3)
                .getResultList();

        // Get students who has enrolled for the specific subject
        List<User> enrolls = em.createNamedQuery("StudentSubject.findBySubjectGetUser")
                .setParameter("subject", subject)
                .getResultList();

        JSONArray jarr = new JSONArray();
        // filter students who has entrolled  for the specific subject
        for (User st : students) {
            if (!enrolls.contains(st)) {
                continue;
            }

            JSONObject jobj = new JSONObject();
            jobj.put("studentid", st.getUsername());
            jobj.put("studentname", st.getName());

            // If marks exists, add them
            List<TermMarks> marks = em.createNamedQuery("TermMarks.findByAll")
                    .setParameter("student", st)
                    .setParameter("class2", class2)
                    .setParameter("subject", subject)
                    .setParameter("term", term)
                    .getResultList();
            if (!marks.isEmpty()) {
                jobj.put("marks", marks.get(0).getValue());
                jobj.put("markedbyid", marks.get(0).getMarkedby().getUsername());
                jobj.put("markedbyname", marks.get(0).getMarkedby().getName());
            }

            jarr.put(jobj);
        }

        return jarr.toString();
    }

    /**
     * Get all the messages related to the user.
     *
     * @param request
     * @return
     */
    @GET
    @Path("messages")
    @Produces(MediaType.APPLICATION_JSON)
    public String getClassNews(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        User user = (User) request.getSession().getAttribute("user");
        Class2 class2 = user.getClass1();
        // Prevent user from getting unwanted messages.
        if (class2 == null) {
            // build an impossible class ;)
            class2 = new Class2();
            class2.setGrade(-1);
            class2.setSubclass("zz");
        }

        List<Message> msgs = em.createNamedQuery("Message.findByFourOrs")
                .setParameter("user", user)
                .setParameter("userlevel", user.getLevel())
                .setParameter("class2", class2)
                .setParameter("grade", class2.getGrade())
                .getResultList();

        JSONArray jarr = Utils.msgsToJsonArray(msgs, null);

        // For teachers, Messages for the classes they teach are also added.
        if (user.getLevel() == 2) {
            List<TeacherTeaches> teachings = em.createNamedQuery("TeacherTeaches.findByUser")
                    .setParameter("user", user)
                    .getResultList();

            List<Integer> teachingGrades = new ArrayList<>();
            List<Class2> teachingClasses = new ArrayList<>();
            for (TeacherTeaches teaching : teachings) {
                Class2 clz = teaching.getClass1();
                if (teachingClasses.contains(clz)) {
                    continue;
                }
                teachingClasses.add(clz);

                if (teachingGrades.contains(clz.getGrade())) {
                    continue;
                }
                teachingGrades.add(clz.getGrade());
            }

            for (Integer teachingGrade : teachingGrades) {
                List<Message> msgs2 = em.createNamedQuery("Message.findByGrade")
                        .setParameter("grade", teachingGrade)
                        .getResultList();

                jarr = Utils.msgsToJsonArray(msgs2, jarr);
            }

            for (Class2 teachingClass : teachingClasses) {
                List<Message> msgs3 = em.createNamedQuery("Message.findByClass")
                        .setParameter("class2", teachingClass)
                        .getResultList();

                jarr = Utils.msgsToJsonArray(msgs3, jarr);
            }

        }

        return jarr.toString();
    }

    @GET
    @Path("messages/private")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Message> getPrivateMsgs(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return null;
        }

        List<Message> msgs = em.createNamedQuery("Message.findByTypeAndTargetUser")
                .setParameter("type", 1)
                .setParameter("user", request.getSession().getAttribute("user"))
                .getResultList();

        return msgs;
    }

    @GET
    @Path("messages/public")
    @Produces(MediaType.APPLICATION_JSON)
    public String getPublicMessages(@Context HttpServletRequest request) {
        List<Message> publicMsgs = em.createNamedQuery("Message.findByType")
                .setParameter("type", 5)
                .getResultList();

        return Utils.msgsToJsonArray(publicMsgs, null).toString();
    }
    
    @DELETE
    @Path("deletemsgs/{msgid}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deleteMessages(@PathParam("msgid") Integer msgid,
            @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }else{
            Message m = em.find(Message.class, msgid);
            
            em.remove(m);
            return "deleted";
        }
        
    }
    
    /**
     * Get all subjects
     *
     * @param request
     * @return
     */
    @GET
    @Path("subjects/all")
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllSubjects(@Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }

        List<Subject> subjects = em.createNamedQuery("Subject.findAll").getResultList();
        JSONArray jarr = new JSONArray();
        for (Subject subject : subjects) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", subject.getIdSubject());
            jobj.put("name", subject.getName());
            jobj.put("grade", subject.getGrade());
            jarr.put(jobj);
        }

        return jarr.toString();
    }

    /**
     * Get threads created by a teacher
     */
    @GET
    @Path("teacherthreads/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getThreads(
            @PathParam("classid") String classid,
            @PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request
    ) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }
        User user = (User) request.getSession().getAttribute("user");
        if (user.getLevel() == 2){
            List<Categories> categories = em.createNamedQuery("Categories.findByTeacher")
                    .setParameter("catBy", user.getUsername())
                    .setParameter("class1", classid)
                    .setParameter("subject", subjectid)
                    .getResultList();

            JSONArray jarr = new JSONArray();

            for (Categories category : categories) {
                JSONObject jobj = new JSONObject();
                jobj.put("catname", category.getCatName());
                jobj.put("catdescription", category.getCatDescription());
                jobj.put("catid", category.getCatId());
                jobj.put("catdate", utils.Utils.getFormattedDateString(category.getCatDate()));
                jarr.put(jobj);
            }

            return jarr.toString();
        }
        else{
            List<Categories> categories = em.createNamedQuery("Categories.findByClass1")
                    .setParameter("class1", classid)
                    .getResultList();
            
            JSONArray jarr = new JSONArray();

            for (Categories category : categories) {
                Subject subject = em.find(Subject.class, category.getSubject());
                JSONObject jobj = new JSONObject();
                jobj.put("catsubject", category.getSubject());
                jobj.put("subject_name", subject.getName());
                jobj.put("catname", category.getCatName());
                jobj.put("catdescription", category.getCatDescription());
                jobj.put("catdate", utils.Utils.getFormattedDateString(category.getCatDate()));
                jobj.put("catid", category.getCatId());
                jobj.put("catby", category.getCatBy());
                jarr.put(jobj);
            }

            return jarr.toString();
            
        }
    }

    /* Get the discussion thread by class, subject, lesson */
    @GET
    @Path("forum/{lessonid}/{classid}/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDiscussion(@PathParam("lessonid") String lessonid,
            @PathParam("classid") String classid,
            @PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        } else {
            List<Forumposts> forumPosts = em.createNamedQuery("Forumposts.findByClassSubjectLesson")
                    .setParameter("catName", lessonid)
                    .setParameter("class1", classid)
                    .setParameter("subject", subjectid)
                    .getResultList();

            JSONArray jarr = new JSONArray();

            for (Forumposts forumpost : forumPosts) {
                User addedUser = em.find(User.class, forumpost.getAddedBy());
                JSONObject jobj = new JSONObject();
                jobj.put("postaddedby", forumpost.getAddedBy());
                jobj.put("postaddedby_name", addedUser.getName());
                jobj.put("post", forumpost.getPost());
                jobj.put("postdate", utils.Utils.getFormattedDateString(forumpost.getDate()));
                jobj.put("posttime", forumpost.getTime());
                jobj.put("postid", forumpost.getId());
                jarr.put(jobj);
            }

            return jarr.toString();
        }

    }
    
    @DELETE
    @Path("forumdeletepost/{postid}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deletepost(@PathParam("postid") Integer postid,
            @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }else{
            Forumposts forumPosts = em.find(Forumposts.class, postid);
            
            em.remove(forumPosts);
            return "deleted";
        }
        
    }
    
    @DELETE
    @Path("forumdeletethread/{threadid}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deletethread(@PathParam("threadid") Integer threadid,
            @Context HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return "Not authorized";
        }else{
            Categories category = em.find(Categories.class, threadid);
            
            em.remove(category);
            return "deleted";
        }
        
    }
    
        
    @GET
    @Path("questions/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getQuestions(@PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request){
        User student = (User) request.getSession().getAttribute("user");
        Subject subject = em.find(Subject.class, subjectid);
        List<Quiz> quizes = em.createNamedQuery("Quiz.findBySubject")
                .setParameter("subject", subject)
                .getResultList();
        
        JSONArray jarr = new JSONArray();
        for (Quiz quiz : quizes) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", quiz.getIdQuiz());
            jobj.put("subject_id", quiz.getSubject().getIdSubject());
            jobj.put("subject_name", quiz.getSubject().getName());
            jobj.put("question", quiz.getQuestion());
            jobj.put("option1", quiz.getOption1());
            jobj.put("option2", quiz.getOption2());
            jobj.put("option3", quiz.getOption3());
            jobj.put("option4", quiz.getOption4());
            jobj.put("answer", quiz.getAnswers());
            jobj.put("user_username", quiz.getUsername() != null ? quiz.getUsername().getUsername() : null);
            jobj.put("user_name", quiz.getUsername() != null ? quiz.getUsername().getName() : null);
            jarr.put(jobj);
        }
        
        return jarr.toString();
    }
    
    @GET
    @Path("resources/{subjectid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getResources(@PathParam("subjectid") String subjectid,
            @Context HttpServletRequest request){
        User student = (User) request.getSession().getAttribute("user");
        Subject subject = em.find(Subject.class, subjectid);
        List<Url> urls = em.createNamedQuery("Url.findByGradeAndSubject")
                .setParameter("subject", subject)
                .setParameter("grade",student.getClass1().getGrade())
                .getResultList();
        
        JSONArray jsonArray = new JSONArray();
        for (int i=0 ; i < urls.size(); i++) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("subject", urls.get(i).getSubject().getName());
            jsonObject.put("id", urls.get(i).getIdURL());
            jsonObject.put("topic", urls.get(i).getTopic());
            jsonObject.put("url", urls.get(i).getUrl());
            
            jsonArray.put(jsonObject);
        }
        
        return jsonArray.toString();
    }
}
    
    

