<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Editing User Email Page</title>
</head>
<body>
	<%
			String username = request.getParameter("username");
			String newEmail = request.getParameter("email");


		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	


			
			//Make a delete statement for the tickets table:
			String str = "Update `Account` set email = '" + newEmail + "' where username = '" + username + "'"; 			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			//Close the connection. 
			con.close();
			out.println("Change successful");
		}
		catch(Exception ex){
			//out.print(ex);
			out.println("Change failed; please try an user that exists ");
		}
%>

<br>
	<form method="post" action="editUsername.jsp">
	<input type="hidden" name="username" value=  <%out.print(username); %>>
	<input type="submit" value="Return to editing page">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>