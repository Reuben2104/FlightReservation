<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>View Waitlist Actions</title>
</head>
<body>
    <%
        String action = request.getParameter("action");
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "DelL!234");
            
            //Adding flight
       
            if ("listPassengersFromWaitlist".equals(action)) {
                String airlineID = request.getParameter("airlineID");
                Integer flightNumber = Integer.parseInt(request.getParameter("flightNumber")); 
                
                String query = "SELECT * FROM Waitlist WHERE flight_number = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, flightNumber);   
                rs = pstmt.executeQuery();
                    
                
                    %>
                    
                    <table>
                
                    <tr>    
                        <td><u>First Name</u></td>
                        <td><u>Last Name</u></td>
                        <td><u>Username</u></td>
                        <td><u>Flight Number</u></td>
                        <td><u>Airline ID</u></td>
                        <td><u>Waitlist ID</u></td>
                        <td><u>Class</u></td>
                    
                    </tr>
                    
                <%
                    
                while (rs.next()) {
                        
                    String firstName= rs.getString("fname");
                    String lastName = rs.getString("lname");
                    String username = rs.getString("username");
                    Integer flightNumberResult = rs.getInt("flight_number");
                    String airlineIDResult = rs.getString("airline_ID");
                    Integer waitlist_ID = rs.getInt("waitlist_ID");
                    String classResult = rs.getString("class");
                    
                
                            
                        
                %>
                            
                        <tr>
                            <td><%= firstName%></td>
                            <td><%= lastName%></td>
                            <td><%= username%></td>
                            <td><%= flightNumberResult%></td>
                            <td><%= airlineIDResult%></td>
                            <td><%= waitlist_ID%></td>
                            <td><%= classResult%></td>
                        </tr>
                            
                <% 
                        
                }

                %>
                        
                </table>
                
                <%
                
            } } catch (SQLException e) {
                     out.println("Database error: " + e.getMessage());
                }  finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                }
                
                %>
    <a href="customerRep.jsp">Back to Customer Representative Dashboard</a>

</body>
</html>