<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Show all the usernames and passwords</title>
</head>
<body>

	
	<% 
		try{
			// Get the connection to the database
			ApplicationDB db = new ApplicationDB();	
			Connection accountConnect = db.getConnection();	
				
			//Create a SQL statement
			Statement stmt = accountConnect.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//row
			out.print("<tr>");
			//columns and headers
			out.print("<td>");
			out.print("Username");
			out.print("</td>");
			out.print("<td>");
			out.print("<td>");
			out.print("Password");
			out.print("</td>");
			out.print("<td>");
			out.print("Email");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//row
				out.print("<tr>");
				//column
				out.print("<td>");
				//Print out username:
				out.print(result.getString("username") + "    ");
				out.print("</td>");
				out.print("<td>");
				out.print("<td>");
				//Print out password and information
				out.print(result.getString("password") + "    ");
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("email") + "    ");
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");

			//close the connection.
			db.closeConnection(accountConnect);
			
		} catch (Exception e){
			out.print("Failed\n");
		}
	
	 %>
<br>
	 <form method="post" action="index.jsp">
	 <input type="submit" value="Go Back">
	 </form>
<br>

</body>
</html>