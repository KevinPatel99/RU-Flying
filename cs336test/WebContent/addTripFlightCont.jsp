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

	<%
		String tripID =  request.getParameter("trip");
		int time = 0;
		try {	
			String newTrip = request.getParameter("trip");
			String newFlight = request.getParameter("flight");
			String newDate = request.getParameter("date");
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			String str = "insert into `Trip` (`tripID`, `flightID`, `departureDate`, `arrivalDate`, `stops`, `price`, `flightType`) select " + newTrip + ", " + newFlight + ", '" + newDate + "', '"+ newDate +"', max(t.`stops`), max(t.`price`), max(t.`flightType`)from `Trip` t where tripID = " + newTrip;		
			PreparedStatement ps = accountConnect.prepareStatement(str);
			ps.executeUpdate();
			String str4 = "update `Trip` set stops = (select t.stops from (select * from `Trip`) as t  where t.tripID = " + newTrip + " AND t.flightID = " + newFlight + ") + 1 where tripID = " + newTrip;
			PreparedStatement ps4 = accountConnect.prepareStatement(str4);
			ps4.executeUpdate();
			accountConnect.close();
			out.println("Successfully added");
		}
		catch(Exception ex){
			out.println("Attempt to edit failed; please try a trip that exists.");
		}
%>

<br>
	<form method="post" action="addTripFlight.jsp">
	<input type="hidden" name="trip" value= <%out.print(tripID); %>>
	<input type="submit" value="Go Back to Adding Flights Page">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>