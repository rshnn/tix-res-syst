<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Viewing Reservation</title>
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
<div align='right'><a href="../HomePages/CustomerRepHome.jsp">Back to Customer Rep Home</a></div> <br>

<h4>List of all reservations in the system.</h4>

<%

/* try{ */

	
		String url = "jdbc:mysql://mydbinstance.cvlvoepmucx7.us-east-2.rds.amazonaws.com:3306/trs";
		Connection connection = null;
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(url, "rshn", "youknownothingJonSnow");
		
		Statement statement = connection.createStatement();
		
		/* Big ass query.  Joins tables and merges days_occurs into one column */
		String command = "select username, resNo, dateReserved, concat(airlineID, flightNumber) flightinfo, dominter, "+ 
				"passengers, group_concat(ticketID) ticketID, group_concat(seatNo) seatNos, group_concat(meal) meal, totalFare, bookingFee, type "+
				"from Purchases "+
					"join Reservations using (resNo) "+
				    "join Tickets using (ticketID) "+
				    "join Users using (username) "+
				    "join Flight_operates using (airlineID, flightNumber) "+
				    "group by resNo";
		ResultSet result = statement.executeQuery(command);

		/*"+ request.getParameter("username") +"  */
		//Make an HTML table to show the results in:
		out.print("<table border='1'>");

		//make a row
		out.print("<tr>");
		
		//make a column
		out.print("<td>");
		out.print("username");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Reservation Number");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Reservation Date");
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
		out.print("Passenger Count");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Ticket ID");
		out.print("</td>");

		//make a column
		out.print("<td>");
		out.print("Total Fare");
		out.print("</td>");
		

		//make a column
		out.print("<td>");
		out.print("Booking Fee");
		out.print("</td>");
		
		
		//make a column
		out.print("<td>");
		out.print("Reservation Type");
		out.print("</td>");
		
		out.print("</tr>");
		
		
		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("username"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("resNo"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("dateReserved"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("flightinfo"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("dominter"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("passengers"));
			out.print("</td>");
			out.print("<td>");			
			out.print(result.getString("ticketID"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("totalFare"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("bookingFee"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("type"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		
		result.close();
		statement.close();
		connection.close();
		
/* } catch (Exception e){
	
} */

%>

<br><br><br>
<a href="../HomePages/CustomerRepHome.jsp">Back to Customer Rep Home</a>


</body>
</html>
