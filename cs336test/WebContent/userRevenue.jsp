<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airport Flights Page</title>
</head>
<body>
	
		<%
				//Get parameters from the HTML form
				String newAirport = request.getParameter("username");
	try{
		

				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection accountConnect = db.getConnection();		
				
				//Create a SQL statement
				Statement stmt = accountConnect.createStatement();
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "select t.username, t.worth from (select sum(r.price) as worth, a.username from `Account` a join `Ticket` t using (username) join (select distinct * from`Trip`) r using (tripID) group by a.username) as t where t.username = '" + newAirport + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				//Make an HTML table to show the results in:
				out.print("<table style=\"width:100%\">");
				
				//row
				out.print("<tr>");
				//columns and headers
				out.print("<th>");
				out.print(newAirport);
				out.print("</th>");



				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//row
					out.print("<tr>");
					//column

					out.print("<td>");
					out.print(result.getInt("worth") + "    ");
					out.print("</td>");

					
					out.print("</tr>");
				}
				out.print("</table>");
				
				//close the connection.
				db.closeConnection(accountConnect);
	}
	catch(Exception ex){
		//out.print(ex);
		out.println("Attempt to show airport failed; please try an airport ID that exists.");
	}
%>





<br>
	<form action="admin.jsp">
		<input type="submit" value = "Return to admin page.">
	</form>
<br>

<form method="post" action="index.jsp">
	<br>
	<input type="submit" value="Logout" />
</form>
<br>
</body>
</html>