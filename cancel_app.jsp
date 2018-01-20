<%-- 
    Document   : cancel_app
    Created on : Sep 27, 2017, 6:25:36 PM
    Author     : DELL
--%>

<%@page import="com.mysql.jdbc.CommunicationsException" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cancel Application</title>
    </head>
    <body>
        <%
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root","kaushal08");
            Statement st = con.createStatement();
            int sid = 0 ;
            HttpSession sess = request.getSession();
            String username = (String) sess.getAttribute("username") ;
            ResultSet rs = st.executeQuery("select * from staff_r where uname='"+username+"'");
            if ( rs != null )
            {
                while ( rs.next() )
                {
                    sid = rs.getInt("sid");
                }
            }
            String sql1 = "delete from app_leave where sid="+sid;
            st.executeUpdate(sql1);
            response.sendRedirect("staff_page.jsp");
        }
        catch ( Exception e )
        {
            out.print("Exception Found");
        }
        %>
    </body>
</html>
