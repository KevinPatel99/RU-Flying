<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336test.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

    <div id="page">
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="flights.css">
        <input type="text" id="from_searchbar" onkeyup="fromFilter()" placeholder="Search From">
        <input type="text" id="to_searchbar" onkeyup="toFilter()" placeholder="Search To">
        <table id="flights_table">
            <tr>
                <th>
                    <button class="button" onclick="sortTable(0)">Departure Time-click to sort</button>
                </th>
                <th>
                    <button class="button" onclick="sortTable(1)">Arrival Time-click to sort</button>
                </th>
                <th>Day</th>
                <th>Airline</th>
                <th>From</th>
                <th>To</th>
                <th>Purchase</th>
            </tr>
            <% 
            if(session.getAttribute("user")!=null){
            
                try{
                    ApplicationDB db = new ApplicationDB();	
			        Connection connection = db.getConnection();	

                    String query = new StringBuilder()
                        .append("SELECT DISTINCT f.departureTime, f.arrivalTime, f.dayOfWeek, al.airlineName, ")
                        .append("ap1.airportName AS departureAirportName, ap2.airportName AS arrivalAirportName ")
                        .append("FROM Flight f ")
                        .append("JOIN Route ON f.routeID = Route.routeID ")
                        .append("JOIN Airline al ON Route.airlineID = al.airlineID ")
                        .append("JOIN Airport ap1 ON Route.departureAirportID = ap1.airportID ")
                        .append("JOIN Airport ap2 ON Route.arrivalAirportID = ap2.airportID").toString();

                    PreparedStatement statement = connection.prepareStatement(query);
                    ResultSet resultSet = statement.executeQuery();

                    while(resultSet.next()){
                        %>
                        <tr>
                            <td><%=resultSet.getTime("departureTime").toString()%></td>
                            <td><%=resultSet.getTime("arrivalTime").toString()%></td>
                            <td><%=resultSet.getString("dayOfWeek")%></td>
                            <td><%=resultSet.getString("airlineName")%></td>
                            <td><%=resultSet.getString("departureAirportName")%></td>
                            <td><%=resultSet.getString("arrivalAirportName")%></td>
                            <td>
                                <button class="button" id=<%=resultSet.getTime("departureTime").toString() + "-" + resultSet.getTime("arrivalTime").toString() %>>Purchase</button>
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

        <p id="label_class">Choose a class</p>
        <select id="select_class">
            <option value="econ">Economy</option>
            <option value="bus">Business</option>
            <option value="first">First Class</option>
        </select>

        <p id="label_meal">Choose a meal</p>
        <select id="select_meal">
            <option value="reg">Normal</option>
            <option value="veg">Vegetarian</option>
        </select>

        <p id="userShow"><%=session.getAttribute("user").toString()%></p>
        <p id="Logout">
            <a href="logout.jsp">Logout</a>
        </p>    

    </div>


    <script>
        function sortTable(col) {
            var table = document.getElementById("flights_table");
            var switching = true;
            var i = 1;
            var x;
            var y;
            var shouldSwitch = false;
            while (switching) {
                switching = false;
                var rows = table.rows;
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("td")[col];
                    y = rows[i + 1].getElementsByTagName("td")[col];
                    if (Number(x.innerHTML.split(":")[0]) > Number(y.innerHTML.split(":")[0])) {
                        shouldSwitch = true;
                        break;
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                }
            }
        }

        function fromFilter(){
            
            var search = document.getElementById("from_searchbar").value.toUpperCase();
            var table = document.getElementById("flights_table");
            var row = table.getElementsByTagName("tr");
            for (i = 0; i < row.length; i++) {
                    x = table.rows[i].getElementsByTagName("td")[4];
                    if (x) {
                        if (x.innerHTML.toUpperCase().indexOf(search) > -1) {
                            //found a match break to keep the row
                            table.rows[i].style.display = "";
                        }else{
                            table.rows[i].style.display = "none";
                        }
                    }
                 
            }
        }

        function toFilter(){
            
            var search = document.getElementById("to_searchbar").value.toUpperCase();
            var table = document.getElementById("flights_table");
            var row = table.getElementsByTagName("tr");
            for (i = 0; i < row.length; i++) {
                    x = table.rows[i].getElementsByTagName("td")[5];
                    if (x) {
                        if (x.innerHTML.toUpperCase().indexOf(search) > -1) {
                            //found a match break to keep the row
                            table.rows[i].style.display = "";
                        }else{
                            table.rows[i].style.display = "none";
                        }
                    }
                 
            }
        }

        function filterSearch(){
            
            var search = document.getElementById("filter_searchbar").value.toUpperCase();
            var table = document.getElementById("flights_table");
            var row = table.getElementsByTagName("tr");
            for (i = 0; i < row.length; i++) {
                for(j = 0; j < (table.rows[0].cells.length); j++){
                    x = table.rows[i].getElementsByTagName("td")[j];
                    if (x) {
                        if (x.innerHTML.toUpperCase().indexOf(search) > -1) {
                            //found a match break to keep the row
                            table.rows[i].style.display = "";
                            break;
                        } 
                        if(j==5){
                            //did not find a match delete row
                            table.rows[i].style.display = "none";
                        }
                    }
                }  
            }
        }

    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>
        $(":button").click(function() {
            if($(document.activeElement).attr('id').includes(":")){
                var ticket = $(document.activeElement).attr('id');
                var dep = ticket.split("-")[0];
                var arr = ticket.split("-")[1];
                window.location.replace("reserve.jsp?dep=" + encodeURI(dep) + "&arr=" + encodeURI(arr) + "&class=" 
                + encodeURI(document.getElementById("select_class").options[document.getElementById("select_class").selectedIndex].value)
                + "&meal="
                + encodeURI(document.getElementById("select_meal").options[document.getElementById("select_meal").selectedIndex].value));
            } 
        });
    </script>

</html>