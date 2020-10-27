<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding Flight Page</title>
</head>
<body>
	<%
		String newAirport = request.getParameter("airport");
		String newName = request.getParameter("name");
		String newCity = request.getParameter("city");
		String newCountry = request.getParameter("country");
		try {	
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();		
			Statement stmt = accountConnect.createStatement();
			String str = "insert into `Airport` select '" + newAirport + "', '" + newName + "', '" + newCity + "', '" + newCountry + "'";
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
	<form action="editAddDelAirport.jsp">
		<input type="submit" value = "Return to modifying airport page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>