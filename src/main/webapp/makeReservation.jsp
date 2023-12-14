<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Making Flight Reservations on Behalf of Users</title>
</head>
<body>
    <h1>Making Flight Reservations on Behalf of Users</h1>
        <!-- Logout link -->
  	<div>
        Welcome <%= session.getAttribute("user") %>!
        <a href='customerRep.jsp'>[Back to Customer Representative Dashboard]</a>
    </div>

    <h2>Please input your customer's info!</h2>
    <form action="searchFlightsCustomerRep.jsp" method="post">
    		Customer's Username: <input type="text" name="usernameCustomerRep" required/> <br/>
			Customer's Password: <input type="password" name="passwordCustomerRep" required/> <br/>

        <input type="hidden" name="action" value="makeReservationForUser" />
        <input type="submit" value="Make Reservation!" />

    </form>
    
    

</body>
</html>