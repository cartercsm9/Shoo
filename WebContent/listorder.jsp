<a href="/shop" style="position: absolute; top: 20px; right: 20px; text-decoration: none; color: #333;">Back to Shop</a>
<%
String userName = (String) session.getAttribute("authenticatedUser");
if (userName != null) {
    out.println("Signed in as: " + userName);
}
%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Shoo</title>
    <style>
        table {
            border-collapse: collapse;
            width: 90%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }

        .product-table {
            border-collapse: collapse;
            width: 50%;
            margin-top: 10px;
        }

        .product-table th, .product-table td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        .gif-container {
            position: absolute;
            top: -25px;
            left: 180px;
            max-width: 12%;
        }
        p {
            position: relative;
            font-weight: bold;
            top: -1100px;
            left: 180px;
            font-size: small;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Tahoma', sans-serif;
            background-color: #d9edfa;
            color: #141212;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
    </style>
</head>
<body>

<h1>Order List</h1>
<h3> With you every step of the way</h3>
<%
try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
} catch (java.lang.ClassNotFoundException e) {
    out.println("ClassNotFoundException: " + e);
}

String JDBC_URL = "jdbc:sqlserver://cosc304-sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String USER = "sa";
String PASSWORD = "304#sa#pw";

try {
    Connection con = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
    String sql =  "SELECT os.orderId, os.orderDate, os.customerId, c.firstName, c.lastName, os.totalAmount, op.productId, op.quantity, op.price " +
                  "FROM ordersummary os " +
                  "JOIN customer c ON os.customerId = c.customerId " +
                  "JOIN orderproduct op ON os.orderId = op.orderId";
    Statement stmt = con.createStatement();
    ResultSet r = stmt.executeQuery(sql);
%>
<%
    int currentOrderId = -1;
    while (r.next()) {
        int orderId = r.getInt("orderId");
        if (orderId != currentOrderId) {
            if (currentOrderId != -1) {
%>
                </table>
<%
            }
%>
            <table>
                <tr>
                    <th>Order Id</th>
                    <th>Order Date</th>
                    <th>Customer Id</th>
                    <th>Customer Name</th>
                    <th>Total Amount</th>
                </tr>
                <tr>
                    <td><%= r.getInt("orderId") %></td>
                    <td><%= r.getDate("orderDate") %></td>
                    <td><%= r.getInt("customerId") %></td>
                    <td><%= r.getString("firstName") + " " + r.getString("lastName") %></td>
                    <td>$<%= r.getDouble("totalAmount") %></td>
                </tr>
                <tr>
					<th style="border: none;"></th>
    				<th style="border: none"></th>
                    <th>Product Id</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
<%
            currentOrderId = orderId;
        }
%>
            <tr>
				<td style="border: none"></td>
				<td style="border: none"></td>
                <td><%= r.getInt("productId") %></td>
                <td><%= r.getInt("quantity") %></td>
                <td>$<%= r.getDouble("price") %></td>
            </tr>
<%
    }
%>
            </table>
<%
    r.close();
    stmt.close();
    con.close();
} catch (SQLException e) {
    e.printStackTrace();
}   
%>

<div class="gif-container">
    <img src="https://media2.giphy.com/media/3oEjHW5ZfmQsI2rUuk/giphy.gif?cid=ecf05e47bswf3swzoq97g950iskqa8ee9c0b2svhfa255ges&ep=v1_gifs_search&rid=giphy.gif&ct=g" alt="Animated GIF" style="width: 100%; height:auto;">
</div>



</body>
</html>
