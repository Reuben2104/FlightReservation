
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
            
        	//Adding flight
       
            if ("addFlight".equals(action)) {
            	Integer flightNumber = Integer.parseInt(request.getParameter("flightNumber"));
            	String airlineID = request.getParameter("airlineID");
            	
            	//Parsing into Date
            	String departureDateString = request.getParameter("departureDate");
            	java.sql.Date departureDate = null;
            	
            	if(!departureDateString.isEmpty()){
            		departureDate = java.sql.Date.valueOf(departureDateString);
            	}
            	
                String departureAirport = request.getParameter("departureAirport");
                String destinationAirport = request.getParameter("destinationAirport");
              
                //Parsing into Time
                String departureTimeString = request.getParameter("departureTime");
                Time departureTime = null;  
                
                if (!departureTimeString.isEmpty()){
					departureTime = Time.valueOf(departureTimeString + ":00");
                }
                 
              
                //Parsing into Time
                String arrivalTimeString = request.getParameter("arrivalTime");
                Time arrivalTime = null;
                if(!arrivalTimeString.isEmpty()){
                	 arrivalTime = Time.valueOf(arrivalTimeString + ":00");
                }
               
          
                //Parsing into Float
           		String priceString = request.getParameter("price");  
           		Float price = null;
           		if (!priceString.isEmpty()){
           			price = Float.parseFloat(priceString);
           		}
           	
           		
           		String isDomesticString = request.getParameter("isDomestic");
           		Integer isDomestic = null;
           		
                if(!isDomesticString.isEmpty()){
                	if(isDomesticString.equals("yes")){
                		isDomestic = 1;
                	} else {
                		isDomestic = 0;
                	}  		
                } 
          
                String sql = "INSERT INTO Flight (flight_number, departure_date, departure_airport, destination_airport, departure_time, arrival_time, is_domestic, airline_ID, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, flightNumber);
                pstmt.setDate(2, departureDate); 
                pstmt.setString(3, departureAirport); 
                pstmt.setString(4, destinationAirport); 
                pstmt.setTime(5, departureTime); 
                pstmt.setTime(6, arrivalTime); 
                pstmt.setInt(7, isDomestic); 
                pstmt.setString(8, airlineID);
                pstmt.setFloat(9, price); 
                pstmt.executeUpdate();

               	out.println("<p>Flight added successfully.</p>");          
            } 
            
        	//Adding Airport 
            else if ("addAirport".equals(action)) {
            	String airportID = request.getParameter("airportID");
                pstmt = con.prepareStatement("INSERT INTO Airport (airport_id) VALUES (?)");
                pstmt.setString(1, airportID);
                pstmt.executeUpdate();
               	out.println("<p>Airport added successfully.</p>");  
            } 
           
            else if ("addAircraft".equals(action)) {
                pstmt = con.prepareStatement("INSERT INTO Aircraft (aircraft_id, operating_days, business_seats, economy_seats, airline_id) VALUES (?, ?, ?, ?, ?)");
            	Integer aircraftID = Integer.parseInt(request.getParameter("aircraftID"));
            	String airlineID = request.getParameter("airlineID");
            	
            	String operatingDays = request.getParameter("operatingDays");
            	String businessSeatsString = request.getParameter("businessSeats");
            	String economySeatsString = request.getParameter("economySeats");
            	
            	if(!businessSeatsString.isEmpty()){
            		Integer businessSeats = Integer.parseInt(businessSeatsString);
            		pstmt.setInt(3, businessSeats);
            	} else{
            		pstmt.setNull(3, java.sql.Types.INTEGER);
            	}
            	
				if(!economySeatsString.isEmpty()){
            		Integer economySeats = Integer.parseInt(economySeatsString);
                    pstmt.setInt(4, economySeats);
            	} else{
            		pstmt.setNull(4, java.sql.Types.INTEGER);
            	}
            	
                pstmt.setInt(1, aircraftID);
                pstmt.setString(2, operatingDays);
                pstmt.setString(5, airlineID);
                
                pstmt.executeUpdate();
               	out.println("<p>Aircraft added successfully.</p>");  
                    
            } 
            
           	else if ("editFlight".equals(action)) {
           		//Required
           		Integer flightNumber = Integer.parseInt(request.getParameter("flightNumber"));
            	String airlineID = request.getParameter("airlineID");
            	//Not required
            	String departureDateString = request.getParameter("departureDate");
                String departureAirport = request.getParameter("departureAirport");
                String destinationAirport = request.getParameter("destinationAirport");
                String departureTimeString = request.getParameter("departureTime");
                String arrivalTimeString = request.getParameter("arrivalTime");
           		String priceString = request.getParameter("price");  
           		String isDomesticString = request.getParameter("isDomestic");
           		
           	// Create an SQL update query
           		String updateQuery = "UPDATE Flight SET ";

           		// Initialize a flag to check if any fields need to be updated
           		boolean updateNeeded = false;

           		// Check and append each field to the update query if it's not empty
           		if (departureDateString != null && !departureDateString.isEmpty()) {
            		java.sql.Date departureDate = java.sql.Date.valueOf(departureDateString);
           		    updateQuery += "departure_date = '" + departureDate + "', ";
           		    updateNeeded = true;
           		}

           		if (departureAirport != null && !departureAirport.isEmpty()) {
           		    updateQuery += "departure_airport = '" + departureAirport + "', ";
           		    updateNeeded = true;
           		}

           		if (destinationAirport != null && !destinationAirport.isEmpty()) {
           		    updateQuery += "destination_airport = '" + destinationAirport + "', ";
           		    updateNeeded = true;
           		}

           		if (departureTimeString != null && !departureTimeString.isEmpty()) {
           			Time departureTime = Time.valueOf(departureTimeString + ":00");
           		    updateQuery += "departure_time = '" + departureTime + "', ";
           		    updateNeeded = true;
           		}

           		if (arrivalTimeString != null && !arrivalTimeString.isEmpty()) {
           			Time arrivalTime = Time.valueOf(arrivalTimeString + ":00");
           		    updateQuery += "arrival_time = '" + arrivalTime + "', ";
           		    updateNeeded = true;
           		}

           		if (priceString != null && !priceString.isEmpty()) {
           			Float price = Float.parseFloat(priceString);
           		    updateQuery += "price = '" + price + "', ";
           		    updateNeeded = true;
           		}

           		if (isDomesticString != null && !isDomesticString.isEmpty()) {
           			Integer isDomestic = null;
                 	if(isDomesticString.equals("yes")){
                 		isDomestic = 1;
                 	} else {
                 		isDomestic = 0;
                 	}  		                 
           		    updateQuery += "is_domestic = '" + isDomestic + "', ";
           		    updateNeeded = true;
           		}
           		
           		if (departureDateString != null && !departureDateString.isEmpty()) {
            		java.sql.Date departureDate = java.sql.Date.valueOf(departureDateString);
           		    updateQuery += "departure_date = '" + departureDate + "', ";
           		    updateNeeded = true;
           		}


           		// Remove the trailing comma and space if any fields are updated
           		if (updateNeeded) {
           		    updateQuery = updateQuery.substring(0, updateQuery.length() - 2);
           		    // Add the WHERE clause to specify the flight number and airline ID
           		    updateQuery += " WHERE flight_number = " + flightNumber + " AND airline_ID = '" + airlineID + "'";

           		    // Execute the update query
           		    pstmt = con.prepareStatement(updateQuery);
           		    pstmt.executeUpdate();

           		    // Output a success message
           		    out.println("<p>Flight details updated successfully.</p>");
           		}
           	}
           	
           	else if ("editAircraft".equals(action)) {
           		Integer aircraftID = Integer.parseInt(request.getParameter("aircraftID"));
            	String airlineID = request.getParameter("airlineID");
            	String operatingDays = request.getParameter("operatingDays");
            	String businessSeatsString = request.getParameter("businessSeats");
            	String economySeatsString = request.getParameter("economySeats");
           		
           	// Create an SQL update query
           		String updateQuery = "UPDATE Aircraft SET ";

           		// Initialize a flag to check if any fields need to be updated
           		boolean updateNeeded = false;

           		// Check and append each field to the update query if it's not empty
           		if (operatingDays != null && !operatingDays.isEmpty()) {
           		    updateQuery += "operating_days = '" + operatingDays + "', ";
           		    updateNeeded = true;
           		}

           		if (businessSeatsString != null && !businessSeatsString.isEmpty()) {
           			Integer businessSeats = Integer.parseInt(businessSeatsString);
           		    updateQuery += "business_seats = '" + businessSeats + "', ";
           		    updateNeeded = true;
           		}

           		if (economySeatsString != null && !economySeatsString.isEmpty()) {
           			Integer economySeats = Integer.parseInt(economySeatsString);
           		    updateQuery += "economy_seats = '" + economySeats + "', ";
           		    updateNeeded = true;
           		}


           		// Remove the trailing comma and space if any fields are updated
           		if (updateNeeded) {
           		    updateQuery = updateQuery.substring(0, updateQuery.length() - 2);
           		    // Add the WHERE clause to specify the flight number and airline ID
           		    updateQuery += " WHERE aircraft_ID = " + aircraftID + " AND airline_ID = '" + airlineID + "'";
           		    

           		    // Execute the update query
           		    pstmt = con.prepareStatement(updateQuery);
           		    pstmt.executeUpdate();

           		    // Output a success message
           		    out.println("<p>Aircraft details updated successfully.</p>");
           		}
           	}
           	
        	else if ("editAirport".equals(action)) {
        		String airportID = request.getParameter("airportID");
           		String newAirportID = request.getParameter("newAirportID");
               	if (newAirportID != null && !newAirportID.isEmpty()) {
               		String query = " UPDATE Airport SET airport_ID = '" + newAirportID + "' WHERE airport_ID = '" + airportID + "'";
               		pstmt = con.prepareStatement(query);
               		pstmt.executeUpdate();
               		out.println("<p>Airport details updated successfully.</p>");
               		}
            } else if ("deleteAircraft".equals(action)) {
               	String aircraftID = request.getParameter("aircraftID");
               	String airlineID = request.getParameter("airlineID");
            	String query = "DELETE FROM Aircraft WHERE aircraft_ID = '" + aircraftID + "'AND airline_ID = '" + airlineID + "'";
           		pstmt = con.prepareStatement(query);
           		pstmt.executeUpdate();
            	
            	out.println("<p> Aircraft deleted successfully.</p>");
                
            } else if ("deleteAirport".equals(action)) {
            	String airportID = request.getParameter("airportID");
            	String query = "DELETE FROM Airport WHERE airport_ID = '" + airportID + "'";
           		pstmt = con.prepareStatement(query);
           		pstmt.executeUpdate();
            	out.println("<p> Airport deleted successfully.</p>");
                
			} else if ("deleteFlight".equals(action)) {
				Integer flightNumber = Integer.parseInt(request.getParameter("flightNumber"));
            	String airlineID = request.getParameter("airlineID");
            	pstmt = con.prepareStatement("DELETE FROM Flight WHERE flight_number = ? AND airline_ID = ?");
            	pstmt.setInt(1, flightNumber);
                pstmt.setString(2, airlineID);
           		pstmt.executeUpdate();
            	out.println("<p> Flight deleted successfully.</p>");
                
            } 
        } catch (SQLException e) {
            out.println("Database error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    %>
    <a href="customerRep.jsp">Back to Customer Representative Dashboard</a>

</body>
</html>