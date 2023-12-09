<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%
String productId = request.getParameter("productId");

// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList != null && productList.containsKey(productId)) {
    productList.remove(productId);
    session.setAttribute("productList", productList);
}
response.sendRedirect("showcart.jsp");
%>
