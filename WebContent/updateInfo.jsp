<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
    if (userName != null) {
        try {
            getConnection();

            String updateQuery = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, address=?, city=?, state=?, postalCode=?, country=? WHERE userid=?";
            PreparedStatement pstmt = con.prepareStatement(updateQuery);

            // Get the updated values from the form
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phonenum = request.getParameter("phonenum");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String postalCode = request.getParameter("postalCode");
            String country = request.getParameter("country");

            // Set the parameters for the update query
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, phonenum);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postalCode);
            pstmt.setString(9, country);
            pstmt.setString(10, userName); // Set condition for the specific user

            // Execute the update query
            int rowsUpdated = pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            con.close();

            if (rowsUpdated > 0) {
%>
                <p>Information updated successfully!</p>
<%
            } else {
%>
                <p>No changes made or user not found.</p>
<%
            }
        } catch (SQLException e) {
            out.println(e.getMessage());
        }
    } else {
        out.println("User not authenticated.");
    }
%>
