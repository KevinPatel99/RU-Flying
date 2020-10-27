<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Project</title>
</head>
<body>
<br>
Login with your username and password!
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
Register with your username and password and information!
<br>
	<form method="post" action="Register.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	<tr>
	<td>Email Address</td><td><input type="text" name="email"></td>
	</tr>
	</table>
	<input type="submit" value="Register">
	</form>
<br>
	<form method="post" action="show.jsp">
	<input type="radio" name="command" value="Account"/>Show all usernames and associated passwords and information!
<br>
	<input type="submit" value="This feature is for demonstration purposes only" />
</form>
<br>

</body>
</html>