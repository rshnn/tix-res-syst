<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Order</title>
</head>
<body>
	<br>
<h1 align="center">Ticket Reservation System</h1>
<h2 align="center">Manager Home Page</h2>
<h4 align="right"> Logged in as 
<%=session.getAttribute("username")%> (<%=session.getAttribute("userType") %>).
</h4>
<div align="right"><a href='../LogOut.jsp'>Log out</a></div>


<h3>Customer Management</h3>

<h4>Enter user to search all order</h4>

	<form method="post" action="ShowOrderByCustomer.jsp">			
		
		<table>
			<tr>
				<td>Username</td>
				<td><input type="text" name="Username" maxlength="25"
					required></td>
			</tr>
		</table>
		<br> <input type="submit" value="Search">
	</form>
	<br><br><br>
	<a href="../HomePages/CustomerRepHome.jsp">Back to Customer Rep Home</a>

</body>
</html>