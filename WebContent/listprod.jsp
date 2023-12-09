<a href="/shop" style="position: absolute; top: 20px; right: 20px; text-decoration: none; color: #333;">Back to Shop</a>

<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="insertImages.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Shoo</title>
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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f5f5f5;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f2f2f2;
        }
        form {
            text-align: center;
            margin-top: 20px;
        }
        input[type="text"], input[type="submit"], input[type="reset"] {
            padding: 8px;
            font-size: 16px;
            background-color: #d9edfa;
        }
        select{
            padding:8px;
            font-size: 14px;
            font-style: inherit;
            background-color: #ecfefc;
        }
        .gif-container {
            position: absolute;
            top: -25px;
            left: 180px;
            max-width: 10%;
        }
        .product-image {
            width: 50px;
            height: 50px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Let's find your comfort soles!</h1>

    <h2> Search: </h2>

    <form method="get" action="listprod.jsp">
        <input type="text" name="productName" size="50" value="<%= (request.getParameter("productName") != null) ? request.getParameter("productName") : "" %>">
        <select name="categoryId" color="blue">
            <option value="0">All</option>
            <option value="1">Running Shoes</option>
            <option value="2">Walking Shoes</option>
            <option value="3">Sneakers</option>
            <option value="4">Skateboarding Shoes</option>
            <option value="5">Basketball Shoes</option>
            <option value="6">Hiking Shoes</option>
            <option value="7">Boots</option>
            <option value="8">Lowtops</option>
        </select>
        <input type="submit" value="Submit">
        <input type="reset" value="Reset"> (Leave blank for all products)
    </form>


    <%
    String name = request.getParameter("productName");
    String categoryId = request.getParameter("categoryId");

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String JDBC_URL = "jdbc:sqlserver://cosc304-sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String USER = "sa";
        String PASSWORD = "304#sa#pw";
        Connection con = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);

        if (name != null && !name.isEmpty()) {
            String sqlSearch = "SELECT * FROM product WHERE productName LIKE ?";
            if(!"0".equals(categoryId)){
                sqlSearch += " AND categoryId = " + categoryId;
            }
            else{
                sqlSearch = "SELECT * FROM product WHERE productName LIKE ?";
            }
            PreparedStatement preparedStatement = con.prepareStatement(sqlSearch);
            preparedStatement.setString(1, "%" + name + "%");
            ResultSet searchProducts = preparedStatement.executeQuery();

            out.println("<table>");
            out.println("<tr><th>Product Image</th><th>Product Name</th><th>Price</th><th>Like what you see?</th></tr>");

            while (searchProducts.next()) {
                String productName = searchProducts.getString("productName");
                double price = searchProducts.getDouble("productPrice");
                NumberFormat currFormat = NumberFormat.getCurrencyInstance();
                String formattedPrice = currFormat.format(price);
                int productId = searchProducts.getInt("productId");
                String imageUrl = searchProducts.getString("productImageURL");

                String link = "addcart.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + price;

                out.println("<tr><td><img src='" + imageUrl + "' class='product-image'></td><td><a href='product.jsp?id=" + productId + "'>" + productName + "</a></td><td>" + formattedPrice + "</td><td><a href='" + link + "'>Add to Cart</a></td></tr>");
            }

            out.println("</table>");

            searchProducts.close();
            preparedStatement.close();
        } else {
            Statement stmt = con.createStatement();
            String productQuery = "SELECT * FROM product";
            if(!"0".equals(categoryId)){
                productQuery += " WHERE categoryId = " + categoryId;
            }
            else{
                productQuery = "SELECT * FROM product";
            }
            ResultSet allProducts = stmt.executeQuery(productQuery);

            out.println("<table>");
            out.println("<tr><th>Product Image</th><th>Product Name</th><th>Price</th><th>Like what you see?</th></tr>");

            while (allProducts.next()) {
                String productName = allProducts.getString("productName");
                double price = allProducts.getDouble("productPrice");
                NumberFormat currFormat = NumberFormat.getCurrencyInstance();
                String formattedPrice = currFormat.format(price);
                int productId = allProducts.getInt("productId");
                String imageUrl = allProducts.getString("productImageURL");

                String link = "addcart.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + price;

                out.println("<tr><td><img src='" + imageUrl + "' class='product-image'></td><td><a href='product.jsp?id=" + productId + "'>" + productName +  "</a></td><td>" + formattedPrice + "</td><td><a href='" + link + "'>Add to Cart</a></td></tr>");

            }

            out.println("</table>");

            allProducts.close();
            stmt.close();
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
       // out.println("<p>Exception: " + e.getMessage() + "</p>");
    }
    %>

    <div class="signed-in-container">
        <%
            String userName = (String) session.getAttribute("authenticatedUser");
            if (userName != null) {
                out.println("Signed in as: " + userName);
            }
        %>
    </div>
</div>
    <img src="https://media2.giphy.com/media/3oEjHW5ZfmQsI2rUuk/giphy.gif?cid=ecf05e47bswf3swzoq97g950iskqa8ee9c0b2svhfa255ges&ep=v1_gifs_search&rid=giphy.gif&ct=g" alt="Animated GIF" class="gif-container">
</body>
</html>
