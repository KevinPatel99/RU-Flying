<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Form</title>
</head>
<body>
	<%
	int temp = 0;
	String existsPassword;
	String existsUsername;
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();		
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		existsUsername = request.getParameter("username");
		existsPassword = request.getParameter("password");


		//Make an select statement
		String select = "SELECT class FROM Account WHERE username = '" + 
			existsUsername + "' AND password = '" + existsPassword + "'";

		//Create a ResultSet SQL statement allowing you to execute th query
        ResultSet rs = stmt.executeQuery(select);
        while (rs.next()) {
            int existsInformation = rs.getInt("class");
            temp = existsInformation;
        }
        
		//Close the connection. 
		con.close();

		if(temp == 0){
			out.print("Wrong username/password combination. Try again.");
			
		}
		else{
			if(temp==1){
				session.setAttribute("user", existsUsername); // the username will be stored in the session
			%>
			Welcome Admin <%=session.getAttribute("user")%> <br>
			<form action="admin.jsp">
		    	<input type="submit" value = "Proceed to your admin page.">
			</form>
			<% 
			}
			else if(temp == 2){
				session.setAttribute("user", existsUsername); // the username will be stored in the session
			%>
			Welcome Representative <%=session.getAttribute("user")%>
			<form action="representative.jsp">
				<input type="submit" value = "Proceed to your representative page.">
			</form>
			<% 				
			}
			else{
				session.setAttribute("user", existsUsername); // the username will be stored in the session
			%>
			Welcome User <%=session.getAttribute("user")%>
			<form action="customer.jsp">
				<input type="hidden" name="username" value=<%out.print(existsUsername); %>>
				<input type="hidden" name="password" value=<%out.print(existsPassword);%>>
				<input type="submit" value = "Proceed to your customer page.">
			</form>
			<% 
			
			}
		
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
	%>
<br>
	<form method="post" action="logout.jsp">
	<input type="submit" value="Sign out">
	</form>
<br>
</body>
</html>