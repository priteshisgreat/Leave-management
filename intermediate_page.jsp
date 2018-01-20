<%-- 
    Document   : intermediate_page
    Created on : Sep 17, 2017, 10:13:54 PM
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
        <title>Intermediate Page</title>
        <style>
            .size_header {
                font-size: 35px;
            }
        </style>
    </head>
    <body style="background: #FAFAFA">
        <div style="width: 1400px;">
        <div class="size_header" style="position: absolute;">
            Leave Management
        </div>
        </div>
        <br><br><hr style="border-color: #696969;">
        <%
            int t = 0 ;
            String username = request.getParameter("uname");
            String password = request.getParameter("pwd");
            try
            {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select uname,pwd from login_h");
            while ( rs.next() )
            {
                if( username.equals(rs.getString("uname")))
                {
                    if( password.equals(rs.getString("pwd")))
                    {
                        response.sendRedirect("hod_page.jsp");
                        t = 1 ;
                    }
                }
            }
            
            ResultSet rs2 = st.executeQuery("select * from login_s");
            ResultSet id ;
            while ( rs2.next() )
            {
                if( username.equals(rs2.getString("uname")))
                {
                    if( password.equals(rs2.getString("pwd")))
                    {
                        HttpSession sess = request.getSession(true) ;
                        sess.setAttribute("username", username);
                        response.sendRedirect("staff_page.jsp");
                        t = 2 ;
                    }
                }
            }
            }
            catch(Exception e)
            {
                %>
                <div style="font-size: 18px; font-family: serif;" align="center">
                    Exception Found
                    <%=t %>
                </div>
        <%
            }
            if ( t == 0 )
            {
                %>
                <div style="font-size: 18px; font-family: serif;" align="center">
                    Login Failed<br>
                    Try Again <a href="index.html">Click Here</a>
                </div>
        <%
            }
            %>
    </body>
</html>
