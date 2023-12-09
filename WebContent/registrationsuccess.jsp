<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #4CAF50;
        }

        p {
            color: #333;
        }

        .link {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .link:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="container">
        <h3>Registration Successful!</h3>
        <p>Your account has been created successfully. You can now log in using your credentials.</p>

        <!-- Link to go back to login page -->
        <a href="login.jsp" class="link">Go to Login</a>
    </div>

</body>
</html>
