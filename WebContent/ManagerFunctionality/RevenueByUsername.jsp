<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Orders by Customer</title>
</head>
<body>


<h1 align="center">Ticket Reservation System</h1>
<h2 align="center">Customer Rep Home Page</h2>
<h4 align="right"> Logged in as 
<%=session.getAttribute("username")%> (<%=session.getAttribute("userType") %>).
</h4>
<div align="right"><a href='../LogOut.jsp'>Log out</a></div>


<h3>Revenue</h3>

<h4>Revenue from customer: <%=request.getParameter("username")%></h4>
<%

try{
		String username = request.getParameter("username");
		int totalRev = 0;
		
		String url = "jdbc:mysql://mydbinstance.cvlvoepmucx7.us-east-2.rds.amazonaws.com:3306/trs";
		Connection connection = null;
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(url, "rshn", "youknownothingJonSnow");
		
		Statement statement = connection.createStatement();
		String command = "select username, firstName, lastName, email, group_concat(resNo) r, group_concat(tix) t, sum(totalFare) tF, sum(bookingFee) rev " +
				"from " +
				"( " +
				"select username, firstName, lastName, email, resNo, group_concat(ticketID) tix,  totalFare, bookingFee " +
				"from Purchases  " +
				"join Reservations using(resNo) " +
				"join Users using (username) " +
				"where username='"+username+"' " +
				"group by resNo " +
				") A " +
				"group by username";
		
		ResultSet result = statement.executeQuery(command);

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
		out.print("First Name");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Last Name");
		out.print("</td>");

		//make a column
		out.print("<td>");
		out.print("email");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Reservation Numbers");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("TicketIDs");
		out.print("</td>");
		
		//make a column
		out.print("<td>");
		out.print("Total of Fares Paid");
		out.print("</td>");

		//make a column
		out.print("<td>");
		out.print("Revenue from Fees");
		out.print("</td>");
		
		out.print("</tr>");
		
		String firstName = "";
		String lastName = "";
		//parse out the results
		while (result.next()) {
			
			firstName = result.getString("firstName");
			lastName = result.getString("lastName");
			
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("username"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("firstName"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("lastName"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("email"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r"));
			out.print("</td>");
			out.print("<td>");			
			out.print(result.getString("t"));
			out.print("</td>");
			out.print("<td>");			
			out.print(result.getString("tF"));
			out.print("</td>");
			out.print("<td>");			
			out.print(result.getString("rev"));
			out.print("</td>");
			out.print("</tr>");
			
			totalRev = totalRev + result.getInt("rev");
		}
		out.print("</table>");
		
		out.println("<br><br>Generated $"+totalRev+" from customer " + firstName + " " + lastName);
		result.close();

		statement.close();
		connection.close();
} catch (Exception e){
	
}

%>
<br><br>
<a href="../HomePages/ManagerHome.jsp">Back to Manager Home</a>


</body>
</html>