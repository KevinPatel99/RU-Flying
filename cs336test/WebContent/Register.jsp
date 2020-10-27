<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Page</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the index.jsp
			String newUsername = request.getParameter("username");
			String newPassword = request.getParameter("password");
			String newEmail = request.getParameter("email");
	
			//Make an insert statement for the account table:
			String insert = "INSERT INTO `Account` VALUES('" + newUsername +"', '" + newPassword + "', 3, NULL, '" + newEmail + "')";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
			ps.executeUpdate();
			//Close the connection. 
			con.close();
			out.println("Registration Complete");
		} catch(Exception ex){
			//out.print(ex);
			out.println("Registration failed; Try again");
		}
%>

<br>
	<form method="post" action="index.jsp">
	<input type="submit" value="Go Back">
	</form>
<br>
</body>
</html>