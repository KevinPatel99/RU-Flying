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
			String newEmail = request.getParameter("email");
			String newClass = request.getParameter("class");
			
			//Make a delete statement for the tickets table:
			String str = "insert into `Account` (`username`, `email`, `class`) select '" + newUsername + "', '" + newEmail + "', " + newClass;
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			//Close the connection. 
			con.close();
			out.println("Insert successful");
		}
		catch(Exception ex){
			//out.print(ex);
			out.println("Insertion failed; please try another username.");
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