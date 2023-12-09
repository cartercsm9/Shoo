<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Summary</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #d9edfa;
        }
        h1, h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 70%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            background-color: white;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #333;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .back-button {
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>


<% 
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Validate customer ID and check for products in the shopping cart
if (custId == null || productList == null || productList.isEmpty() || !custId.matches("\\d+")) {
    out.println("<h1>Error: Invalid customer ID or empty shopping cart!</h1>");
} else {
    // Establish database connection
    String JDBC_URL = "jdbc:sqlserver://cosc304-sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String USER = "sa";
    String PASSWORD = "304#sa#pw";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet keys = null;

    try {
        con = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);

        // Save order information to the database
        String orderSql = "INSERT INTO ordersummary (orderDate, totalAmount, customerId) VALUES (?, ?, ?)";
        pstmt = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
        pstmt.setDouble(2, 0); // Placeholder for totalAmount, will be updated later
        pstmt.setInt(3, Integer.parseInt(custId));
        pstmt.executeUpdate();

        // Retrieve auto-generated keys to get the orderId
        keys = pstmt.getGeneratedKeys();
        int orderId = 0;
        if (keys.next()) {
            orderId = keys.getInt(1);
        }

        // Insert each item into OrderProduct table using orderId from previous INSERT
        String orderProductSql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        double totalAmount = 0;

        out.println("<h1>Order Summary</h1>");
        out.println("<h2>Your order reference number is: " + orderId + "</h2>");

        out.println("<table border='1'>");
        out.println("<tr><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

        while (iterator.hasNext()) {
            Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> product = entry.getValue();
            String productId = (String) product.get(0);
            String price = (String) product.get(2);
            double pr = Double.parseDouble(price);
            int qty = ((Integer) product.get(3)).intValue();

            // Insert product into OrderProduct table
            pstmt = con.prepareStatement(orderProductSql);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, Integer.parseInt(productId));
            pstmt.setInt(3, qty);
            pstmt.setDouble(4, pr);
            pstmt.executeUpdate();

            // Update total amount for order record
            totalAmount += pr * qty;
			
			// Update totalAmount in ordersummary table
			String updateTotalSql = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
			pstmt = con.prepareStatement(updateTotalSql);
			pstmt.setDouble(1, totalAmount);
			pstmt.setInt(2, orderId);
			pstmt.executeUpdate();

            // Display product details in the order summary table
            double subtotal = pr * qty;
            out.println("<tr>");
           
            out.println("<td>" + product.get(1) + "</td>");
            out.println("<td>" + qty + "</td>");
            out.println("<td>" + NumberFormat.getCurrencyInstance().format(pr) + "</td>");
            out.println("<td>" + NumberFormat.getCurrencyInstance().format(subtotal) + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");

        // Display total amount
        out.println("<h2>Total Amount: " + NumberFormat.getCurrencyInstance().format(totalAmount) + "</h2>");
		out.println("<h2>We are now prepairing your order. You will be notified once your order is shipped. Thanks for shopping with us!</h2>");
        // Clear cart if order placed successfully
        session.removeAttribute("productList");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h1>Error occurred while processing order.</h1>");
    } finally {
        // Closing database resources
        if (keys != null) {
            try {
                keys.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }}%>

    <a href="/shop" class="back-button">Back to Shop</a>
</body>
</html>