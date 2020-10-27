<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aircraft Editing Page</title>
</head>
<body>
	
		<%
				String newAircraft = request.getParameter("aircraft");
	try{
				ApplicationDB db = new ApplicationDB();	
				Connection accountConnect = db.getConnection();		
				Statement stmt = accountConnect.createStatement();
				//SELECT QUERY
				String str = "SELECT distinct a.aircraftID, a.airlineID, r.airlineName, a.maxCapacity from Aircraft a join Airline r using(airlineID) where a.aircraftID = '" + newAircraft + "'";
				ResultSet result = stmt.executeQuery(str);
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
				while (result.next()) {
					//row
					out.print("<tr>");
					//column

					out.print("<td>");
					out.print(result.getInt("aircraftID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result.getInt("maxCapacity") + "    ");
					out.print("</td>");
				
					out.print("<td>");
					out.print(result.getString("airlineID") + "    ");
					out.print("</td>");

					out.print("<td>");
					out.print(result.getString("airlineName") + "    ");
					out.print("</td>");
				
					out.print("</tr>");
				}
				out.print("</table>");
				db.closeConnection(accountConnect);
	}
	catch(Exception ex){
		//out.print(ex);
		out.println("Attempt to show aircrafy; please try an aircraft that exists.");
	}
%>

<br>
Enter the new aircraft number and click on "Modify Aircraft Number"

<br>
	<form method="post" action="editAircraftNumber.jsp">
	<input type="hidden" name="aircraft" value= <%out.print(newAircraft); %>>
	<table>
	<tr>
	<td>Flight Number</td><td><input type="text" name="newAircraft"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Aircraft Number">
	</form>
<br>

Enter the new capacity and click on "Modify Capacity"
<br>
	<form method="post" action="editAircraftCapacity.jsp">
	<input type="hidden" name="aircraft" value= <%out.print(newAircraft); %>>
	<table>
	<tr>
	<td>Capacity:</td><td><input type="text" name="newCapacity"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Capacity">
	</form>
<br>

List of all Airlines
				<%
				ApplicationDB db2 = new ApplicationDB();	
				Connection accountConnect2 = db2.getConnection();		
				Statement stmt2 = accountConnect2.createStatement();
				String str2 = "SELECT distinct r.airlineID, r.airlineName from Airline r order by r.airlineID ";
				ResultSet result2 = stmt2.executeQuery(str2);
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

<br>
Enter the new airline ID and click the "Modify Airline" button
<br>
	<form method="post" action="editAircraftAirline.jsp">
	<input type="hidden" name="aircraft" value= <%out.print(newAircraft); %>>
	<table>
	<tr>
	<td>Airline:</td><td><input type="text" name="newAirline"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Airline">
	</form>
<br> 



<br>
	<form action="editAddDelAircraft.jsp">
		<input type="submit" value = "Return to modifying aircrafts page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>