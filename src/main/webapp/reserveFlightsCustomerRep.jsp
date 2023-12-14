<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Ticket Information</title>
</head>
<body>

	<div>
        Welcome <%= session.getAttribute("user") %>!
        <a href='customerRep.jsp'>[Back to Customer Representative Dashboard]</a>
    </div>
    

    <p style="font-size: 30px;">Selected flight(s):</p>

    <%
    ArrayList<ArrayList<String>> flight_info_list = new ArrayList<>();

    String departing_info = request.getParameter("departingFlightNumber");
    String[] departing_parts = departing_info.split("_"); // Split by the delimiter
    ArrayList<String> departing_parts_list = new ArrayList<>(Arrays.asList(departing_parts));
    String departing_flightNumber = departing_parts[0];
    String departing_airlineID = departing_parts[1];
    String oneOrRound = (String) session.getAttribute("oneOrRound");
    flight_info_list.add(departing_parts_list);

    if(oneOrRound.equals("0")){
        String returning_info = request.getParameter("returningFlightNumber");
        String[] returning_parts = returning_info.split("_"); // Split by the delimiter
        ArrayList<String> returning_parts_list = new ArrayList<>(Arrays.asList(returning_parts));
        String returning_flightNumber = returning_parts[0];
        String returning_airlineID = returning_parts[1];
        flight_info_list.add(returning_parts_list);
    }
    

    session.setAttribute("flight_info_list", flight_info_list);

    ApplicationDB db = null;
    Connection con = null;

    try {
        db = new ApplicationDB();
        con = db.getConnection();

        for (ArrayList<String> flight: flight_info_list){
            String flight_airline_id = flight.get(1);
            String flight_number = flight.get(0);

            String flightQuery = "SELECT * FROM Flight WHERE flight_number = ? AND airline_ID = ?";
            PreparedStatement flightStmt = con.prepareStatement(flightQuery);
            flightStmt.setString(1, flight_number);
            flightStmt.setString(2, flight_airline_id);
            ResultSet flightResult = flightStmt.executeQuery();
            // out.println("<p>" + flight_number + ", "+ flight_airline_id + "</p>");
            if (flightResult.next()) {
                String flightDetailsString = "Departing Flight: " +
                    "Flight Number - " + flightResult.getString("flight_number") +
                    ", Departure Date - " + flightResult.getString("departure_date") +
                    ", Airline - " + flightResult.getString("airline_ID") +
                    ", Departure Airport - " + flightResult.getString("departure_airport") +
                    ", Arrival Airport - " + flightResult.getString("destination_airport") +
                    ", Departure Time - " + flightResult.getString("departure_time") +
                    ", Arrival Time - " + flightResult.getString("arrival_time") +
                    ", Price - $" + flightResult.getString("price");

                out.println("<p>" + flightDetailsString + "</p>");
            }
        }
        
 
   %>   
   
   <p style="font-size: 30px;">Fill out ticket information:</p>
    
        
	<form action="ticketDisplayCustomerRep.jsp" method="POST">

        <label for="fname">First name:</label>
        <input type="text" name="fname" id="fname" required>

        <br>
        
        <label for="lname">Last name:</label>
        <input type="text" name="lname" id="lname" required>
                
        <br>

        <%
            // String oneOrRound = (String) session.getAttribute("oneOrRound");
            if ("0".equals(oneOrRound)) {
        %>
        
        	<label for="class_type">Class (departing):</label>
	        <select name="class_type" id="class_type">
	            <option value="Economy">Economy</option>
	            <option value="Business">Business (5% up-charge)</option>
	            <option value="First">First Class (10% up-charge)</option>
	        </select>
			
			<br>
			
            <label for="class_type2">Class (returning):</label>
            <select name="class_type2" id="class_type2">
                <option value="Economy">Economy</option>
                <option value="Business">Business (5% up-charge)</option>
                <option value="First">First Class (10% up-charge)</option>
            </select>

        <%
            } else {
        %>
        
        	<label for="class_type">Class:</label>
	        <select name="class_type" id="class_type">
	            <option value="Economy">Economy</option>
	            <option value="Business">Business (5% up-charge)</option>
	            <option value="First">First Class (10% up-charge)</option>
	        </select>
        
        <%
            }
        %>
        
        <br>
        
        <label for="ssn">SSN (###-##-####):</label>
        <input type="password" name="ssn" id="ssn" required>
        
        <br>
        <br>
      
        <input type="submit" value="Submit">
        
         
    </form>
        
	
	<%
    } catch (Exception e) {
        out.print(e);
    } finally {
        // close the connection in a finally block to ensure it happens regardless of exceptions
        db.closeConnection(con);
    }
    %>

</body>
</html>
