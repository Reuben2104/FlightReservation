<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Flight Results</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the selected radio button from the index.jsp
			String flexibleOrNot = request.getParameter("flexible_or_not");
		    String oneOrRound = request.getParameter("one_or_round");
		    String departureAirport = request.getParameter("departure_airport");
		    String arrivalAirport = request.getParameter("arrival_airport");
		    String flightDateStr = request.getParameter("flight_date");
		    String isDomestic = request.getParameter("is_domestic");
			
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Flight WHERE ";
			
			if (flexibleOrNot.equals("1")) { // + or - 3 days
				
				// Parse the flightDate string into a LocalDate object
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				LocalDate flightDate = LocalDate.parse(flightDateStr, formatter);

				// Calculate 3 days before and after
				LocalDate threeDaysBefore = flightDate.minusDays(3);
				LocalDate threeDaysAfter = flightDate.plusDays(3);

				// Convert the results back to strings if needed
				String threeDaysBeforeStr = threeDaysBefore.format(formatter);
				String threeDaysAfterStr = threeDaysAfter.format(formatter);

				// Now you can use threeDaysBefore and threeDaysAfter in your logic
				str += "departure_airport = '" + departureAirport + "' AND destination_airport = '" + 
				arrivalAirport + "' AND is_domestic = '" + isDomestic + "' AND departure_date BETWEEN '" + 
				threeDaysBeforeStr + "' AND '" + threeDaysAfterStr + "' ";

				
			} else {
				
				str += "departure_airport = '" + departureAirport + "' AND destination_airport = '" + 
						arrivalAirport + "' AND is_domestic = '" + isDomestic + "' AND departure_date = '" + flightDateStr + "' ";
			
			}
			
			
			// Execute the SQL query
			// (You should use a PreparedStatement to avoid SQL injection)
			// ...
			
			// Example: Print the final SQL query for debugging purposes
			//System.out.println("Final SQL Query: " + str);
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
		%>
			
		<!--  Make an HTML table to show the results in: -->
		
	<table>
		<tr>    
			<td><u>Flight Number</u></td>
			<td><u>Departure Date</u></td>
			<td><u>Airline</u></td>
			<td><u>Destination Airport</u></td>
			<td><u>Arrival Airport</u></td>
			<td><u>Departure Time</u></td>
			<td><u>Arrival Time</u></td>
			
		</tr>
			<%
			//parse out the results
		
			while (result.next()) {
			
				String flightNumber = result.getString("flight_number");
				String printDate = result.getString("departure_date");
				String printAirline = result.getString("airline_ID");
				String departure = result.getString("departure_airport");
			    String destination = result.getString("destination_airport");
			    String departureTime = result.getString("departure_time");
			    String arrivalTime = result.getString("arrival_time");
			
			%>
			    
			<tr>
		        <td><%= flightNumber %></td>
		        <td><%= printDate %></td>
		        <td><%= printAirline %></td>
		        <td><%= departure %></td>
		        <td><%= destination %></td>
		        <td><%= departureTime %></td>
		        <td><%= arrivalTime %></td>
		    
		        <!-- Add more table cells for additional fields -->
    		</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
	</table>
	
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>