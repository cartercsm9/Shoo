
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #d9edfa;
        }
        h1, h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #333;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        form {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }
        input[type="number"] {
            width: 50px;
        }
        input[type="submit"] {
            cursor: pointer;
            background-color: #333;
            color: white;
            border: none;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: #555;
        }
        a {
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>

<%
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    if (productList == null) {
        out.println("<h1>Your shopping cart is empty!</h1>");
        productList = new HashMap<String, ArrayList<Object>>();
    } else {
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        out.println("<h1>Your Shopping Cart</h1>");
        out.print("<table>");
        out.print("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
        out.println("<th>Price</th><th>Subtotal</th></tr>");

        double total = 0;
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> product = entry.getValue();
            if (product.size() < 4) {
                out.println("Expected product with four entries. Got: " + product);
                continue;
            }

            out.print("<tr>");

            out.print("<form method='post' action='updatecart.jsp'>");
            out.print("<input type='hidden' name='productId' value='" + product.get(0) + "'>");
            out.print("<td>" + product.get(0) + "</td>");
            out.print("<td>" + product.get(1) + "</td>");
            out.print("<td><input type='number' name='quantity' value='" + product.get(3) + "'></td>");

            Object price = product.get(2);
            Object itemqty = product.get(3);
            double pr = 0;
            int qty = 0;

            try {
                pr = Double.parseDouble(price.toString());
            } catch (Exception e) {
                out.println("Invalid price for product: " + product.get(0) + " price: " + price);
            }
            try {
                qty = Integer.parseInt(itemqty.toString());
            } catch (Exception e) {
                out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
            }

            out.print("<td>" + currFormat.format(pr) + "</td>");
            out.print("<td>" + currFormat.format(pr * qty) + "</td>");

            out.print("<td><input type='submit' value='Update Quantity'></td>");
            out.print("</form>");

            out.print("<form method='post' action='removefromcart.jsp'>");
            out.print("<input type='hidden' name='productId' value='" + product.get(0) + "'>");
            out.print("<td><input type='submit' value='Remove'></td>");
            out.print("</form>");

            out.println("</tr>");
            total = total + pr * qty;
        }
        out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                + "<td align=\"right\">" + currFormat.format(total) + "</td><td colspan=\"2\"></td></tr>");
        out.println("</table>");

        out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
    }
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>
