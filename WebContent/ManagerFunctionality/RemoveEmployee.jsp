<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remove Employee</title>
</head>
<body>

	<h1 align="center">Employee Management</h1>
	
	<div align="right"> <b> Logged in as 
	<%=session.getAttribute("username")%> (<%=session.getAttribute("userType") %>).
	</b> <br>
	<a href='../LogOut.jsp'>Log out</a>
	</div>
	
	<% 
	String url = "jdbc:mysql://mydbinstance.cvlvoepmucx7.us-east-2.rds.amazonaws.com:3306/trs";
		Connection connection = null;
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(url, "rshn", "youknownothingJonSnow");
		String username = request.getParameter("Username");
		
		Statement statement = connection.createStatement();
		String command = "SELECT * FROM Users WHERE username='"+username+"' AND userType!='Customer'";
		ResultSet result = statement.executeQuery(command);
		
			
		if (result.next()) {
			/* Get role and username.  Add to session */

			command = "DELETE FROM Users WHERE username='"+username+"'";
			statement.executeUpdate(command);
			
			
			out.println("Employee deleted.");
		} else {
			out.println("Employee doesn't exist.");
		}
		
		result.close();
		statement.close();
		connection.close();
	%>
	<br><a href="../HomePages/ManagerHome.jsp">Back to Manager Home</a>
			
</body>
</html>