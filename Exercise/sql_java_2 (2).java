import java.util.*;
import java.sql.Timestamp;
import java.sql.*;


public class sql_java_2 {
    public static void main(String[] args) {

        String url = "jdbc:sqlserver://sqlserver.dmst.aueb.gr:1433;" +
                "databaseName=DB122;user=G5122;password=4gt34gg3;";
        Connection dbcon;
        Statement stmt;
        ResultSet Query;
        int price, ecode;
	    String pcode;
        int estcode;
        Timestamp   since;
        
        
        
        Scanner sc = new Scanner(System.in);
        try {
            // get input from user
            System.out.println("Type pcode");
            pcode = sc.nextLine();
        } catch (Exception e) {
            System.out.println("Please give me a valid pcode");
            sc.close();
            System.exit(0);
            pcode = null;
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

            Query = stmt.executeQuery(
                    "select since  , estcode , ecode,properties.pcode,price from estimation, properties  where estimation.pcode = properties.pcode  and estimation.pcode="
                            + pcode
                            + " order by since desc");
            
            while (Query.next()) {
                since = Query.getTimestamp("since");
		        estcode = Query.getInt("estcode");
                ecode = Query.getInt("ecode");
               	pcode = Query.getString("pcode");
                price = Query.getInt("price");
        	System.out.println(estcode+" "+price+" "+since+" "+ecode+" "+pcode);        

            }
            sc.close();
            Query.close();
            stmt.close();
            dbcon.close();
        } catch (SQLException e) {
            System.out.print("SQLException: ");
            System.out.println(e.getMessage());
        }

    }
}