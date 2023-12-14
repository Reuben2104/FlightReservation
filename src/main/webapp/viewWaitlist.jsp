<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Waiting List for a Given Flight</title>
</head>
<body>
    <h1>List of All Passengers on Waiting List For a Given Flight</h1>
        <!-- Logout link -->
      <div>
        Welcome <%= session.getAttribute("user") %>!
        <a href='customerRep.jsp'>[Back to Customer Dashboard]</a>
		
    </div>

       <!-- Form to add a new Airport -->
    <h2>Input Flight</h2>
    <form action="viewWaitlistActions.jsp" method="post">
    	Flight Number = <input type="number" name="flightNumber" required /><br />
        <input type="hidden" name="action" value="listPassengersFromWaitlist" />
        <input type="submit" value="View Waiting List!" />
    </form>
</body>
</html>