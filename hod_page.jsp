<%-- 
    Document   : home
    Created on : Sep 9, 2017, 10:39:25 PM
    Author     : DELL
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mysql.jdbc.CommunicationsException" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.*" %>
<%@page import="java.time.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOD Home Page</title>
        <style>
            .size_header {
                font-size: 35px;
            }
            .teacher_det {
                float: right;
                width: 350px;
                height: 600px;
                border-left-style: solid;
                border-left-color: #696969;
            }
            .size_teacher_header {
                font-size: 25px;
                font: bold; 
            }
            .size_teacher {
                font-size: 18px;
                font-family: monospace;
            }
            li{
                padding-bottom: 5px;
                padding-left: 10px;
            }
            .leave_req {
                border-radius: 1.5%;
                border-color: #696969;
                border-style: solid;
                width: 950px;
            }
            .leave_app {
                border-radius: 1.5%;
                border-color: #696969;
                border-style: solid;
                width: 950px;
            }
            .leave_text {
                font-size: 20px;
                padding-bottom: 10px;
            }
            td {
                padding-left: 25px;
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

.show {display:block;}
        </style>
    </head>
    <body style="background: #FAFAFA">
        <script>
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

function printDiv(divName) {
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;

     document.body.innerHTML = printContents;

     window.print();

     document.body.innerHTML = originalContents;
}
</script>
        <div style="width: 1400px;">
            <div class="size_header" style="position: absolute;">
                Leave Management
            </div>
            <div style="text-align: end; width: 1175px;">
                <div style="position: absolute; padding-top: 3px;" class="dropdown">
                    <img src="account.png" style="width: 60px; height: 30px;" onclick="myFunction()" class="dropbtn">
                    <div id="myDropdown" class="dropdown-content" align="left">
                        <a href="hod_profile.jsp">Profile</a>
                        <a href="index.html">Sign Out</a>
                    </div>
                </div>
            </div>
        </div>
        <br><br><hr style="border-color: #696969;">
        <%
            int t = 0, sid = 0 ;
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from staff_r order by sid asc");
        %>
        <div class="teacher_det">
            <div class="size_teacher_header" align="center">
                Teacher's Details
            </div>
            <div class="size_teacher">
                <ul>
                    <%
            if ( rs != null )
            {
                while ( rs.next() )
                {
                    %>
                    <a href="teacher.jsp?username=<%=rs.getString("uname") %>" >
                        <li><%=rs.getString("name") %></li>
                    </a>
                    <%
                }
            }
                    %>
                </ul>
            </div>
        </div>
        <div class="leave_req" style="padding-left:25px;">
            <div class="leave_text">
            <h2 align="center">Leave Request</h2>
                <table>
                    <%
            int t1 = 0 ;
            ResultSet rs1 = st.executeQuery("select * from app_leave");
            if ( rs1 != null )
            {
                while ( rs1.next() )
                {
                    t1++ ;
                    %>
                    <tr>
                        <td><%=rs1.getDate("date_f") %></td>
                        <td> - </td>
                        <td><%=rs1.getDate("date_t") %></td>
                        <td><%=rs1.getString("name") %></td>
                        <td><%=rs1.getString("reas") %></td>
                        <td>
                            <a href="accepted.jsp?name=<%= rs1.getString("name") %>">
                                <button>Accept</button>
                            </a>
                        </td>
                        <td>
                            <a href="decline.jsp?name=<%= rs1.getString("name") %>">
                                <button>Decline</button>
                            </a>
                        </td>
                    </tr>
                    <%
                }
            }
            rs1.close();
            if ( t1 == 0 )
            {
                %>
                <tr>
                    <td rowspan="4">No Leave Request</td>
                </tr>
                    <%
            }
                    %>
                </table>
            </div>
        </div>
        <br>
        <div class="leave_app" style="padding-left: 25px;" id="leave_app">
            <div class="leave_text" id="leave_text">
            <h2 align="center">Today On Leave (Approved)</h2>
                <table>
                    <%
            int t2 = 0 ;
            DateTimeFormatter dtf= DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDate localdate=LocalDate.now();
            
            ResultSet rs2 = st.executeQuery("select * from past_h where date_f <= '"+dtf.format(localdate)+"' AND date_t >= '"+dtf.format(localdate)+"' AND status='Accepted'");
            if ( rs2 != null )
            {
                while ( rs2.next() )
                {
                    t2++ ;
                    %>
                    <tr>
                        <td><%=rs2.getDate("date_f") %></td>
                        <td> - </td>
                        <td><%=rs2.getDate("date_t") %></td>
                        <td><%=rs2.getString("name") %></td>
                        <td><%=rs2.getString("reas") %></td>
                        <td><%=rs2.getString("alt_s") %></td>
                    </tr>
                    <%
                }
            }
            rs2.close();
            if ( t2 == 0 )
            {
                %>
                <tr>
                    <td rowspan="4" align="center">No One on Leave</td>
                </tr>
                    <%
            }
                    %>
                </table>
            </div>
        <%
            if ( t2 != 0 )
            {
                %>
                <table style="padding-bottom: 10px;">
                    <tr>
                        <td rowspan="7" colspan="7" style="padding-left: 650px;">
                            <a href="#" onclick="printDiv('leave_text')">
                                <button>Print</button>
                            </a>
                        </td>
                    </tr>
                </table>
                <%
            }
        %>
        </div>
    </body>
</html>
