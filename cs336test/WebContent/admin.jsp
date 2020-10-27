<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Admin Page</title>
</head>
<body>
<br>
Edit, Add, or Delete Employee/User Accounts:
<br>
	<form method="post" action="EditAddDeleteEmployees.jsp"> <!-- Manav -->
	<input type="submit" value="Edit, Add, or Delete Employees/users">
	</form>
<br>

<form method="post" action="salesReport.jsp">
		<table>
		<br>Obtain a sales report for a particular month <br>
		<br>Please enter the month and year of the sales reports you want for (MM, YYYY):<br>
			<tr>    
				<td><input type="text" name="month">		<input type = "text" name = "year"></td>
			</tr>
		</table>
	
	</form>

Produce a list of reservations by `Flight Number`
<br>
	<form method="post" action="flightReservations.jsp">
	<table>
	<tr>
	<td>Flight Number:</td><td><input type="text" name="flight"></td>
	</tr>
	</table>
	<input type="submit" value="List of reservations">
	</form>
<br> 



Produce a list of reservations by `Customer Username`
<br>
	<form method="post" action="userReservations.jsp">
	<table>
	<tr>
	<td>Username:</td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="List of reservations">
	</form>
<br>

Produce a listing of revenue generated by a particular flight, airline, or customer <br>
Revenue generated by `Flight`
<br>
	<form method="post" action="flightRevenue.jsp">
	<table>
	<tr>
	<td>Flight Number:</td><td><input type="text" name="flight"></td>
	</tr>
	</table>
	<input type="submit" value="Revenue">
	</form>
<br>  
Revenue generated by an `Airline`
<br>
	<form method="post" action="airlineRevenue.jsp">
	<table>
	<tr>
	<td>Airline ID:</td><td><input type="text" name="airline"></td>
	</tr>
	</table>
	<input type="submit" value="Revenue">
	</form>
<br> 
Revenue generated by an `User`
<br>
	<form method="post" action="userRevenue.jsp">
	<table>
	<tr>
	<td>Username:</td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="Revenue">
	</form>
<br> 

<% String profitPerson = "";
String str = "select t.username, max(t.worth) from (select sum(r.price) as worth, a.username from `Account` a join `Ticket` t using (username) join (select distinct * from`Trip`) r using (tripID) group by a.username) as t";
ApplicationDB db = new ApplicationDB();	
Connection accountConnect = db.getConnection();		

//Create a SQL statement
Statement stmt = accountConnect.createStatement();
//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
//Run the query against the database.
ResultSet result = stmt.executeQuery(str);
while (result.next()) {
	profitPerson = result.getString("username");
	}
db.closeConnection(accountConnect);

%>

Customer which generated most total revenue <br>
Most profitable customer is <%out.println(profitPerson);
out.println();%>
<br>
<br>

List of most active flights (by most tickets sold):
<%
String str2 = "select t.flightID, count(t.flightID) count from `Trip` t group by t.flightID";
ApplicationDB db2 = new ApplicationDB();	
Connection accountConnect2 = db2.getConnection();		

//Create a SQL statement
Statement stmt2 = accountConnect2.createStatement();
//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
//Run the query against the database.
ResultSet result2 = stmt2.executeQuery(str2);
//Make an HTML table to show the results in:
out.print("<table style=\"width:100%\">");
out.print("<tr>");
out.print("<th>");
out.print("Flight");
out.print("</th>");
out.print("<th>");
out.print("Number of flights");
out.print("</th>");

out.print("</tr>");
while (result2.next()) {
	//row
	out.print("<tr>");
	//column

	out.print("<td>");
	out.print(result2.getInt("flightID") + "    ");
	out.print("</td>");


	out.print("<td>");
	out.print(result2.getInt("count") + "    ");
	out.print("</td>");



	
	out.print("</tr>");
}
out.print("</table>");
db2.closeConnection(accountConnect2);
%>

List of flights in airport:
<br>
	<form method="post" action="airportFlights.jsp">
	<table>
	<tr>
	<td>Airport ID:</td><td><input type="text" name="airport"></td>
	</tr>
	</table>
	<input type="submit" value="List">
	</form>
<br> 




</body>
</html>