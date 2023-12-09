<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
			background-color: #d9edfa;
        }
        h1 {
            text-align: center;
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
            padding: 12px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

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

            <h1>Welcome, <%= userName %>!</h1>
			<a href="index.jsp"><button>Back to Shop</button></a>
            <a href="editInfo.jsp"><button class="edit-btn">Edit Info</button></a>

            <table>
                <%
                    if (resultSet.next()) {
                        ResultSetMetaData metaData = resultSet.getMetaData();
                        int columnCount = metaData.getColumnCount();
                
                        do {
                %>
                            <tr>
                <%
                                for (int i = 1; i <= columnCount; i++) {
                %>
                                    <td><strong><%= metaData.getColumnName(i) %></strong></td>
                                    <td><%= resultSet.getString(i) %></td>
							</tr>
							<tr>
                <%
                                }
                %>
                            </tr>
                <%
                        } while (resultSet.next());
                    } else {
                %>
                        <tr>
                            <td colspan="2">Customer information not found.</td>
                        </tr>
                <%
                    }
                %>
            </table>

<%
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

</body>
</html>
