
<%@ page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>List of Flight Actions</title>
</head>
<body>
    <%
        String action = request.getParameter("action");
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "LogMe@2021");
            
        	//Adding flight
       
            if ("listFlights".equals(action)) {
            	String airportID = request.getParameter("airportID");
                String query = "SELECT * FROM Flight WHERE departure_airport = ? OR destination_airport = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, airportID);
                pstmt.setString(2, airportID);
                rs = pstmt.executeQuery();
                    
            	
            		%>
            		
            		<table>
            	
            		<tr>    
            			<td><u>Flight Number</u></td>
            			<td><u>Departure Date</u></td>
            			<td><u>Departure Airport</u></td>
            			<td><u>Destination Airport</u></td>
            			<td><u>Departure Time</u></td>
            			<td><u>Arrival Time</u></td>
            			<td><u>Is Domestic (1 = is Domestic, 0 = is not Domestic)</u></td>
            			<td><u>Airline ID</u></td>
            			<td><u>Price</u></td>
        			
            		</tr>
            		
            	<%
            		
            	while (rs.next()) {
            			
            		Integer flightNum = rs.getInt("flight_number");
            		java.sql.Date departureDate = rs.getDate("departure_date");
            		String departureAirport = rs.getString("departure_airport");
            		String destinationAirport = rs.getString("destination_airport");
            		java.sql.Time departureTime = rs.getTime("departure_time");
            		java.sql.Time arrivalTime = rs.getTime("arrival_time");
            		Integer isDomestic = rs.getInt("is_domestic");
            		String airlineID = rs.getString("airline_ID");
            		Float price = rs.getFloat("price");
            				
            			
            	%>
            			    
            			<tr>
            		        <td><%= flightNum %></td>
            		        <td><%= departureDate %></td>
            		        <td><%= departureAirport %></td>
            		        <td><%= destinationAirport %></td>
            		        <td><%= departureTime %></td>
            		        <td><%= arrivalTime %></td>
            		        <td><%= isDomestic %></td>
            		        <td><%= airlineID %></td>
            		        <td><%= price %></td>
            			</tr>
            				
            	<% 
            			
            	}

            	%>
            			
            	</table>
            	
            	<%
            	
            } } catch (SQLException e) {
                	 out.println("Database error: " + e.getMessage());
                }  finally {
                	if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                }
                
                %>
    <a href="customerRep.jsp">Back to Customer Representative Dashboard</a>

</body>
</html>