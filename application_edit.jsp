<%-- 
    Document   : application_edit
    Created on : Sep 17, 2017, 10:00:00 PM
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
        <title>Application Requested</title>
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
            option,select {
                padding-left: 10px;
                padding-right: 10px;
            }
        </style>
    </head>
    <body style="background: #FAFAFA">
        <%
            int sid = 0;
            String name = null, desg = null, cat = null, reason = null, alt_s = null ;
            Date dt = null, df = null ;
 
            HttpSession sess = request.getSession();
            String username = (String) sess.getAttribute("username") ;
            
            try
            {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs1 = st.executeQuery("select * from staff_r where uname='"+username+"'");
            if ( rs1 != null )
            {
                while ( rs1.next() )
                {
                    sid = rs1.getInt("sid");
                    desg = rs1.getString("desg");
                }
            }
            rs1.close() ;
            ResultSet rs = st.executeQuery("select * from app_leave where sid="+sid);
            if ( rs != null )
            {
                while ( rs.next() )
                {
                    name = rs.getString("name");
                    df = rs.getDate("date_f");
                    dt = rs.getDate("date_t");
                    cat = rs.getString("cat");
                    reason = rs.getString("reas");
                    alt_s = rs.getString("alt_s");
                }
            }
            rs.close() ;
            String sql2 = "delete from app_leave where sid="+sid ;
            st.executeUpdate(sql2);
            %>
        <div style="width: 1400px;">
            <div class="size_header" style="position: absolute;">
                Leave Management
            </div>
        </div>
        <br><br><hr style="border-color: #696969;">
        <form method="post" action="next_staff.jsp">
        <div id="apply_leave">
            <div>
                <table>
                    <tr>
                        <td>Staff Id</td>
                        <td><input type="text" name="staff_id" value="<%=sid %>" required></td>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="name" value="<%=name %>" required></td>
                        <td>Designation</td>
                        <td><input type="text" name="desg" value="<%=desg %>" required></td>
                    </tr>
                    <tr>
                        <td>Category</td>
                        <td>
                            <select id="cat" name="category" required>
                                <option value="Medical">Medical</option>
                                <option value="Casual">Casual</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <br>
                <table>
                    <tr>
                        <td>Duration :</td>
                        <td>From</td>
                        <td><input type="date" name="leave_from" value="<%=df %>" required></td>
                        <td>To</td>
                        <td><input type="date" name="leave_to" value="<%=dt %>" required></td>
                    </tr>
                </table>
                <br>
                <table>
                    <tr>
                        <td style="padding-right: 250px;">Reason (Application)</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="application" style="width: 400px; height: 100px;" value="<%=reason %>" required></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>Alternative Staff :</td>
                        <td>
                            <select id="alt_staff" name="alt_staff" required>
                                <%
                                ResultSet rs3 = st.executeQuery("select * from staff_r");
                                if ( rs3 != null )
                                {
                                    while ( rs3.next() )
                                    {
                                        %>
                                        <option value="<%=rs3.getString("name")%>"><%=rs3.getString("name") %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div align="center" style="padding-top: 20px; font-size: 18px;">
            <input type="submit" value="Submit">
        </div>
        </form>
            <%
            }
            catch ( Exception e )
            {
                out.print("Exception Found");
            }
            %>
    </body>
</html>
