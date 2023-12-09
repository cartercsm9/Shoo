<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Error</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d9edfa;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 40%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #f44336;
            margin-bottom: 20px;
        }

        .error-message {
            color: #f44336;
            margin-bottom: 20px;
        }

        .login-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>

    <div class="container">
        <h3>Registration Error</h3>
        <%-- Display the error message --%>
        <p class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </p>
        
        <a href="registerUser.jsp" class="login-link">Back to Registration</a>
    </div>

</body>
</html>
