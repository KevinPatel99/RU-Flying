<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

    <div id="page">
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="flights.css">
        
            <% 
            if(session.getAttribute("user")!=null){
            
                try{
                    ApplicationDB db = new ApplicationDB();	
			        Connection connection = db.getConnection();	

                    String tripID = request.getParameter("tripID");
                    String flightID = request.getParameter("flightID");
                    String ticketID = request.getParameter("ticketID");
                    

                    String query = new StringBuilder()      
                        .append("DELETE FROM Ticket WHERE Ticket.ticketID = ?").toString();
                    
                    String query2 = new StringBuilder()
                        .append("SELECT departureDate, arrivalDate FROM Trip WHERE Trip.tripID = ? AND Trip.flightID = ? ").toString();

                    String query3 = new StringBuilder()      
                        .append("DELETE FROM Trip WHERE Trip.tripID = ? AND Trip.flightID = ?" ).toString();

                        

                    PreparedStatement statement = connection.prepareStatement(query);
                    
                    statement.setString(1,ticketID);
                    statement.executeUpdate();

                    PreparedStatement statement2 = connection.prepareStatement(query2);
                    statement2.setString(1,tripID);
                    statement2.setString(2,flightID);
                    ResultSet resultSet = statement2.executeQuery();
                    String departureDate = "0000-00-00";
                    String arrivalDate = "0000-00-00";
                        if(resultSet.next()) {
                            if(resultSet.getString("arrivalDate") != null){
                                arrivalDate = resultSet.getString("arrivalDate").toString();
                            }

                            if(resultSet.getString("departureDate") != null){
                                departureDate = resultSet.getString("departureDate").toString();
                            }

                        }
                    


                    PreparedStatement statement3 = connection.prepareStatement(query3);
                    statement3.setString(1,tripID);
                    statement3.setString(2,flightID);
                    statement3.executeUpdate();

                   

                    %>
                    <p id="userShow"><%=session.getAttribute("user").toString()%></p>
                    <p id="Logout">
                        <a href="logout.jsp">Logout</a>
                    </p>   
                    <p id="conf_msg">
                        Your booking from <%=departureDate%> to <%=arrivalDate%> has been cancelled
                    </p>
                    <form action="customer.jsp">
				        <input type="submit" value = "Proceed to your customer page.">
			        </form>
                    <%  

                    
                    
                }catch(SQLException e){
                    e.printStackTrace();
                }
            }
            %>

    </div>


    
</html>