<%-- 
    Document   : next_staff
    Created on : Sep 17, 2017, 9:14:33 PM
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
        <title>Finally Submit Application</title>
        <style>
            .size_header {
                font-size: 35px;
            }
            td {
                padding-left: 10px;
                padding-bottom: 5px;
                font-family: serif;
                font-size: 18px;
            }
            .buttons {
                padding-left: 100px;
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
            int sid = Integer.parseInt(request.getParameter("staff_id")) ;
            String name = request.getParameter("name");
            String designation = request.getParameter("desg");
            Date dt = Date.valueOf(request.getParameter("leave_to"));
            Date df = Date.valueOf(request.getParameter("leave_from"));
            String cat = request.getParameter("category");
            String alt_s = request.getParameter("alt_staff");
            String reason = request.getParameter("application");
            
            try
            {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from app_leave") ;
            if ( rs != null )
            {
                while ( rs.next() )
                {
                    if ( sid == rs.getInt("sid"))
                    {
                        t = 1 ;
                    }
                }
            }
            if ( t == 0 )
            {
                String sql2 = "insert into app_leave(sid,name,date_f,date_t,cat,reas,alt_s) values("+sid+",'"+name+"','"
                            +df+"','"+dt+"','"+cat+"','"+reason+"','"+alt_s+"')" ;
                st.executeUpdate(sql2);
                %>
            <br>
            <div align="center">
                <table>
                    <tr>
                        <td>
                            <a href="application_edit.jsp">
                                <button style="font-size: 18px;">Edit</button>
                            </a>
                        </td>
                        <td style="padding-left: 100px;">
                            <a href="staff_page.jsp">
                                <button style="font-size: 18px;">Home</button>
                            </a>
                        </td>
                        <td style="padding-left: 100px;">
                            <a href="cancel_app.jsp">
                                <input type="button" value="Cancel" style="font-size: 18px;">
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        <%
            }
            else
            {
                %>
                <br>
                <div align="center">
                    Sorry You Already have Applied For Leave<br>
                    Your Leave Is Not Yet Being Addressed<br>
                    <br>
                    <a href="staff_page.jsp">
                        <button style="font-size: 18px;">Back</button>
                    </a>
                </div>
        <%
            }
            }
            catch ( Exception e )
            {
                out.print("Exception Found");
            }
            %>
    </body>
</html>
