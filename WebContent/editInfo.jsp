<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #d9edfa;
        }
        h1 {
            text-align: center;
        }
        form {
            width: 60%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: calc(100% - 18px);
            padding: 8px;
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
    </style>
</head>
<body>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
    if (userName != null) {
        try {
            getConnection(); 
            
            String sql = "SELECT * FROM customer WHERE userid = ?";
            
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userName);

            ResultSet resultSet = pstmt.executeQuery();
%>
            <h1>Edit Information</h1>
            <form method="post" action="updateInfo.jsp">
                <%
                    if (resultSet.next()) {
                        ResultSetMetaData metaData = resultSet.getMetaData();
                        int columnCount = metaData.getColumnCount();
                
                        do {
                            for (int i = 1; i <= columnCount; i++) {
                                String columnName = metaData.getColumnName(i);
                                String columnValue = resultSet.getString(i);
                %>
                                <label for="<%= columnName %>"><%= columnName %>:</label>
                                <input type="text" id="<%= columnName %>" name="<%= columnName %>" value="<%= columnValue %>"><br><br>
                <%
                            }
                        } while (resultSet.next());
                %>
                    <input type="submit" value="Update">
                </form>
<%
                    } else {
                %>
                        <p>Customer information not found.</p>
                <%
                    }
                    resultSet.close();
                    pstmt.close();
                    con.close(); 
                } catch (SQLException e) {
                    out.println(e.getMessage());
                }
            } else {
                out.println("User not authenticated.");
            }
%>
