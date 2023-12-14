
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Representative Actions</title>
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
            
            
            
        	if ("deleteReservationForUser".equals(action)) {
				Integer ticketNumber = Integer.parseInt(request.getParameter("ticketNumber"));
            	String username = request.getParameter("username");

				
			    // Delete related rows from the bookings table first
			    PreparedStatement deleteBookings = con.prepareStatement("DELETE FROM bookings WHERE ticket_number = ? AND username = ?");
			    deleteBookings.setInt(1, ticketNumber);
			    deleteBookings.setString(2, username);
			    deleteBookings.executeUpdate();
			    
			 // Delete related rows from the bookings table first
			    PreparedStatement deleteFlightCapacity = con.prepareStatement("DELETE FROM flightcapacity WHERE ticket_number = ?");
			    deleteFlightCapacity.setInt(1, ticketNumber);
			    deleteFlightCapacity.executeUpdate();

			    
            	pstmt = con.prepareStatement("DELETE FROM ticket WHERE ticket_number = ?");
            	pstmt.setInt(1, ticketNumber);
           		pstmt.executeUpdate();
            	out.println("<p> Booking deleted successfully. Please use the link above to make a new reservation.</p>");
                
            } 
        } catch (SQLException e) {
            out.println("Database error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    %>
    <a href="makeReservation.jsp">[Make a New Reservation for User]</a>
    <a href="customerRep.jsp">[Back to Customer Representative Dashboard]</a>

</body>
</html>