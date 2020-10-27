<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Edit, Add, or Delete an Aircraft</title>
</head>
<body>
<br>


All Aircrafts
<% 
				
				//Database Connection
				ApplicationDB dbs = new ApplicationDB();	
				Connection accountConnection = dbs.getConnection();		
				Statement stmt3 = accountConnection.createStatement();
				//Select query from index.jsp
				String str3 = "SELECT distinct a.aircraftID, a.airlineID, r.airlineName, a.maxCapacity from Aircraft a join Airline r using(airlineID) order by a.aircraftID ";
				ResultSet result3 = stmt3.executeQuery(str3);
				
				out.print("<table style=\"width:100%\">");
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("Aircraft Number");
				out.print("</th>");
				out.print("<th>");
				out.print("Maximum Capacity");
				out.print("</th>");
				out.print("<th>");
				out.print("Airline ID");
				out.print("</th>");
				out.print("<th>");
				out.print("Airline Name");
				out.print("</th>");
				out.print("</tr>");

				//parse out the results
				while (result3.next()) {
					//row
					out.print("<tr>");
					//columns
					out.print("<td>");
					out.print(result3.getInt("aircraftID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result3.getInt("maxCapacity") + "    ");
					out.print("</td>");
				
					out.print("<td>");
					out.print(result3.getString("airlineID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result3.getString("airlineName") + "    ");
					out.print("</td>");
				
					out.print("</tr>");
				}
				out.print("</table>");				
				dbs.closeConnection(accountConnection);
%>
Insert an aircraft number that you would like to delete, and click the delete button below. 
<br>
	<form method="post" action="deleteAircraft.jsp">
	<table>
	<tr>
	<td>Aircraft Number</td><td><input type="text" name="aircraft"></td>
	</tr>
	</table>
	<input type="submit" value="Delete">
	</form>
<br>

Insert an aircraft number that you would like to edit, and click the edit button below. 
<br>
	<form method="post" action="editAircraft.jsp">
	<table>
	<tr>
	<td>Aircraft Number</td><td><input type="text" name="aircraft"></td>
	</tr>
	</table>
	<input type="submit" value="Edit">
	</form>
<br>

This is a list of all Airlines in the database.
				<%
				
				ApplicationDB db2 = new ApplicationDB();	
				Connection accountConnect2 = db2.getConnection();		
				Statement stmt2 = accountConnect2.createStatement();		
				String str2 = "SELECT distinct r.airlineID, r.airlineName from Airline r order by r.airlineID ";
				ResultSet result2 = stmt2.executeQuery(str2);
				
				//Make an HTML table:
				out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("Airline ID");
				out.print("</th>");
				out.print("<th>");
				out.print("Airline Name");
				out.print("</th>");
				out.print("</tr>");

				//parse out the results
				while (result2.next()) {
					//row
					out.print("<tr>");
					//column
					out.print("<td>");
					out.print(result2.getString("airlineID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result2.getString("airlineName") + "    ");
					out.print("</td>");
				
					out.print("</tr>");
				}
				out.print("</table>");
				db2.closeConnection(accountConnect2);
%>

Add an aircraft using a new aircraft number:
<br>
	<form method="post" action="addAircraft.jsp">
	<table>
	<tr><td>Aircraft Number <input type="text" name="aircraft"></tr></td>
	<tr><td>Capacity <input type="text" name="max"></tr></td>
	<tr><td>Airline ID<input type="text" name="airline"></tr></td>
	
	</table>
	<input type="submit" value="Add New Aircraft">
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