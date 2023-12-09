<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
String productId = request.getParameter("productId");
String quantityParam = request.getParameter("quantity");
int newQuantity;

// Check if quantityParam is empty or null, default it to 0
if (quantityParam == null || quantityParam.trim().isEmpty()) {
    newQuantity = 0;
} else {
    newQuantity = Integer.parseInt(quantityParam);
}

// Get the current list of products
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList != null && productList.containsKey(productId)) {
    ArrayList<Object> product = productList.get(productId);
    product.set(3, newQuantity);
    session.setAttribute("productList", productList);
}
response.sendRedirect("showcart.jsp");
%>
