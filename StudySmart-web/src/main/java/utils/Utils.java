/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.BufferedReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import lk.studysmart.apps.StudentManager;
import lk.studysmart.apps.models.Message;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author dinush
 */
public class Utils {
    
    public static String getFormattedTime() {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.format(cal.getTime());
    }

    public static Date getFormattedDate(String d) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        return dateFormat.parse(d);
    }
    
    public static Date getFormattedDate() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date = null;
        try {
            date = dateFormat.parse(dateFormat.format(new Date()));
        } catch (ParseException ex) {
            Logger.getLogger(StudentManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return date;
    }
    
    public static String getFormattedDateString(Date d) {
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
        return format.format(d);
    }
    
    public static Date stringToDate(String sdate) throws ParseException {
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
        return format.parse(sdate);
    }

    public static boolean entityValidator(Object entity) {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<Object>> constraintViolations = validator.validate(entity);
        if (constraintViolations.size() > 0) {
            Iterator<ConstraintViolation<Object>> iterator = constraintViolations.iterator();
            while (iterator.hasNext()) {
                ConstraintViolation<Object> cv = iterator.next();
                System.out.println(cv.getRootBeanClass().getName() + "." + cv.getPropertyPath() + " " + cv.getMessage());

//                JsfUtil.addErrorMessage(cv.getRootBeanClass().getSimpleName() + "." + cv.getPropertyPath() + " " + cv.getMessage());
            }
            return false;
        }
        return true;
    }
    
    /**
     * Convert <Message> to <JSONArray>
     * @param msgs
     * @param jarr
     * @return 
     */
    public static JSONArray msgsToJsonArray(List<Message> msgs, JSONArray jarr) {
        if(jarr == null)
            jarr = new JSONArray();
        for (Message msg : msgs) {
            JSONObject jobj = new JSONObject();
            jobj.put("id", msg.getId());
            jobj.put("seen", msg.getSeen());
            jobj.put("title", msg.getTitle());
            jobj.put("content", msg.getContent());
            if(msg.getTargetdate() != null)
                jobj.put("target_date", Utils.getFormattedDateString(msg.getTargetdate()));
            jobj.put("target_time", msg.getTargettime());
            jobj.put("added_user_id", msg.getAddeduser().getUsername());
            jobj.put("added_user_name", msg.getAddeduser().getName());
            jobj.put("added_date", Utils.getFormattedDateString(msg.getAddeddate()));
            jobj.put("added_time", msg.getAddedtime());
            if (msg.getUrl() != null) {
                jobj.put("url", msg.getUrl());
            }
            jobj.put("type", msg.getType());

            jarr.put(jobj);
        }
        return jarr;
    }
    
    public static String bufferedToString(BufferedReader buffered) {
        StringBuilder buf = new StringBuilder();
        String line;
        try {
            while ((line = buffered.readLine()) != null) {
                buf.append(line);
            }
        } catch (Exception e) {
            // error
            return null;
        }
        return buf.toString();
    }
}
