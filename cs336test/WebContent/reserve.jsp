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

                    String departureTime = request.getParameter("dep");
                    String arrivalTime = request.getParameter("arr");
                    String planeClass = "economy";
                    if(request.getParameter("class").equals("bus")){
                        planeClass = "business";
                    }else if(request.getParameter("class").equals("first")){
                        planeClass = "first class";
                    }
                    String meal = request.getParameter("meal").equals("reg")?"regular":"vegetarian";
                    

                    String query = new StringBuilder()      
                        .append("SELECT flightID FROM Flight WHERE departureTime = ? AND arrivalTime = ?").toString();

                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setString(1,departureTime);
                    statement.setString(2,arrivalTime);
                    ResultSet resultSet = statement.executeQuery();
                    int flightID = -1;
                    if(resultSet.next()){
                        flightID = resultSet.getInt("flightID");
                    }

                    int tripID = new Random().nextInt(1000);
                    String query2 = "INSERT INTO Trip (`tripID`,`flightID`) VALUES ('" + tripID + "', '" + flightID + "')";
                    PreparedStatement statement2 = connection.prepareStatement(query2);
                    statement2.executeUpdate();

                    String query3 = "INSERT INTO Ticket (`tripID`,`username`,`meal`,`class`) VALUES ('" + tripID + "', '" + session.getAttribute("user").toString() + "', '" + meal + "', '" + planeClass + "')";
                    PreparedStatement statement3 = connection.prepareStatement(query3);
                    statement3.executeUpdate();

                    String query4 = new StringBuilder()
                        .append("SELECT DISTINCT f.dayOfWeek, al.airlineName, ")
                        .append("ap1.airportName AS departureAirportName, ap2.airportName AS arrivalAirportName ")
                        .append("FROM Flight f ")
                        .append("JOIN Route ON f.routeID = Route.routeID ")
                        .append("JOIN Airline al ON Route.airlineID = al.airlineID ")
                        .append("JOIN Airport ap1 ON Route.departureAirportID = ap1.airportID ")
                        .append("JOIN Airport ap2 ON Route.arrivalAirportID = ap2.airportID ")
                        .append("WHERE f.departureTime = ? AND f.arrivalTime = ?").toString();
                    PreparedStatement statement4 = connection.prepareStatement(query4);
                    statement4.setString(1,departureTime);
                    statement4.setString(2,arrivalTime);
                    ResultSet resultSet2 = statement4.executeQuery();
                    String day = "";
                    String airline = "";
                    String depAirport = "";
                    String arrAirport = "";
                    if(resultSet2.next()){
                        day = resultSet2.getString("dayOfWeek");
                        airline = resultSet2.getString("airlineName");
                        depAirport = resultSet2.getString("departureAirportName");
                        arrAirport = resultSet2.getString("arrivalAirportName");
                    }

                    %>
                    <p id="userShow"><%=session.getAttribute("user").toString()%></p>
                    <p id="Logout">
                        <a href="logout.jsp">Logout</a>
                    </p>   
                    <p id="conf_msg">
                        Your booking from <%=depAirport%> to <%=arrAirport%> on <%=day%> with <%=airline%> departing at <%=departureTime%> 
                        and arriving at <%=arrivalTime%> has been reserved. You are flying <%=planeClass%> and have a <%=meal%> meal.
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