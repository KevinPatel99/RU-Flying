<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding Trip Page</title>
</head>
<body>
<%
		String newTrip = request.getParameter("trip");
		String newFlight = request.getParameter("flight");
		String newDate = request.getParameter("date");
		String newType = request.getParameter("type");
		String newPrice = request.getParameter("price");
		String tripID =  request.getParameter("trip");
		try {	
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			String str = "insert into `Trip` (`tripID`, `flightID`, `departureDate`, `arrivalDate`, `stops`, `price`, `flightType`) select " + newTrip + ", " + newFlight + ", '" + newDate + "', '"+ newDate + "', 0, " + newPrice + ", '" + newType + "'";
			PreparedStatement ps = accountConnect.prepareStatement(str);
			ps.executeUpdate();
			accountConnect.close();
			out.println("Successfully added");
		}
		catch(Exception ex){
			out.println("Attempt to insert failed; please try again.");
		}
%>

<br>
	<form action="editAddDelTrip.jsp">
		<input type="submit" value = "Return to modifying trip page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>