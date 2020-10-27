<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Editing Page</title>
</head>
<body>
		<%
				String newFlight = request.getParameter("flight");
	try{
				ApplicationDB db = new ApplicationDB();	
				Connection accountConnect = db.getConnection();		
				Statement stmt = accountConnect.createStatement();
				String str = "SELECT f.flightID, f.departureTime, r.aircraftID, d.airportName as departingFrom, f.arrivalTime, r.routeID, a.airportName as arrivingAt FROM Flight f join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID where f.flightID = '" + newFlight + "'";
				ResultSet result = stmt.executeQuery(str);
				out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("Flight Number");
				out.print("</th>");
				out.print("<th>");
				out.print("Route Number");
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
					out.print(result.getInt("routeID") + "    ");
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
	}
	catch(Exception ex){
		out.println("Attempt to show flight; please try a flight that exists.");
	}
%>
<br>
Enter the new flight number and click modify flight number.
<br>
	<form method="post" action="editFlightNumber.jsp">
	<input type="hidden" name="flight" value= <%out.print(newFlight); %>>
	<table>
	<tr>
	<td>Flight Number</td><td><input type="text" name="newFlight"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Flight Number">
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
Enter the new flight route and click modify route.
<br>
	<form method="post" action="editFlightRoute.jsp">
	<input type="hidden" name="flight" value= <%out.print(newFlight); %>>
	<table>
	<tr>
	<td>Route:</td><td><input type="text" name="newRoute"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Route">
	</form>

<br>
	<form action="editAddDelFlight.jsp">
		<input type="submit" value = "Return to modifying flights page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>