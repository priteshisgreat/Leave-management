<%-- 
    Document   : hod_profile
    Created on : Sep 27, 2017, 6:12:28 PM
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
        <title>Teachers Profile</title>
        <style>
            .size_header {
                font-size: 35px;
            }
            td {
                font-size: 18px;
                font-family: serif;
                padding-bottom: 10px;
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

.show {display:block;}
        </style>
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
        </script>
    </head>
    <body style="background: #FAFAFA">
        <%
            int t = 0, sid = 0 ;
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_management",
                    "root","kaushal08");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from login_h");
        %>
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
        <div>
            <h2 align="center">
                Teachers Details
            </h2>
            <table>
                <%
            if ( rs != null )
            {
                while ( rs.next() )
                {
                %>
                <tr>
                    <td>Name</td>
                    <td><%=rs.getString("name") %></td>
                </tr>
                <tr>
                    <td>Department</td>
                    <td><%=rs.getString("dept") %></td>
                </tr>
                <tr>
                    <td>Designation</td>
                    <td><%=rs.getString("desg") %></td>
                </tr>
                <tr>
                    <td>Qualification</td>
                    <td><%=rs.getString("qual") %></td>
                </tr>
                <tr>
                    <td>E-mail</td>
                    <td><%=rs.getString("email") %></td>
                </tr>
                <tr>
                    <td>Phone</td>
                    <td><%=rs.getString("phone") %></td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td><%=rs.getString("addr") %></td>
                </tr>
                <%
                }
            }
                %>
            </table>
        </div>
        <div align="center">
            <a href="hod_page.jsp"><button style="font-size: 18px;">Back</button></a>
        </div>
    </body>
</html>
