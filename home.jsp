<%-- 
    Document   : home
    Created on : Sep 17, 2017, 10:05:02 PM
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
        <title>Account Created</title>
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
            int t = 0, sid = 1 ;
            String name = request.getParameter("name");
            String department = request.getParameter("department");
            String designation = request.getParameter("designation");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("addr");
            String qualification = request.getParameter("qual");
            
            try
            {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs1 = st.executeQuery("select * from login_h");
            while ( rs1.next() )
            {
                if( username.equals(rs1.getString("uname")))
                {
                    %>
                    <div style="font-size: 18px; font-family: serif;" align="center">
                        Sign Up Unsuccessful<br>
                        <a href="signup.html">Click Here</a> To Retry
                    </div>
        <%
                    t = 1 ;
                }
            }
            ResultSet rs2 = st.executeQuery("select * from login_s");
            while ( rs2.next() )
            {
                if( username.equals(rs2.getString("uname")))
                {
                    %>
                    <div style="font-size: 18px; font-family: serif;" align="center">
                        Sign Up Unsuccessful<br>
                        <a href="signup.html">Click Here</a> To Retry
                    </div>
        <%
                    t = 1 ;
                }
                sid++ ;
            }
            int temp = 0 ;
            String sql = "insert into staff_r(sid,name,dept,desg,qual,email,addr,phone,uname,pwd,m_cnt,c_cnt) "
                    + "values("+sid+",'"+name+"','"+department+"','"+designation+"','"+qualification+"','"
                    +email+"','"+address+"',"+phone+",'"+username+"','"+password+"',30,30)";
            String sql2 = "insert into login_s values('"+username+"','"+password+"')";
            if ( t == 0 )
            {
                st.executeUpdate(sql);
                st.executeUpdate(sql2);
                t = 101 ;
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
            
            if ( t >= 100 )
            {
                %>
                <div style="font-size: 18px; font-family: serif;" align="center">
                    Your Account Has Been Created
                    <br>
                    Please Login Now!!!!
                    <br>
                    <a href="index.html"><button style="font-size: 18px;">Log In</button></a>
                </div>
        <%
            }
            %>
    </body>
</html>
