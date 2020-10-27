<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Edit, Add, or Delete a Trip</title>
</head>
<body>
<br>
List of all trips:
				<%
				ApplicationDB db = new ApplicationDB();	
				Connection accountConnect = db.getConnection();		
				Statement stmt = accountConnect.createStatement();
				String str = "SELECT p.tripID, p.flightID, p.price, f.departureTime, p.departureDate, d.airportName as departingFrom, f.arrivalTime, p.arrivalDate, a.airportName as arrivingAt FROM Trip p join Flight f using (flightID) join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID order by p.tripID, p.flightID";
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
%>
<br>

Insert a Trip number that you would like to edit, and click edit.
<br>
	<form method="post" action="editTrip.jsp">
	<table>
	<tr>
	<td>Trip Number</td><td><input type="text" name="trip"></td>
	</tr>
	</table>
	<input type="submit" value="Edit">
	</form>
<br>

Insert a Trip number that you would like to delete, and click delete.
<br>
	<form method="post" action="deleteTrip.jsp">
	<table>
	<tr>
	<td>Trip Number</td><td><input type="text" name="trip"></td>
	</tr>
	</table>
	<input type="submit" value="Delete">
	</form>
<br>

List of all flights:
				<%
				ApplicationDB db2 = new ApplicationDB();	
				Connection accountConnect2 = db2.getConnection();		
				Statement stmt2 = accountConnect2.createStatement();
				String str2 = "SELECT p.tripID, p.flightID, p.price, f.departureTime, p.departureDate, r.aircraftID, d.airportName as departingFrom, f.arrivalTime, p.arrivalDate, a.airportName as arrivingAt FROM Trip p join Flight f using (flightID) join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID order by p.tripID, p.flightID";
				ResultSet result2 = stmt2.executeQuery(str2);

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
				out.print("Aircraft Number");
				out.print("</th>");
				out.print("</tr>");

				//parse out the results
				while (result2.next()) {
					//row
					out.print("<tr>");
					//column
					out.print("<td>");
					out.print(result2.getInt("flightID") + "    ");
					out.print("</td>");
				
					out.print("<td>");
					out.print(result2.getTime("departureTime") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result2.getString("departingFrom") + "    ");
					out.print("</td>");
				
					out.print("<td>");
					out.print(result2.getTime("arrivalTime") + "    ");
					out.print("</td>");
					
					out.print("<td>");
					out.print(result2.getString("arrivingAt") + "    ");
					out.print("</td>");
					
					out.print("<td>");
					out.print(result2.getInt("aircraftID") + "    ");
					out.print("</td>");
					
					out.print("</tr>");
				}
				out.print("</table>");
				db2.closeConnection(accountConnect2);
%>

<br>
Add a trip and use a new Trip Number:
<br>
	<form method="post" action="addTrip.jsp">
	<table>
	<tr><td>Trip Number<input type="text" name="trip"></tr></td>
	<tr><td>First FlightID (Add more by editing later)<input type="text" name="flight"></tr></td>
	<tr><td>Departure Date YYYY-MM-DD<input type="text" name="date"></tr></td>
	<tr><td>Flight Type (round-trip or one-way)<input type="text" name="type"></tr></td>
	<tr><td>Price<input type="text" name="price"></td></tr>
	</table>
	<input type="submit" value="Add New Trip">
	</form>
<br>

<form method="post" action="representative.jsp">
	<br>
	<input type="submit" value="Go Back" />
</form>
<br>


<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>


</body>
</html>