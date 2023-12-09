<!DOCTYPE html>
<html>

<head>
    <title>Login Screen</title>
    <style>
        body {
            font-family: 'Arial, Helvetica, sans-serif';
            background-color: #d9edfa;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        #login-container {
            margin: 20px auto;
            text-align: center;
            display: inline-block;
        }

        h3 {
            margin-bottom: 10px;
        }

        form {
            display: inline-block;
            text-align: left;
        }

        table {
            margin: 0 auto;
        }

        td {
            text-align: right;
            padding: 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .submit {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            outline: none;
        }

        .submit:hover {
            background-color: #000000;
        }
    </style>
</head>

<body>

    <div id="login-container">

        <h3>Please Login to System</h3>

        <%
        // Print prior error login message if present
        if (session.getAttribute("loginMessage") != null)
            out.println("<p>" + session.getAttribute("loginMessage").toString() + "</p>");
        %>

        <br>

        <form name="MyForm" method="post" action="validateLogin.jsp">
            <table>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></td>
                    <td><input type="text" name="username" size="10" maxlength="10"></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></td>
                    <td><input type="password" name="password" size="10" maxlength="10"></td>
                </tr>
            </table>
            <br />
            <input class="submit" type="submit" name="Submit2" value="Log In">
        </form>

        <form action="createAccount.jsp">
            <input class="submit" type="submit" value="Create Account">
        </form>

    </div>

</body>

</html>
