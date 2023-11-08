<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
        PreparedStatement ost;
        ResultSet ors;
                %>
              <%
                   try {
                  String username = request.getParameter("logemail");
                  String password = request.getParameter("logpassword");
                  DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
                  oconn = (OracleConnection)DriverManager.getConnection("jdbc:oracle:thin:@Asus-Vivobook-14:1521:orcl","inmate","project");
                  String p = "select * from userdetails where email = ? and password = ?";
                  ost = (PreparedStatement) oconn.prepareStatement(p);
                  
                        ost.setString(1,username);
                        ost.setString(2,password);
                  
                   ors = ost.executeQuery();
                    
                        if (ors.next()){
                            response.sendRedirect("http://localhost:8080/PG_NEW/homepage.html");
                        } else {
                            response.sendRedirect("http://localhost:8080/PG_NEW/loginerror.html");
                        }
                        oconn.close();
                   } catch (SQLException ex){out.println(ex.getMessage().toString());}
              %>
    </body>
</html>