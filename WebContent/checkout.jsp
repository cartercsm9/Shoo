<!DOCTYPE html>
<html>
<head>
    <title>Shoo CheckOut Line</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #d9edfa;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="submit"], input[type="reset"] {
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"], input[type="reset"] {
            background-color: #333;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #555;
        }
    </style>
</head>
<body>

<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
    <input type="text" name="customerId" size="50">
    <input type="submit" value="Submit">
    <input type="reset" value="Reset">
</form>

</body>
</html>
