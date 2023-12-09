<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Shoo - Product Information</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Tahoma', sans-serif;
            background-color: #d9edfa;
            color: #fff;
            display: flex;
            flex-direction: column;
            height: 100vh;
            align-items: center;
        }

        h1 {
            text-align: center;
            padding: 50px;
            background: linear-gradient(to right, #4ab1a8, #182848);
            margin: 0;
            font-size: 5em;
        }

        h2 {
            text-align: center;
            margin: 50px 0;
            font-size: 2em;
            background: #4ab1a8;
            padding: 10px;
            border-radius: 10px;
        }

        a, a:visited, a:focus, a:active {
            color: inherit;
            text-decoration: none;
        }

        .custom-button {
            text-decoration: none;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            outline: none;
            transition: background-color 0.3s;
            display: inline-block;
        }

        .custom-button:hover {
            background-color: #c31521;
        }

        p {
            text-align: center;
            margin: 5px 0; 
            color: black;
            border-radius: 5px;
        }
        img{
            text-align: center;
        }
        .product-image {
            width: 150px;
            height: 150px;
            border-radius: 5px;
            text-align: center;
        }
        .product-container {
            display: flex;
        }

        .image-container {
            margin-right: 20px; 
        }

        .product-details {
            flex-grow: 1;
        }
        .review-container{
            width: 40%;
        }

    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
String productId = request.getParameter("id");

// SQL query to retrieve product information
String sql = "SELECT productName, productPrice, productImageURL, productDesc FROM product WHERE productId = ?";
String sql2 = "SELECT reviewRating, reviewComment FROM review WHERE productId = ?";
try {
    getConnection();
    
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, productId); // Set the parameter for the product ID

    ResultSet resultSet = pstmt.executeQuery();

    if (resultSet.next()) {
        String productName = resultSet.getString("productName");
        double productPrice = resultSet.getDouble("productPrice");
        String imageUrl = resultSet.getString("productImageURL");
        String productDesc = resultSet.getString("productDesc");

        String link = "addcart.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;

        out.print("<div class='product-container'>");
        out.print("<h2>" + productName + "</h2>");
        out.print("<p>Product Description:</p>");
        out.print("<p>" + productDesc +"</p>");
        out.print("<div class='image-container'>");
        out.print("<img src='" + imageUrl + "' class='product-image'>");
        out.print("</div>");
    
        out.println("<div class='product-details'>");
        out.println("<p>Product ID: " + productId + "</p>");
        out.println("<p>Product Price: " + productPrice + "</p>");
        out.println("<p><a href='" + link + "' class='custom-button'>Add to Cart</a></p>");
        out.println("<p><a href='listprod.jsp' class='custom-button'>Continue Shopping</a></p>");
        out.println("<p><a href='review.jsp?id=" + productId + "' class='custom-button'>Leave a Review!</a></p>");
        out.println("</div>");
        out.println("</div>");
    } else {
        out.println("<p>Product not found.</p>");
    }

    // Reviews container
    PreparedStatement pstmt2 = con.prepareStatement(sql2);
    pstmt2.setString(1, productId); // Set the parameter for the product ID
    ResultSet resultSet2 = pstmt2.executeQuery();

    if (!resultSet2.next()) {
        out.println("<div class='review-container'>");
        out.println("<p>No reviews written.</p>");
        out.println("</div>");
    } else {
        out.println("<div class='review-container'>");
        out.print("<h2>Reviews</h2>");
        do {
            int reviewRating = resultSet2.getInt("reviewRating");
            String reviewComment = resultSet2.getString("reviewComment");
    
            out.print("<p>Rating: " + reviewRating + "</p>");
            out.print("<p>Comment: " + reviewComment + "</p>");
        } while (resultSet2.next());
        out.println("</div>");
    }

    resultSet.close();
    pstmt.close();

} catch (SQLException e) {
    e.printStackTrace(); // Handle the exception appropriately
}




%>
</body>
</html>
