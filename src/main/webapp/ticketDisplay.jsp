<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>



<%! SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Ticket Information</title>
</head>
<body>

    <p style="font-size: 30px;">Selected flight(s):</p>

    <%
        
    // Retrieve selected flight numbers from the request
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String classType = request.getParameter("class_type");
    String passengerID = request.getParameter("ssn");
    
    session.setAttribute("passengerid", passengerID);
       
    // Get current date and time
    Date currentDate = new Date();
    String dateTimeString = dateFormat.format(currentDate);
    
    ApplicationDB db = null;
    Connection con = null;

    try {
        // Get the database connection
        db = new ApplicationDB();
        con = db.getConnection();
        
        String flightNum = (String) session.getAttribute("departingFlightNumber");
        String flightNum2 = (String) session.getAttribute("returningFlightNumber");
        String str = "SELECT * FROM Flight WHERE flight_number = ?";
        PreparedStatement preparedStatement = con.prepareStatement(str);
		preparedStatement.setString(1, flightNum);
		ResultSet result = preparedStatement.executeQuery();
		
		String priceString = "";
		String isDomestic = "";
		
		if (result.next()) {
		    priceString = result.getString("price");
		    isDomestic = result.getString("is_domestic");
		}
        
		double price = Double.parseDouble(priceString);
		double classFee = 0.0;
		
		if (classType.compareTo("Business") == 0) {
			classFee = price * 0.05;
			
		}
		
		if (classType.compareTo("First Class") == 0) {
			classFee = price * 0.10;
		}
		
		double bookingFee = 0.0;
		
		String oneOrRound = (String) session.getAttribute("oneOrRound"); 
		String classType2 = "";
		String priceString2 = "";
		double price2 = 0.0;
		ResultSet result2;
		double classFee2 = 0.0;
		
		if (oneOrRound.equals("0")) {
		    classType2 = request.getParameter("class_type2");

			String str2 = "SELECT * FROM Flight WHERE flight_number = ?";
	        PreparedStatement preparedStatement2 = con.prepareStatement(str2);
			preparedStatement2.setString(1, flightNum2);
			result2 = preparedStatement2.executeQuery();
		
			if (result2.next()) {
			    priceString2 = result2.getString("price");
			}
			
			price2 = Double.parseDouble(priceString2);
			
			if (classType2.compareTo("Business") == 0) {
				classFee2 += price2 * 0.05;
			}
			
			if (classType2.compareTo("First Class") == 0) {
				classFee2 += price2 * 0.10;
			}
			
		}
		
				
		if (isDomestic.equals("1")) {
			bookingFee = 25;
		}
			
		if (isDomestic.equals("0")) {
			bookingFee = 50;
		}
		
		String totalFare = "" + (price + bookingFee + classFee + price2 + classFee2);
		
		 
   %>   
   
   <p style="font-size: 30px;">Confirm Ticket:</p>
    
    <p>First Name: <%= fname %></p>
    <p>Last Name: <%= lname %></p>
    <p>Class: <%= classType %></p>
    <p>Date/Time: <%= dateTimeString %></p>
    <p>Flight Number <%= flightNum %></p>
    <p>Price: $<%= price + price2 %></p>
    <p>Booking Fee: $<%= bookingFee %></p>
    <p>Total Fare: $<%= totalFare %></p>
        
	<form action="successfulReservation.jsp" method="POST">
		
        <input type="submit" value="Reserve Ticket">
        
         
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
