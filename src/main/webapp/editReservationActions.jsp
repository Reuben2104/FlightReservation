
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.sql.Timestamp" %>


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
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        PreparedStatement pstmt4 = null;
        PreparedStatement pstmt5 = null;

        PreparedStatement pstmt12 = null;
        PreparedStatement pstmt22 = null;
        PreparedStatement pstmt32 = null;
        PreparedStatement pstmt42 = null;
        PreparedStatement pstmt52 = null;

        
        
        ResultSet rs = null;


        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "LogMe@2021");
 
           	 if ("editReservationForUser".equals(action)) {     
           		//Required
           		Integer ticketNumber = Integer.parseInt(request.getParameter("ticketNumber"));
            	String username = request.getParameter("username");
            	Integer flightNum = Integer.parseInt(request.getParameter("flightNumber"));
            	
            	//Not required
            	String flightNum2String = request.getParameter("flightNumber2");
            	String firstName = request.getParameter("firstName");
            	String lastName = request.getParameter("lastName");
            	String passengerIDString = request.getParameter("passengerID");
            	String classString = request.getParameter("class_type");
            	String classString2 = request.getParameter("class_type2");
            	
           	// Create an SQL update query
           		String updateQuery = "UPDATE Ticket SET ";

           		// Initialize a flag to check if any fields need to be updated
           		boolean updateNeeded = false;
      
           		if (firstName != null && !firstName.isEmpty()) {
           		    updateQuery += "fname = '" + firstName + "', ";
           		    updateNeeded = true;
           		}

           		if (lastName != null && !lastName.isEmpty()) {
           		    updateQuery += "lname = '" + lastName + "', ";
           		    updateNeeded = true;
           		}

           		if (passengerIDString != null && !passengerIDString.isEmpty()) {
           			Integer passengerID = Integer.parseInt(passengerIDString);
           		    updateQuery += "passenger_id = " + passengerID + ", ";
           		    updateNeeded = true;
           		}
           		
           		if(classString != null && !classString.isEmpty()){
           			
           			//Intialize
           			Float oldFare = null;
           			Float newFare = null;
           			Float priceForFlight = null;
           			
           			//Get old total fare
					String query1 = "SELECT * FROM Ticket WHERE ticket_number = ?";
           			
           			pstmt1 = con.prepareStatement(query1);
           		 	pstmt1.setInt(1, ticketNumber);
           		 	ResultSet classResult1 = pstmt1.executeQuery();
           		 	
           		 	if(classResult1.next()){
           		 		oldFare = classResult1.getFloat("total_fare");
           		 		
           		 	}
           		 	
           		 	//Get old price for this specific flight
           		 	
           		 	String query2 = "SELECT * FROM Flight WHERE flight_number = ?";
        			
        			pstmt2 = con.prepareStatement(query2);
        		 	pstmt2.setInt(1, flightNum);
        		  
        		 	ResultSet classResult2 = pstmt2.executeQuery();
        		 	
        		 	if(classResult2.next()){
        		 		priceForFlight = classResult2.getFloat("price");
        		 	}
        		 	
           		 	//Get old class
           			String query3 = "SELECT * FROM FlightCapacity WHERE ticket_number = ? AND flight_number = ?";
           			
           			pstmt3 = con.prepareStatement(query3);
           		 	pstmt3.setInt(1, ticketNumber);
           		 	pstmt3.setInt(2, flightNum);
        

           		 	ResultSet classResult3 = pstmt3.executeQuery();
           		 	
           		 	
           		 	if(classResult3.next()){
           		 		String oldClass = classResult3.getString("class");
           		 		
           		 		
           		 		if(oldClass.equalsIgnoreCase("Business")){
           		 			oldFare = (float) (oldFare - (priceForFlight * 1.05));
           		 		}
           		 		
           		 		else if(oldClass.equalsIgnoreCase("First")){
           		 			oldFare = (float) (oldFare - (priceForFlight * 1.1));
       		 			} else if(oldClass.equalsIgnoreCase("Economy")){
       		 				oldFare = (float) (oldFare - priceForFlight);
       		 			}
           		 	}
           			
           		 	//Check new class and change the updated price for flight per class
           		 	if(classString.equalsIgnoreCase("Business")){
           		 			priceForFlight = (float) (priceForFlight * 1.05);
           		 		
           		 	} else if(classString.equalsIgnoreCase("First")){
           		 			priceForFlight = (float) (priceForFlight * 1.1);
           		 		
           		 	}
           		 	
           		 	//Add the new price back
           		 	newFare = oldFare + priceForFlight;
           		 	
           		 	String query4 = "UPDATE TICKET SET total_fare = ? WHERE ticket_number = ?";
        			pstmt4 = con.prepareStatement(query4);
        			pstmt4.setFloat(1, newFare);
        		 	pstmt4.setInt(2, ticketNumber);
        		    pstmt4.executeUpdate();
        		    
        		    String query5 = "UPDATE FlightCapacity SET class = ? WHERE ticket_number = ? and flight_number = ?";
        			pstmt5 = con.prepareStatement(query5);
        			pstmt5.setString(1, classString);
        		 	pstmt5.setInt(2, ticketNumber);
        		 	pstmt5.setInt(3, flightNum);
        		    pstmt5.executeUpdate();

           			
           		}
			if(classString2 != null && !classString2.isEmpty() && !flightNum2String.isEmpty()){
					Integer flightNum2 = Integer.parseInt(flightNum2String);
           			
           			Float oldFare2 = null;
           			Float newFare2 = null;
           			Float priceForFlight2 = null;
           			
           			//Get old total fare
					String query12 = "SELECT * FROM Ticket WHERE ticket_number = ?";
           			
           			pstmt12 = con.prepareStatement(query12);
           		 	pstmt12.setInt(1, ticketNumber);


           		 	ResultSet classResult12 = pstmt12.executeQuery();
           		 	
           		 	if(classResult12.next()){
           		 		oldFare2 = classResult12.getFloat("total_fare");
           		 	}
           		 	
           		 	//Get old price for this specific flight
           		 	
           		 	String query22 = "SELECT * FROM Flight WHERE flight_number = ?";
        			
        			pstmt22 = con.prepareStatement(query22);
        		 	pstmt22.setInt(1, flightNum2);


        		 	ResultSet classResult22 = pstmt22.executeQuery();
        		 	
        		 	if(classResult22.next()){
        		 		priceForFlight2 = classResult22.getFloat("price");
        		 	}
        		 	
           		 	//Get old class
           			String query32 = "SELECT * FROM FlightCapacity WHERE ticket_number = ? AND flight_number = ?";
           			
           			pstmt32 = con.prepareStatement(query32);
           		 	pstmt32.setInt(1, ticketNumber);
           		 	pstmt32.setInt(2, flightNum2);


           		 	ResultSet classResult32 = pstmt32.executeQuery();
           		 	
           		 	if(classResult32.next()){
           		 		String oldClass2 = classResult32.getString("class");
           		 		
           		 		if(oldClass2.equalsIgnoreCase("Business")){
           		 			oldFare2 = (float) (oldFare2 - (priceForFlight2 * 1.05));
           		 		}
           		 		
           		 		else if(oldClass2.equalsIgnoreCase("First")){
           		 			oldFare2 = (float) (oldFare2 - (priceForFlight2 * 1.1));
       		 			}
           		 		
           		 		else if(oldClass2.equalsIgnoreCase("Economy")){
   		 					oldFare2 = (float) (oldFare2 - priceForFlight2);
   		 				}
           		 	}
           			
           		 	//Check new class and change the updated price for flight per class
           		 	if(classString2.equalsIgnoreCase("Business")){
           		 			priceForFlight2 = (float) (priceForFlight2 * 1.05);
           		 		
           		 	} else if(classString.equalsIgnoreCase("First")){
           		 			priceForFlight2 = (float) (priceForFlight2 * 1.1);
           		 		
           		 	}
           		 	
           		 	//Add the new price back
           		 	newFare2 = oldFare2 + priceForFlight2;
           		 	
           		 	String query42 = "UPDATE TICKET SET total_fare = ? WHERE ticket_number = ?";
        			pstmt42 = con.prepareStatement(query42);
        			pstmt42.setFloat(1, newFare2);
        		 	pstmt42.setInt(2, ticketNumber);
					
        		    String query52 = "UPDATE FlightCapacity SET class = ? WHERE ticket_number = ? and flight_number = ?";
        			pstmt52 = con.prepareStatement(query52);
        			pstmt52.setString(1, classString);
        		 	pstmt52.setInt(2, ticketNumber);
        		 	pstmt52.setInt(3, flightNum);
        		    pstmt52.executeUpdate();

           		}
           		
           		// Remove the trailing comma and space if any fields are updated
           		if (updateNeeded) {
           		    updateQuery = updateQuery.substring(0, updateQuery.length() - 2);
           		    // Add the WHERE clause to specify the flight number and airline ID
           		    updateQuery += " WHERE ticket_number = ?";
           		    
           		    // Execute the update query
           		    pstmt = con.prepareStatement(updateQuery);
           		 	pstmt.setInt(1, ticketNumber);
           		    pstmt.executeUpdate();

           		    // Output a success message
           		    out.println("<p>Ticket Reservations details updated successfully.</p>");
           		}
           		
           		
           	 }
          
        } catch (SQLException e) {
            out.println("Database error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (pstmt1 != null) pstmt1.close();
            if (pstmt2 != null) pstmt2.close();
            if (pstmt3 != null) pstmt3.close();
            if (pstmt4 != null) pstmt4.close();
            if (pstmt12 != null) pstmt12.close();
            if (pstmt22 != null) pstmt22.close();
            if (pstmt32 != null) pstmt32.close();
            if (pstmt42 != null) pstmt42.close();
            if (con != null) con.close();
        }
    %>
    <a href="customerRep.jsp">Back to Customer Representative Dashboard</a>

</body>
</html>