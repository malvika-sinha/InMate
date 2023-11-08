<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="oracle.jdbc.OraclePreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="oracle.jdbc.OracleResultSet"%>
<%@page import="oracle.jdbc.OracleStatement"%>
<%@page import="oracle.jdbc.OracleConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Continue</title>
    </head>
    <body>
               <%!
         OracleConnection oconn;
        OracleStatement ost;
        OraclePreparedStatement ost1;
        OracleResultSet ors;
                %>
                
            <%
                try {
            String mail = request.getParameter("remail");
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            oconn = (OracleConnection) DriverManager.getConnection("jdbc:oracle:thin:@Asus-Vivobook-14:1521:orcl","inmate","project");
            ost = (OracleStatement) oconn.createStatement();
            String q = "select * from userdetails where email = '"+mail+"'";
            ors = (OracleResultSet)ost.executeQuery(q);
                int count = 0;
                while (ors.next()){
                    count++;
                }
                if (count > 0){
                    response.sendRedirect("http://localhost:8080/PG_NEW/registrationerror.html");
                } else {
                    String name = request.getParameter("rname");
                    String email = request.getParameter("remail");
                    String password = request.getParameter("rpass");
                        String p = "INSERT INTO USERDETAILS(NAME,EMAIL,PASSWORD) values(?,?,?)";
                        ost1 =(OraclePreparedStatement) oconn.prepareStatement(p);
                
                        ost1.setString(1,name);
                        ost1.setString(2,email);
                        ost1.setString(3,password);
                
                        ost1.executeUpdate();
                    response.sendRedirect("http://localhost:8080/PG_NEW/registrationsuccess.html");
                }
                oconn.close();
              } catch (SQLException ex){out.println(ex.getMessage().toString());}
            %>
    </body>
</html>
