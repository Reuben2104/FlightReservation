<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Aircraft, Airport, Flight Information</title>
</head>
<body>
    <h1>Edit Aircraft, Airport, Flight Information</h1>
        <!-- Logout link -->
      <div>
        Welcome <%= session.getAttribute("user") %>!
        <a href='logout.jsp'>[Log out]</a>
		<a href='reply.jsp'>[Reply to Customer's Questions]</a>        
		<a href='makeReservation.jsp'>[Make Flight Reservations for User]</a>
        <a href='editReservation.jsp'>[Edit Flight Reservations for User]</a>
        <a href='viewWaitlist.jsp'>[View Waiting Lists]</a>
        <a href='listFlights.jsp'>[List of all Flights for a given Airport]</a>
    </div>


    <!-- Form to add a new Aircraft -->
    <h2>Add Aircraft</h2>
    <form action="customerRepAction.jsp" method="post">
        Aircraft ID: <input type="number" name="aircraftID" required /><br />
        Airline ID: <input type="text" name="airlineID" required /><br />
        
        <!-- Optional Fields -->
        Operating Days (Formatted as: SMTWFS)(optional): <input type="text" name="operatingDays"  /><br />
        Business Seats (optional): <input type="number" name="businessSeats"  /><br />
        Economy Seats (optional): <input type="number" name="economySeats"  /><br />
        <input type="hidden" name="action" value="addAircraft" />
        <input type="submit" value="Add" />
    </form>
    
       <!-- Form to add a new Airport -->
    <h2>Add Airport</h2>
    <form action="customerRepAction.jsp" method="post">
        Airport ID: <input type="text" name="airportID" required /><br />
        <input type="hidden" name="action" value="addAirport" />
        <input type="submit" value="Add" />
    </form>
    
       <!-- Form to add a new Flight -->
    <h2>Add Flight</h2>
    <form action="customerRepAction.jsp" method="post">
        Flight Number: <input type="number" name="flightNumber" required /><br />
        Airline ID: <input type="text" name="airlineID" required /><br />
     
        <!-- Optional Fields -->
        Departure Date (optional): <input type="date" name="departureDate"  /><br />
        Departure Airport (optional): <input type="text" name="departureAirport"  /><br />
        Destination Airport (optional): <input type="text" name="destinationAirport"  /><br />
        Departure Time (optional): <input type="time" name="departureTime"  /><br />
        Arrival Time (optional): <input type="time" name="arrivalTime"  /><br />
		Is it Domestic? (optional): <select id="isDomestic" name="isDomestic" >
									<option value="">Select an option</option>
  									<option value="yes">Yes</option>
  									<option value="no">No</option> </select><br />       
  		Price (optional): <input type="number" name="price" step="any"/><br />
  		
        <input type="hidden" name="action" value="addFlight" />
        <input type="submit" value="Add" />
    </form>
    
    <h2>Please only enter values of the characteristics you are changing (and the required characteristics).</h2>
       <!-- Form to edit a new Aircraft -->
    <h2>Edit Aircraft</h2>
    <form action="customerRepAction.jsp" method="post">
        Aircraft ID (Required): <input type="number" name="aircraftID" required /><br />
        Airline ID (Required): <input type="text" name="airlineID" required /><br />
        
        New Operating Days (Formatted as: SMTWFS): <input type="text" name="operatingDays"  /><br />
        New Business Seats: <input type="number" name="businessSeats"  /><br />
        New Economy Seats: <input type="number" name="economySeats"  /><br />
        
        <input type="hidden" name="action" value="editAircraft" />
        <input type="submit" value="Edit" />
    </form>
    
       <!-- Form to edit a new Airport -->
    <h2>Edit Airport</h2>
    <form action="customerRepAction.jsp" method="post">
        Airport ID (required): <input type="text" name="airportID" required /><br />
        New Airport ID: <input type="text" name="newAirportID" required /><br />
        <input type="hidden" name="action" value="editAirport" />
        <input type="submit" value="Edit" />
    </form>
    
       <!-- Form to edit a new Flight -->
    <h2>Edit Flight</h2>
    <form action="customerRepAction.jsp" method="post">
        Flight Number (required): <input type="number" name="flightNumber" required /><br />
        Airline ID (required): <input type="text" name="airlineID" required /><br />
        New Departure Date: <input type="date" name="departureDate"  /><br />
        New Departure Airport: <input type="text" name="departureAirport"  /><br />
        New Destination Airport: <input type="text" name="destinationAirport"  /><br />
        New Departure Time: <input type="time" name="departureTime"  /><br />
        New Arrival Time: <input type="time" name="arrivalTime"  /><br />
		New Is it Domestic?: <select id="isDomestic" name="isDomestic" >
									<option value= "">Select an option</option>
  									<option value="yes">Yes</option>
  									<option value="no">No</option> </select><br />       
  		New Price: <input type="number" name="price" step="any"/><br />
        <input type="hidden" name="action" value="editFlight" />
        <input type="submit" value="Edit" />
    </form>
    
    
    <!-- Form to delete an Aircraft -->
    <h2>Delete Aircraft</h2>
    <form action="customerRepAction.jsp" method="post">
       Aircraft ID: <input type="number" name="aircraftID" required /><br />
       Airline ID: <input type="text" name="airlineID" required /><br />

        <input type="hidden" name="action" value="deleteAircraft" />
        <input type="submit" value="Delete" />
    </form>
    
       <!-- Form to delete an Airport -->
    <h2>Delete Airport</h2>
    <form action="customerRepAction.jsp" method="post">
        Airport ID: <input type="text" name="airportID" required /><br />
        <input type="hidden" name="action" value="deleteAirport" />
        <input type="submit" value="Delete" />
    </form>
    
       <!-- Form to delete an Flight -->
    <h2>Delete Flight</h2>
    <form action="customerRepAction.jsp" method="post">
        Flight Number: <input type="number" name="flightNumber" required /><br />
        Airline ID: <input type="text" name="airlineID" required /><br />
        <input type="hidden" name="action" value="deleteFlight" />
        <input type="submit" value="Delete" />
    </form>
</body>
</html>