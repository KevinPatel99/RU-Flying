<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Edit, Add, or Delete a Airport</title>
</head>
<body>
<br>

List of all Airports:
<% 
				ApplicationDB dbs = new ApplicationDB();	
				Connection accountConnection = dbs.getConnection();		
				Statement stmt3 = accountConnection.createStatement();
				String str3 = "SELECT distinct a.airportID, a.airportName, a.city, a.country from Airport a order by a.airportID ";
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
%>
<br>
Insert an airport ID that you would like to delete, and click delete.
<br>
	<form method="post" action="deleteAirport.jsp">
	<table>
	<tr>
	<td>Airport ID</td><td><input type="text" name="airport"></td>
	</tr>
	</table>
	<input type="submit" value="Delete">
	</form>
<br>

Insert a airport ID that you would like to edit, and click edit.
<br>
	<form method="post" action="editAirport.jsp">
	<table>
	<tr>
	<td>Airport ID</td><td><input type="text" name="airport"></td>
	</tr>
	</table>
	<input type="submit" value="Edit">
	</form>
<br>


Add an Airport.
<br>
	<form method="post" action="addAirport.jsp">
	<table>
	<tr><td>Airport ID <input type="text" name="airport"></tr></td>
	<tr><td>Airport name <input type="text" name="name"></tr></td>
	<tr><td>City<input type="text" name="city"></tr></td>
	<tr><td>Country<input type="text" name="country"></tr></td>
	
	</table>
	<input type="submit" value="Add New Airport">
	</form>
<br>

<form method="post" action="representative.jsp">
	<br>
	<input type="submit" value="Go Back" />
</form>
<br>


<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>


</body>
</html>