<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Reservations Page</title>
</head>
<body>
<%
		//Get parameters from the HTML form
		String newFlight = request.getParameter("flight");
		try{

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			
			//Create a SQL statement
			Statement stmt = accountConnect.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT t.queueNum, t.username, p.flightID, p.price, f.departureTime, p.departureDate, d.airportName as departingFrom, f.arrivalTime, p.arrivalDate, a.airportName as arrivingAt FROM Waitlist t join Trip p using(tripID) join Flight f using (flightID) join Route r using(routeID) join Airport d on r.departureAirportID = d.airportID join Airport a on r.arrivalAirportID = a.airportID WHERE p.flightID = " + newFlight;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
%>

			Flight waitlist for <% out.println(newFlight);
		 	//Make an HTML table to show the results in:
			out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("Queue Number");
				out.print("</th>");
				out.print("<th>");
				out.print("Username");
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
					out.print(result.getInt("queueNum") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result.getString("username") + "    ");
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
				
				//close the connection.
				db.closeConnection(accountConnect);
	}
	catch(Exception ex){
		//out.print(ex);
		out.println("Attempt to show flight waitlist failed; please try a flight waitlist that exists.");
	}
%>

<br>
	<form action="representative.jsp">
		<input type="submit" value = "Return to admin page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>