<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<title>Edit, Add, or Delete Accounts</title>
</head>
<body>
<br>


All registered accounts are shown below. <br>
Level 1 = Admin <br> 
Level 2 = Employee <br>
Level 3 = Users <br>
<br>
<% 
				
				//Get the database connection
				ApplicationDB dbs = new ApplicationDB();	
				Connection accountConnection = dbs.getConnection();		
				
				//Create a SQL statement
				Statement stmt3 = accountConnection.createStatement();
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str3 = "SELECT  a.username, a.email, a.class from `Account` a order by a.class ";
				//Run the query against the database.
				ResultSet result3 = stmt3.executeQuery(str3);
				
				//Make an HTML table to show the results in:
				out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("username");
				out.print("</th>");
				out.print("<th>");
				out.print("email");
				out.print("</th>");
				out.print("<th>");
				out.print("class");
				out.print("</th>");
				out.print("</tr>");

				//parse out the results
				while (result3.next()) {
					//row
					out.print("<tr>");
					//column

					out.print("<td>");
					out.print(result3.getString("username") + "    ");
					out.print("</td>");


					out.print("<td>");
					out.print(result3.getString("email") + "    ");
					out.print("</td>");

				
					out.print("<td>");
					out.print(result3.getInt("class") + "    ");
					out.print("</td>");

				

					
					out.print("</tr>");
				}
				out.print("</table>");
				
				//close the connection.
				dbs.closeConnection(accountConnection);
%>
<br>
Type out a Username (case sensitive) for an account that you want to delete, then click on "Delete"
<br>
	<form method="post" action="deleteUsername.jsp">
	<table>
	<tr>
	<td>Username: </td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="Delete">
	</form>
<br>

Type out a Username (case sensitive) for an account that you want to edit, then click on "Edit"

<br>
	<form method="post" action="editUsername.jsp">
	<table>
	<tr>
	<td>Username: </td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="Edit">
	</form>
<br>



Add an account to the Database
<br>
	<form method="post" action="addUsername.jsp">
	<table>
	<tr><td>Username <input type="text" name="username"></tr></td>
	<tr><td>E-mail <input type="text" name="email"></tr></td>
	<tr><td>Class <input type="text" name="class"></tr></td>
	
	</table>
	<input type="submit" value="Add New User">
	</form>
<br>

<form method="post" action="admin.jsp">
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