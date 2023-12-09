<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ include file="jdbc.jsp" %>


<%
    String productIdStr = request.getParameter("id");
    int productId = 0;
    int customerId = (int) session.getAttribute("customerId");

    try {
        productId = Integer.parseInt(productIdStr);
    } catch (NumberFormatException e) {
        out.println("Invalid customer or product ID.");
        e.printStackTrace();
    }
%>

<%! 
    boolean hasCustomerReviewedProduct(int customerId, int productId) {
        try {
            String checkQuery = "SELECT COUNT(*) FROM review WHERE customerId = ? AND productId = ?";
            try (PreparedStatement checkStatement = con.prepareStatement(checkQuery)) {
                checkStatement.setInt(1, customerId);
                checkStatement.setInt(2, productId);
                try (ResultSet resultSet = checkStatement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getInt(1) > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
%>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Review</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Tahoma', sans-serif;
            background-color: #d9edfa;
            color: #000;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h1 {
            color: #31708f;
        }

        .rating {
            font-size: 24px;
        }

        .star {
            cursor: pointer;
            color: #f0ad4e;
        }

        .star.selected {
            color: #d9534f;
        }

        .review-form {
            margin-top: 20px;
            width: 80%;
            max-width: 500px;
        }

        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .submit-btn {
            padding: 10px;
            background-color: #5bc0de;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #31b0d5;
        }
    </style>
    <script>
        function setRating(rating) {
            document.getElementById('ratingInput').value = rating;

            document.querySelectorAll('.star').forEach(function (star) {
                star.classList.remove('selected');
            });

            for (let i = 1; i <= rating; i++) {
                document.querySelector('.star:nth-child(' + i + ')').classList.add('selected');
            }
        }
    </script>
</head>

<body>

    <h1>Product Review</h1>

    <div class="rating">
        <span class="star" onclick="setRating(1)">&#9733;</span>
        <span class="star" onclick="setRating(2)">&#9733;</span>
        <span class="star" onclick="setRating(3)">&#9733;</span>
        <span class="star" onclick="setRating(4)">&#9733;</span>
        <span class="star" onclick="setRating(5)">&#9733;</span>
    </div>

    <div class="review-form">
        <form method="post">
            <textarea name="reviewText" placeholder="Write your review here..."></textarea>
            <br>
            <input type="hidden" name="rating" id="ratingInput" value="0">
            <button type="submit" class="submit-btn">Submit Review</button>
        </form>
    
        <button class="submit-btn" onclick="location.href='product.jsp?id=<%= productId %>'">Back to Product</button>
    </div>

<%
    getConnection();
    PreparedStatement preparedStatement = null;
    ResultSet generatedKeys = null;

    try {
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String insertQuery = "INSERT INTO review (reviewRating, reviewDate, productId, reviewComment, customerId) VALUES (?, GETDATE(), ?, ?, ?)";

            int reviewRating = Integer.parseInt(request.getParameter("rating"));
            String reviewComment = request.getParameter("reviewText");



            if (!hasCustomerReviewedProduct(customerId, productId)) {
                preparedStatement = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
                preparedStatement.setInt(1, reviewRating);
                preparedStatement.setInt(2, productId);
                preparedStatement.setString(3, reviewComment);
                preparedStatement.setInt(4, customerId);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    generatedKeys = preparedStatement.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int reviewId = generatedKeys.getInt(1);
                        out.println("Review inserted successfully! ReviewId: " + reviewId);
                    } else {
                        out.println("Failed to retrieve the generated reviewId.");
                    }
                } else {
                    out.println("Failed to insert review.");
                }
            } else {
                out.println("You have already submitted a review for this product.");
            }
        }
    } catch (SQLException e) {
        out.println("Database error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            if (generatedKeys != null) {
                generatedKeys.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
