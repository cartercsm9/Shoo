<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file= "jdbc.jsp" %>
<%
   
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNum = request.getParameter("phoneNum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");

    boolean isValidPassword = password.length() >= 8 &&
    password.matches(".*[0-9].*") &&
    password.matches(".*[a-zA-Z].*") &&
    password.matches(".*[!@#$%^&*()-_=+\\|[{]};:'\",<.>/?].*");
    
    PreparedStatement pstmt = null;

    try {
        getConnection();
      
        if (!isValidPassword) {
            throw new Exception("Password does not meet the criteria.");
        }
        String insertQuery = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = con.prepareStatement(insertQuery);

   
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, phoneNum);
        pstmt.setString(5, address);
        pstmt.setString(6, city);
        pstmt.setString(7, state);
        pstmt.setString(8, postalCode);
        pstmt.setString(9, country);
        pstmt.setString(10, userId);
        pstmt.setString(11, password);

 
        pstmt.executeUpdate();
        response.sendRedirect("registrationsuccess.jsp");
    } 
    catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", e.getMessage());
        response.sendRedirect("registrationerror.jsp");
    } finally {
        if (pstmt != null) {
            pstmt.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>
