<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airport Deletion Page</title>
</head>
<body>
	<%
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String newAirport = request.getParameter("airport");
			String str = "delete from `Airport` WHERE airportID = '" + newAirport + "'";
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			con.close();
			out.println("Deletion successful");
		}
		catch(Exception ex){
			out.println("Deletion failed; please try an airport that exists.");
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