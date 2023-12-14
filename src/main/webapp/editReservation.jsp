<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editing Flight Reservations on Behalf of Users</title>
</head>
<body>
    <h1>Editing Flight Reservations on Behalf of Users</h1>
        <!-- Logout link -->
      <div>
        Welcome <%= session.getAttribute("user") %>!
        <a href='customerRep.jsp'>[Back to Customer Representative Dashboard]</a>
	
    </div>

    <h2>Please input your required user's  info and the items you'd like to change only.</h2>
    <form action="editReservationActions.jsp" method="post">
    		Customer's User name (required): <input type="text" name="username"  required/> <br/>
			Customer's Ticket Number (required): <input type="number" name="ticketNumber" required /> <br/>
			Customer's Departing Flight Number (required): <input type="number" name="flightNumber" required /> <br/>
			Customer's Returning Flight Number: <input type="number" name="flightNumber2" /> <br/>
	
			
			New First Name: <input type="text" name="firstName"/> <br/>
			New Last Name: <input type="text" name="lastName"/> <br/> 	
			New Passenger ID (SSN): <input type="number" name="passengerID"/> <br/>
			
			<label for="class_type">New Class (departing):</label>
	        <select name="class_type" id="class_type">
	        	<option value="">Select an option</option>
	            <option value="Economy">Economy</option>
	            <option value="Business">Business (5% up-charge)</option>
	            <option value="First">First Class (10% up-charge)</option>
	        </select>
			
			<br>
			
            <label for="class_type2">New Class (returning):</label>
            <select name="class_type2" id="class_type2">
            	<option value="">Select an option</option>
                <option value="Economy">Economy</option>
                <option value="Business">Business (5% up-charge)</option>
                <option value="First">First Class (10% up-charge)</option>
            </select>		 
        <input type="hidden" name="action" value="editReservationForUser" />
        <input type="submit" value="Edit Reservation!" />
    </form>
    
    <h2>If you'd like to change flight information for your reservation, you will have to delete your reservation and make a new one. Please click the button below to delete your reservation.</h2>
    <form action="deleteReservationForUser.jsp" method="post">
    		Customer's User name (required): <input type="text" name="username"/> <br/>
			Customer's Ticket Number (required): <input type="number" name="ticketNumber" required /> <br/>
        <input type="hidden" name="action" value="deleteReservationForUser" />
        <input type="submit" value="Delete Reservation!" />
	</form>
	
</body>
</html>