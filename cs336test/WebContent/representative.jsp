<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Customer Representative</title>
</head>
<body>
<br>

Please log in to view your account information:
<br>
	<form method="post" action="Login.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Login">
	</form>
<br>

In order to edit, add, or delete aircrafts:
<br>
	<form method="post" action="editAddDelAircraft.jsp">
	<input type="submit" value="Edit, Add, or Delete Aircrafts">
	</form>
<br>

In order to edit add, or delete airports:
<br>
	<form method="post" action="editAddDelAirport.jsp">
	<input type="submit" value="Edit, Add, or Delete Airports">
	</form>
<br>

If you would like to edit, add, or delete flights:
<br>
	<form method="post" action="editAddDelFlight.jsp">
	<input type="submit" value="Edit, Add, or Delete Flights">
	</form>
<br>

If you would like to edit add, or delete a trip: 
<br>
	<form method="post" action="editAddDelTrip.jsp">
	<input type="submit" value="Edit, Add, or Delete Trips">
	</form>
<br>

Display the wait-list for a particular flight: 
<br>
	<form method="post" action="showWaitlist.jsp">
	<td>Flight Number:</td><td><input type="text" name="flight"></td>
	<input type="submit" value="Display waitlist">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>


</body>
</html>