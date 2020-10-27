<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airport Editing Page</title>
</head>
<body>	
	<%
	//Get parameters from the HTML form
	String newAirport = request.getParameter("airport");
	
	try{	
		ApplicationDB dbs = new ApplicationDB();	
		Connection accountConnection = dbs.getConnection();		
		Statement stmt3 = accountConnection.createStatement();
		String str3 = "SELECT distinct a.airportID, a.airportName, a.city, a.country from Airport a where a.airportID = '" + newAirport + "'";
		ResultSet result3 = stmt3.executeQuery(str3);
		
		out.print("<table style=\"width:100%\">");
		
		//row
		out.print("<tr>");
		//columns and headers
		out.print("<th>");
		out.print("Airport ID");
		out.print("</th>");
		out.print("<th>");
		out.print("Airport Name");
		out.print("</th>");
		out.print("<th>");
		out.print("City");
		out.print("</th>");
		out.print("<th>");
		out.print("Country");
		out.print("</th>");
		out.print("</tr>");

		//parse out the results
		while (result3.next()) {
			//row
			out.print("<tr>");
			//column

			out.print("<td>");
			out.print(result3.getString("airportID") + "    ");
			out.print("</td>");

			out.print("<td>");
			out.print(result3.getString("airportName") + "    ");
			out.print("</td>");
		
			out.print("<td>");
			out.print(result3.getString("city") + "    ");
			out.print("</td>");

			out.print("<td>");
			out.print(result3.getString("country") + "    ");
			out.print("</td>");
		
			out.print("</tr>");
		}
		out.print("</table>");
		dbs.closeConnection(accountConnection);
	}
	catch(Exception ex){
		//out.print(ex);
		out.println("Attempt to show aircrafy; please try an aircraft that exists.");
	}
%>
<br>

Enter the new aircraft number and click modify airport ID.

<br>
	<form method="post" action="editAirportID.jsp">
	<input type="hidden" name="airport" value= <%out.print(newAirport); %>>
	<table>
	<tr>
	<td>Airport ID:</td><td><input type="text" name="newAirport"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Airport ID">
	</form>
<br>

Enter the new airport name and click modify airport name.

<br>
	<form method="post" action="editAirportName.jsp">
	<input type="hidden" name="airport" value= <%out.print(newAirport); %>>
	<table>
	<tr>
	<td>Airport Name</td><td><input type="text" name="newAirport"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Airport Name">
	</form>
<br>

Enter the new city and click modify city.
<br>
	<form method="post" action="editAirportCity.jsp">
	<input type="hidden" name="airport" value= <%out.print(newAirport); %>>
	<table>
	<tr>
	<td>City:</td><td><input type="text" name="newCity"></td>
	</tr>
	</table>
	<input type="submit" value="Modify City">
	</form>
<br>


Enter the new country and click modify country.
<br>
	<form method="post" action="editAirportCountry.jsp">
	<input type="hidden" name="airport" value= <%out.print(newAirport); %>>
	<table>
	<tr>
	<td>Country:</td><td><input type="text" name="newCountry"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Country">
	</form>
<br> 

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