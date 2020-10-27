<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Deletion Page</title>
</head>
<body>
	<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form
			String newUsername = request.getParameter("username");

			
			//Make a delete statement for the tickets table:
			String str = "delete from `Account` WHERE username = '" + newUsername + "'";
			//Create a SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			//Close the connection. 
			con.close();
			out.println("Deletion successful (if user exists)");
		}
		catch(Exception ex){
			out.println("Deletion failed; please try a user that is in the database.");
		}
%>

<br>
	<form action="EditAddDeleteEmployees.jsp">
		<input type="submit" value = "Return to modifying users page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>