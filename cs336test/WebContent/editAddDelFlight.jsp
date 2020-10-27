<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Edit, Add, or Delete a Flight</title>
</head>
<body>
<br>

List of all flights:
				<%
				ApplicationDB db = new ApplicationDB();	
				Connection accountConnect = db.getConnection();		
				Statement stmt = accountConnect.createStatement();
				String str = "SELECT f.flightID, f.departureTime, r.aircraftID, d.airportName as departingFrom, f.arrivalTime, a.airportName as arrivingAt FROM Flight f join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID order by f.flightID";
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
				out.print("Aircraft Number");				
				out.print("</th>");
				out.print("</tr>");
				
				//parse out the results
				while (result.next()) {
					//row
					out.print("<tr>");
					//column

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
					out.print(result.getInt("aircraftID") + "    ");
					out.print("</td>");
					
					out.print("</tr>");
				}
				out.print("</table>");
				db.closeConnection(accountConnect);
%>
<br>
Insert a Flight number that you would like to edit, and click edit.
<br>
	<form method="post" action="editFlight.jsp">
	<table>
	<tr>
	<td>Flight Number</td><td><input type="text" name="flight"></td>
	</tr>
	</table>
	<input type="submit" value="Edit">
	</form>
<br>

Insert a Flight number that you would like to delete, and click delete.
<br>
	<form method="post" action="deleteFlight.jsp">
	<table>
	<tr>
	<td>Flight Number</td><td><input type="text" name="flight"></td>
	</tr>
	</table>
	<input type="submit" value="Delete">
	</form>
<br>

List of all Routes:
				<%
				ApplicationDB db2 = new ApplicationDB();	
				Connection accountConnect2 = db2.getConnection();		
				Statement stmt2 = accountConnect2.createStatement();
				String str2 = "SELECT r.routeID, r.domOrInt, r.airlineID, r.aircraftID, d.airportName as departingFrom, a.airportName as arrivingAt FROM  Route r join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID order by r.routeID ";
				ResultSet result2 = stmt2.executeQuery(str2);
				out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("Route ID");
				out.print("</th>");
				out.print("<th>");
				out.print("Airline");
				out.print("</th>");
				out.print("<th>");
				out.print("Departing From");
				out.print("</th>");
				out.print("<th>");
				out.print("Arriving At");
				out.print("</th>");
				out.print("<th>");
				out.print("Domestic or International");
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
					out.print(result2.getInt("routeID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result2.getString("airlineID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result2.getString("departingFrom") + "    ");
					out.print("</td>");
				
					out.print("<td>");
					out.print(result2.getString("arrivingAt") + "    ");
					out.print("</td>");
					
					out.print("<td>");
					out.print(result2.getString("domOrInt") + "    ");
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
Add a flight and use a new flight number:
<br>
	<form method="post" action="addFlight.jsp">
	<table>
	<tr><td>FlightID <input type="text" name="flight"></tr></td>
	<tr><td>Departure Time (HH:MM:SS) <input type="text" name="dtime"></tr></td>
	<tr><td>Arrival Time (HH:MM:SS) <input type="text" name="atime"></tr></td>
	<tr><td>Day of the week (Monday, Tuesday, etc.)<input type="text" name="day"></tr></td>
	<tr><td>Route ID<input type="text" name="route"></tr></td>
	
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