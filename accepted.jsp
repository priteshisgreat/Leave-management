<%-- 
    Document   : accepted
    Created on : Sep 27, 2017, 1:50:32 PM
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
        <title>Application Accepted</title>
    </head>
    <body>
        <%
            int t = 0 ;
            String name = request.getParameter("name");
            int sid = 0 ;
            String cat = null, rea = null, alt_s = null ;
            Date dt = null, df = null ;
            t = 1 ;
            try
            {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs =  st.executeQuery("select * from app_leave where name='"+name+"'");
            if ( rs != null )
            {
                while ( rs.next() )
                {
                    sid = rs.getInt("sid");
                    dt = rs.getDate("date_t");
                    df = rs.getDate("date_f");
                    cat = rs.getString("cat");
                    rea = rs.getString("reas");
                    alt_s = rs.getString("alt_s");
                }
            }
            String sql1 = "delete from app_leave where name='"+name+"'" ;
            String sql2 = "insert into past_h(sid,name,date_f,date_t,cat,reas,alt_s,status) values("+sid+",'"+name+"','"
                    +df+"','"+dt+"','"+cat+"','"+rea+"','"+alt_s+"','Accepted')" ;
            st.executeUpdate(sql1);
            st.executeUpdate(sql2);
            ResultSet rs1 = st.executeQuery("select * from staff_r where name='"+name+"'" );
            int mcnt = 0, ccnt = 0 ;
            if ( rs1 != null )
            {
                while ( rs1.next() )
                {
                    mcnt = rs1.getInt("m_cnt");
                    ccnt = rs1.getInt("c_cnt");
                }
            }
            mcnt = mcnt - 1 ;
            ccnt = ccnt - 1 ;
            if ( cat.equals("Medical") )
            {
                st.executeUpdate("update staff_r set m_cnt="+mcnt+" where name='"+name+"'");
            }
            else
            {
                st.executeUpdate("update staff_r set c_cnt="+ccnt+" where name='"+name+"'");
            }
            response.sendRedirect("hod_page.jsp");
            out.print("Application Accepted");
            }
            catch ( Exception e )
            {
                out.print("Exception Found");
            }
            %>
    </body>
</html>
