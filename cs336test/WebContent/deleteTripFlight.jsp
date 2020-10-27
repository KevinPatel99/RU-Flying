<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deleting Flight from Trip Page</title>
</head>
<body>
<% 
	String tripID = request.getParameter("trip");
	try {	
			String newTrip = request.getParameter("trip");
			String newFlight = request.getParameter("flight");
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			String str = "delete from `Trip` WHERE flightID = " + newFlight + " AND tripID = " + newTrip;
			PreparedStatement ps = accountConnect.prepareStatement(str);
			ps.executeUpdate();		
			out.println("Delete successful.");
			db.closeConnection(accountConnect);
		} catch(Exception ex){
			out.println("Attempt to edit failed; please try a trip that exists.");
		}%>

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