<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #d9edfa;
        }
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 20px auto;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-bottom: 20px;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
    try {
        getConnection();

        String sql = "SELECT CONVERT(date, orderDate) AS OrderDay, SUM(totalAmount) AS TotalAmount " +
                     "FROM ordersummary " +
                     "GROUP BY CONVERT(date, orderDate)";
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
%>
        <a href="index.jsp"><button>Back to Shop</button></a>
        <table>
            <tr>
                <th>Order Date</th>
                <th>Total Amount</th>
            </tr>
<%
        while (resultSet.next()) {
%>
            <tr>
                <td><%= resultSet.getString("OrderDay") %></td>
                <td><%= resultSet.getDouble("TotalAmount") %></td>
            </tr>
<%
        }
%>
        </table>
<%
        resultSet.close();
        statement.close();
        con.close(); 
    } catch (SQLException e) {
        out.println(e.getMessage());
    }
%>

</body>
</html>
