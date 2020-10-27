<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

    <div id="page">
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="history.css">
        <table id="reservations_table">
            <tr>
                <th>Arrival-Date</th>
                <th>Departure-Date</th>
                <th>Stops</th>
                <th>Price</th>
                <th>Flight-Type</th>
                <th>Seat-Number</th>
                <th>Meal Type</th>
                <th>Class-Type</th>
                <th>Date-of-Purchase</th>
                <th>Booking-Fee</th>
                <th>Cancel</th>
                
            </tr>
            <% 
            if(session.getAttribute("user")!=null){
            
                try{
                    ApplicationDB db = new ApplicationDB();	
			        Connection connection = db.getConnection();	

                    String query = new StringBuilder()
                        .append("SELECT t.tripID, t.flightID, t.departureDate, t.arrivalDate, t.stops, t.price, t.flightType, t.seatNumber, ")
                        .append("Ticket.meal AS mealType, Ticket.class AS classType, Ticket.buyTime AS buyTime, Ticket.bookingFee AS bookingFee, Ticket.ticketID ")
                        .append("FROM Trip t ")
                        .append("JOIN Ticket ON t.tripID = Ticket.tripID ")
                        .append("WHERE Ticket.username = ?").toString();

                    PreparedStatement statement = connection.prepareStatement(query);
                    statement.setString(1,session.getAttribute("user").toString());
                    ResultSet resultSet = statement.executeQuery();

                    while(resultSet.next()){
                        String arrivalDateString = "0000-00-00";
                        String depDateString = "0000-00-00";
                        if(resultSet.getString("arrivalDate") != null){
                            arrivalDateString = resultSet.getString("arrivalDate").toString();
                        }

                        if(resultSet.getString("departureDate") != null){
                            depDateString = resultSet.getString("departureDate").toString();
                        }

                        %>
                        <tr>
                            <td><%=arrivalDateString%></td>
                            <td><%=depDateString%></td>
                            <td><%=resultSet.getString("stops")%></td>
                            <td><%=resultSet.getString("price")%></td>
                            <td><%=resultSet.getString("flightType")%></td>
                            <td><%=resultSet.getString("seatNumber")%></td>
                            <td><%=resultSet.getString("mealType")%></td>
                            <td><%=resultSet.getString("classType")%></td>
                            <td><%=resultSet.getString("buyTime")%></td>
                            <td><%=resultSet.getString("bookingFee")%></td>
                            <td>
                                <button class="button" id=<%=Integer.toString(resultSet.getInt("tripID")) + "$" + Integer.toString(resultSet.getInt("flightID")) + "$" + Integer.toString(resultSet.getInt("ticketID")) %>>Cancel</button>
                            </td>
                            
                        </tr>
                        <%    
                    }
                }catch(SQLException e){
                    e.printStackTrace();
                }
            }
            %>
        </table> 
    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>
        $(":button").click(function() {
            if($(document.activeElement).attr('id').includes("$")){
                var ticket = $(document.activeElement).attr('id');
                var tripID = ticket.split("$")[0];
                var flightID = ticket.split("$")[1];
                var ticketID = ticket.split("$")[2];
                window.location.replace("cancel.jsp?tripID=" + encodeURI(tripID) + "&flightID=" + encodeURI(flightID) + "&ticketID=" + encodeURI(ticketID));
            } 
        });
    </script>

</html>
 
