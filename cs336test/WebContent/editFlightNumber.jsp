<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Editing Flight Number Page</title>
</head>
<body>
	<%
		String flight = request.getParameter("flight");
		String newFlight = request.getParameter("newFlight");
		out.println(flight);
		out.println(newFlight);
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "Update `Flight` set flightID = " + newFlight + " where flightID = " + flight; 
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			con.close();
			out.println("Change successful");
		}
		catch(Exception ex){
			newFlight = flight;
			out.println("Change failed; please try a trip that exists");
		}
%>
<br>
	<form method="post" action="editFlight.jsp">
	<input type="hidden" name="flight" value=  <%out.print(newFlight); %>>
	<input type="submit" value="Return to editing page">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>