<%-- 
    Document   : staff_page
    Created on : Sep 14, 2017, 10:10:11 PM
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
        <title>Staff Page</title>
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
.dropbtn {
    color: white;
    border: none;
    cursor: pointer;
}

.dropbtn:hover, .dropbtn:focus {
    background-color: #3e8e41;
}

.dropdown {
    position: absolute;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown a:hover {background-color: #f1f1f1}

.show {
    display:block;
}
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script>
        $(document).ready(function()
        {
            $("#apply_leave").hide();
            $("#past_history").hide();
            $('input[id="appl_leav"]').click(function()
            {
                $("#apply_leave").show();
                $("#past_history").hide();
            });
            $('input[id="past_his"]').click(function()
            {
                $("#past_history").show();
                $("#apply_leave").hide();
            });
        });

/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
        </script>
    </head>
    <body style="background: #FAFAFA">
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
            Statement st = con.createStatement();
            HttpSession sess = request.getSession();
            String username = (String) sess.getAttribute("username") ;
        %>
        <div style="width: 1400px;">
            <div class="size_header" style="position: absolute; width: 1000px;">
                Leave Management
            </div>
            <div style="text-align: end; width: 1175px;">
                <div style="position: absolute; padding-top: 3px;" class="dropdown">
                    <img src="account.png" style="width: 60px; height: 30px;" onclick="myFunction()" class="dropbtn">
                    <div id="myDropdown" class="dropdown-content" align="left">
                        <a href="profile.jsp?username=<%=username %>">Profile</a>
                        <a href="index.html">Sign Out</a>
                    </div>
                </div>
            </div>
        </div>
        <br><br><hr style="border-color: #696969;">
        <div align="center">
            <table>
                <tr>
                    <td><input type="button" id="appl_leav" name="staff_choice" value="Apply Leave" style="font-size: 20px;"></td>
                    <td><input type="button" id="past_his" name="staff_choice" value="Past History" style="font-size: 20px;"></td>
                </tr>
            </table>
        </div>
        <br>
        <form action="next_staff.jsp" method="post">
        <div id="apply_leave">
            <div>
                <table>
                    <tr>
                        <td>Staff Id</td>
                        <td><input type="text" name="staff_id" required></td>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="name" required></td>
                        <td>Designation</td>
                        <td><input type="text" name="desg" required></td>
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
                        <td><input type="date" name="leave_from" required></td>
                        <td>To</td>
                        <td><input type="date" name="leave_to" required></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>Check Balance</td>
                        <td><input type="text" name="check_bal"></td>
                        <td><input type="button" value="Check"></td>
                    </tr>
                </table>
                <br>
                <table>
                    <tr>
                        <td style="padding-right: 250px;">Reason (Application)</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="application" style="width: 400px; height: 100px;" required></td>
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
            <div align="center">
                <input type="submit" value="Submit" style="font-size: 18px;">
            </div>
        </div>
        </form>
        <div id="past_history">
            <div>
                <table>
                        <%
            int sid = 0, t = 0 ;
            
            ResultSet rs = st.executeQuery("select * from staff_r where uname='"+username+"'");
            if ( rs != null )
            {
                while ( rs.next() )
                {
                    if ( username.equals(rs.getString("uname")))
                    {
                        sid = rs.getInt("sid");
                    }
                }
            }
            else
            {
                t = 1 ;
            }
            rs.close();
            ResultSet rs1 = st.executeQuery("select * from app_leave");
            if ( rs1 != null )
            {
                while ( rs1.next() )
                {
                    if ( rs1.getInt("sid") == sid )
                    {
                        %>
                        <tr>
                            <td><%=rs1.getString("date_f") %></td>
                            <td> - </td>
                            <td><%=rs1.getString("date_t") %></td>
                            <td><%=rs1.getString("reas") %></td>
                            <td><%=rs1.getString("cat") %></td>
                            <td>Pending</td>
                        </tr>
                        <%
                        t++ ;
                    }
                }
            }
            rs1.close();
            ResultSet rs2 = st.executeQuery("select * from past_h");
            if ( rs2 != null )
            {
                while ( rs2.next() )
                {
                    if ( rs2.getInt("sid") == sid )
                    {
                        %>
                        <tr>
                            <td><%=rs2.getString("date_f") %></td>
                            <td> - </td>
                            <td><%=rs2.getString("date_t") %></td>
                            <td><%=rs2.getString("reas") %></td>
                            <td><%=rs2.getString("cat") %></td>
                            <td><%=rs2.getString("status") %></td>
                        </tr>
                        <%
                        t++ ;
                    }
                }
            }
            rs2.close();
            if ( t == 0 )
            {
                %>
                <tr>
                    <td rowspan="6">No Record</td>
                </tr>
                    <%
            }
                        %>
                </table>
            </div>
        </div>
    </body>
</html>
