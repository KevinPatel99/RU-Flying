<%@ page language ="java" contentType="text/html"%>
<%@ page import ="java.text.*,java.util.*,java.sql.*" %>

<!DOCTYPE html>
<html>

    <div id="page">
            <meta charset="utf-8">
            <link rel="stylesheet" type="text/css" href="customer.css">
    </div>
    <% 
        if(session.getAttribute("user")!=null){
    %>      
            <p id="userShow"><%=session.getAttribute("user").toString()%></p>
            <p id="Logout">
                <a href="logout.jsp">Logout</a>
            </p>          
            <button class="button" id=flights_button 
            onclick="flights_nav()">FLIGHTS</button> 
            <button class="button" id=history_button
            onclick="history_nav()">HISTORY</button> 
    <%
        }
    %>
    
    <script>
        function history_nav(){
            window.location.replace("history.jsp");
        }

        function flights_nav(){
            window.location.replace("flights.jsp");
        }
    </script>

</html>