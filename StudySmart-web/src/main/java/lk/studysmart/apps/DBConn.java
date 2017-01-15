package lk.studysmart.apps;



import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConn 
{
    public Connection Connection()
    {
        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            String TechWorld3g_2 = "jdbc:mysql://localhost:3306/studysmart?user=root&password=123";
            Connection myConnection = DriverManager.getConnection(TechWorld3g_2);
            
            return myConnection;
        } catch (ClassNotFoundException | SQLException ex) {Logger.getLogger(DBConn.class.getName()).log(Level.SEVERE, null, ex);}
        return null;
    }
}
