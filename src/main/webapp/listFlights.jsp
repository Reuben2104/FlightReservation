<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Flights Per Airport</title>
</head>
<body>
    <h1>List of All Flight For a Given Airport</h1>
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

       <!-- Form to add a new Airport -->
    <h2>Input Airport</h2>
    <form action="listFlightActions.jsp" method="post">
        Airport ID: <input type="text" name="airportID" required /><br />
        <input type="hidden" name="action" value="listFlights" />
        <input type="submit" value="View Flights!" />
    </form>
</body>
</html>