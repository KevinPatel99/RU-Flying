<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Editing Page</title>
</head>
<body>
	
		<%
				//Get parameters from the HTML form
				String newUser = request.getParameter("username");
	try{
		

				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection accountConnect = db.getConnection();		
				
				//Create a SQL statement
				Statement stmt = accountConnect.createStatement();
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "SELECT a.username, a.email, a.class from `Account` a where a.username = '" + newUser + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				//Make an HTML table to show the results in:
				out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print("Username");
				out.print("</th>");
				out.print("<th>");
				out.print("Email");
				out.print("</th>");
				out.print("<th>");
				out.print("Class");
				out.print("</th>");

				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//row
					out.print("<tr>");
					//column

					out.print("<td>");
					out.print(result.getString("username") + "    ");
					out.print("</td>");


					out.print("<td>");
					out.print(result.getString("email") + "    ");
					out.print("</td>");

				
					out.print("<td>");
					out.print(result.getInt("class") + "    ");
					out.print("</td>");


					
					out.print("</tr>");
				}
				out.print("</table>");
				
				//close the connection.
				db.closeConnection(accountConnect);
	}
	catch(Exception ex){
		//out.print(ex);
		out.println("Attempt to show user failed; please try an user that exists.");
	}
%>

Enter the new username and hit "Modify Username"

<br>
	<form method="post" action="editUsernamename.jsp">
	<input type="hidden" name="username" value= <%out.print(newUser); %>>
	<table>
	<tr>
	<td>Username:</td><td><input type="text" name="newUsername"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Username">
	</form>
<br>

Enter the new email and hit "Modify Email"
<br>
	<form method="post" action="editUsernameEmail.jsp">
	<input type="hidden" name="username" value= <%out.print(newUser); %>>
	<table>
	<tr>
	<td>Email:</td><td><input type="text" name="email"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Email">
	</form>
<br>


Enter the new class and hit "Modify Class"
<br>
	<form method="post" action="editUsernameClass.jsp">
	<input type="hidden" name="username" value= <%out.print(newUser); %>>
	<table>
	<tr>
	<td>Class:</td><td><input type="text" name="class"></td>
	</tr>
	</table>
	<input type="submit" value="Modify Class">
	</form>
<br> 



<br>
	<form action="EditAddDeleteEmployees.jsp">
		<input type="submit" value = "Return to modifying employees page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>