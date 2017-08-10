<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manager Home</title>
</head>
<body>


<h1 align="center">Ticket Reservation System</h1>
<h2 align="center">Manager Home Page</h2>

<div align="right"> <b> Logged in as 
<%=session.getAttribute("username")%> (<%=session.getAttribute("userType") %>).
</b> <br>
<a href='../LogOut.jsp'>Log out</a>
</div>

<h3>Flight Information</h3>
<div align='right'><a href="../HomePages/CustomerHome.jsp">Back to Customer Home</a></div> <br>

<h4>List of best seller flights </h4>

<%

try{
		String url = "jdbc:mysql://mydbinstance.cvlvoepmucx7.us-east-2.rds.amazonaws.com:3306/trs";
		Connection connection = null;
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(url, "rshn", "youknownothingJonSnow");
		
		Statement statement = connection.createStatement();
		
		/* Big ass query.  Joins tables and merges days_occurs into one column */
		String command = "select name, concat(airlineID, flightNumber) flight, dominter, count(*) tixSold " +
				"from Purchases  " +
				"join Flight_operates using (airlineID, flightNumber) " +
				"join Airlines using (airlineID)  " +
				"group by flightNumber, airlineID " +
				"order by tixSold desc";
		ResultSet result = statement.executeQuery(command);

		
		//Make an HTML table to show the results in:
		out.print("<table border='1'>");

		//make a row
		out.print("<tr>");
		
		//make a column
		out.print("<td>");
		out.print("Airline Name");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Flight");
		out.print("</td>");

		//make a column
		out.print("<td>");
		out.print("Domestic/International");
		out.print("</td>");
		
	
		//make a column
		out.print("<td>");
		out.print("Tickets Sold");
		out.print("</td>");
		
		out.print("</tr>");
		
		
		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("flight"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("dominter"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tixSold"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		
		result.close();
		statement.close();
		connection.close();
		
} catch (Exception e){
	
}

%>

<br><br><br>
<a href="../HomePages/CustomerHome.jsp">Back to Customer Home</a>


</body>
</html>

