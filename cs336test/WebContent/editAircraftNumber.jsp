<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Editing Trip Number Page</title>
</head>
<body>
	<%
		String aircraft = request.getParameter("aircraft");
		String newAircraft = request.getParameter("newAircraft");

		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "Update `Aircraft` set aircraftID = " + newAircraft + " where aircraftID = " + aircraft; 			
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			con.close();
			out.println("Change successful");
		}
		catch(Exception ex){
			//out.print(ex);
			newAircraft = aircraft;
			out.println("Change failed; please try an aircraft that exists");
		}
%>

<br>
	<form method="post" action="editAircraft.jsp">
	<input type="hidden" name="aircraft" value=  <%out.print(newAircraft); %>>
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