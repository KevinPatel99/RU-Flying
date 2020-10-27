<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding Flight to Trip Page</title>
</head>
<body>

This is a list of all the flights not in this trip.  
	<%
		try {	
			String newTrip = request.getParameter("trip");
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			Statement stmt = accountConnect.createStatement();
			String str = "SELECT p.tripID, f.flightID, f.dayOfWeek, f.departureTime, p.departureDate, d.airportName as departingFrom, f.arrivalTime, p.arrivalDate, a.airportName as arrivingAt FROM Trip p join Flight f using (flightID) join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID where p.tripID <> " + newTrip + " order by p.tripID, p.flightID";
			ResultSet result = stmt.executeQuery(str);

			out.print("<table style=\"width:100%\">");
			
			//row
			out.print("<tr>");
			//columns and headers
			out.print("<th>");
			out.print("Flight Number");
			out.print("</th>");
			out.print("<th>");
			out.print("Departure Time");
			out.print("</th>");
			out.print("<th>");
			out.print("Departing From");
			out.print("</th>");
			out.print("<th>");
			out.print("Arrival Time");
			out.print("</th>");
			out.print("<th>");
			out.print("Arriving At");
			out.print("</th>");
			out.print("<th>");
			out.print("Day of the week");
			out.print("</th>");
			out.print("</tr>");
			
			//parse out the results
			while (result.next()) {
				//row
				out.print("<tr>");
				out.print("<td>");
				out.print(result.getInt("flightID") + "    ");
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getTime("departureTime") + "    ");
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("departingFrom") + "    ");
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getTime("arrivalTime") + "    ");
				out.print("</td>");

				
				out.print("<td>");
				out.print(result.getString("arrivingAt") + "    ");
				out.print("</td>");
				
				
				out.print("<td>");
				out.print(result.getString("dayOfWeek") + "    ");
				out.print("</td>");
				
				out.print("</tr>");
			}
			out.print("</table>");
			db.closeConnection(accountConnect);
		}
		catch(Exception ex){
			out.println("Attempt to edit failed; please try a trip that exists.");
		}
%>
This is a list of all the flights currently in this trip.
<%
			int tripID = 0;
		try {	
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			String newTrip = request.getParameter("trip");
			Statement stmt = accountConnect.createStatement();
			String str = "SELECT p.tripID, p.flightID, p.price, f.departureTime, p.departureDate, d.airportName as departingFrom, f.arrivalTime, p.arrivalDate, a.airportName as arrivingAt FROM Trip p join Flight f using (flightID) join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID where p.tripID = " + newTrip + " order by p.tripID, p.flightID";
			ResultSet result = stmt.executeQuery(str);
			
			out.print("<table style=\"width:100%\">");
			
			//row
			out.print("<tr>");
			//columns and headers
			out.print("<th>");
			out.print("Trip Number");
			out.print("</th>");
			out.print("<th>");
			out.print("Flight Number");
			out.print("</th>");
			out.print("<th>");
			out.print("Price");
			out.print("</th>");
			out.print("<th>");
			out.print("Departure Time");
			out.print("</th>");
			out.print("<th>");
			out.print("Departure Date");
			out.print("</th>");
			out.print("<th>");
			out.print("Departing From");
			out.print("</th>");
			out.print("<th>");
			out.print("Arrival Time");
			out.print("</th>");
			out.print("<th>");
			out.print("Arrival Date");
			out.print("</th>");
			out.print("<th>");
			out.print("Arriving At");
			out.print("</th>");
			out.print("</tr>");
			
			//parse out the results
			while (result.next()) {
				//row
				out.print("<tr>");
				//column
				out.print("<td>");
				//Print out username:
				out.print(result.getInt("tripID") + "    ");
				out.print("</td>");
				tripID = result.getInt("tripID");

				out.print("<td>");
				out.print(result.getInt("flightID") + "    ");
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getInt("price") + "    ");
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getTime("departureTime") + "    ");
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getDate("departureDate") + "    ");
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("departingFrom") + "    ");
				out.print("</td>");
			
				out.print("<td>");
				out.print(result.getTime("arrivalTime") + "    ");
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getDate("arrivalDate") + "    ");
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("arrivingAt") + "    ");
				out.print("</td>");
				
				out.print("</tr>");
			}
			out.print("</table>");
			db.closeConnection(accountConnect);
		}
		catch(Exception ex){
			out.println("Attempt to edit failed; please try a trip that exists.");
		}
%>

Pick a flight number to add. Please be careful to not choose dates that will overlap with any of the 
current flights on this trip, and make sure the dates fall on the proper day of the week of the flight. 

<br>
	<form method="post" action="addTripFlightCont.jsp">
	<input type="hidden" name="trip" value= <%out.print(tripID); %>>
	<br> Flight ID: 
	<input type="text" name= "flight" >
	
	<br> Departure Date (YYYY-MM-DD): 
	<input type="text" name= "date" >
	
	<input type="submit" value="Add Flight">
	</form>
<br>

<br>
	<form action="editTrip.jsp">
		<input type="hidden" name="trip" value= <%out.print(tripID); %>>
		<input type="submit" value = "Return to editing trips page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>