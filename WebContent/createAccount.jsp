<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>
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
            color: #4CAF50;
            margin-bottom: 20px;
        }
    
        form {
            text-align: left;
        }
    
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
    
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: calc(100% - 20px);
            padding: 6px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
    
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
    
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    
        .login-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #333;
        }
    </style>
    <script>
        function validatePassword() {
            const password = document.getElementById("password").value;
            const passwordPattern = /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()-_=+\\|[{]};:'",<.>/?]).{8,}$/;

            if (!passwordPattern.test(password)) {
                alert("Password must contain at least 8 characters, including at least one number, one letter, and one special character.");
                return false;
            }

            return true;
        }
    </script>
    
</head>
<body>

    <h3>Create a New Account</h3>

   
    <form name="CreateAccountForm" method="post" action="registerUser.jsp">
        <label for="firstName">First Name:</label>
        <input type="text" name="firstName" id="firstName" required><br><br>
        
        <label for="lastName">Last Name:</label>
        <input type="text" name="lastName" id="lastName" required><br><br>
        
        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required><br><br>
        
        <label for="phoneNum">Phone Number:</label>
        <input type="text" name="phoneNum" id="phoneNum" required><br><br>
        
        <label for="address">Address:</label>
        <input type="text" name="address" id="address" required><br><br>
        
        <label for="city">City:</label>
        <input type="text" name="city" id="city" required><br><br>
        
        <label for="state">State:</label>
        <input type="text" name="state" id="state" required><br><br>
        
        <label for="postalCode">Postal Code:</label>
        <input type="text" name="postalCode" id="postalCode" required><br><br>
        
        <label for="country">Country:</label>
        <input type="text" name="country" id="country" required><br><br>
        
        <label for="userId">Username:</label>
        <input type="text" name="userId" id="userId" required><br><br>
        
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required><br><br>
        
        <input class="submit" type="submit" value="Register">
    </form>


    <br>
    <a href="login.jsp">Back to Login</a>

</body>
</html>
