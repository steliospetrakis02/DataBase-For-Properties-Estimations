import java.io.*;
import java.text.*;
import java.util.*;

import java.sql.*;

public class sql_java {
    public static void main(String[] args) {

        String url = "jdbc:sqlserver://sqlserver.dmst.aueb.gr:1433;" +
                "databaseName=DB122;user=G5122;password=4gt34gg3;";
        Connection dbcon;
        Statement stmt;
        int ecode;
        Scanner sc = new Scanner(System.in);
        try {
  	   // gets input from user
            System.out.println("Type ecode");
            ecode = sc.nextInt();
        } catch (Exception e) {
            System.out.println("Please give me a valid ecode");
	    System.exit(0);
            ecode = 0;
        }

      

        /* declare ODBC conectivity */
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (java.lang.ClassNotFoundException e) {
            System.out.print("ClassNotFoundException: ");
            System.out.println(e.getMessage());
        }
        /* execute SQL statements */
        try {
            dbcon = DriverManager.getConnection(url);
            stmt = dbcon.createStatement();

            // Delete everything with user input ecode
            String del1 = "DELETE connections WHERE connections.ecode=" + ecode + ";";
            String del2 = "DELETE estimation WHERE estimation.ecode=" + ecode + ";";
            String del3 = "DELETE estimator WHERE estimator.ecode=" + ecode + ";";
            stmt.executeUpdate(del1);
            stmt.executeUpdate(del2);
            stmt.executeUpdate(del3);

            stmt.close();
            dbcon.close();
        } catch (SQLException e) {
            System.out.print("SQLException: ");
            System.out.println(e.getMessage());
        }

    }
}
