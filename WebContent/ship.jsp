<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Shoo</title>
</head>
<body>
        
<%@ include file="header.jsp" %>


<%
int orderId = Integer.parseInt(request.getParameter("orderId"));
%>

          
<%
    
    boolean isValidOrder = false;
    try {
		getConnection();
        String sql = "SELECT COUNT(*) AS count FROM ordersummary WHERE orderId = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setInt(1, orderId);
        ResultSet orderResult = stmt.executeQuery();

        if (orderResult.next()) {
            int count = orderResult.getInt("count");
            isValidOrder = count > 0;
        }
        
        orderResult.close();
        stmt.close();
		con.close();
    } catch (SQLException e) {
        
        e.printStackTrace();
    }
    
    if (!isValidOrder) {
        %>
        <h3>Invalid Order ID. Please check the order ID and try again.</h3>
<%
    }
%>

	
<%
getConnection();
con.setAutoCommit(false);
%>

	
<%

ArrayList<Map<String, Object>> orderItems = new ArrayList<>();
try {
	getConnection();
	String sql = "SELECT * FROM orderproduct WHERE orderId = ?";
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setInt(1, orderId);
	ResultSet itemsResult = stmt.executeQuery();

	while (itemsResult.next()) {
		
		Map<String, Object> item = new HashMap<>();
		item.put("productId", itemsResult.getInt("productId"));
		item.put("quantity", itemsResult.getInt("quantity"));
		orderItems.add(item);
	}
	
	itemsResult.close();
	stmt.close();
	con.close();
} catch (SQLException e) {

	e.printStackTrace();
}
%>

<%

int shipmentId = -1; 
try {
	getConnection();
	String sql = "INSERT INTO shipment (orderId, shipmentDate) VALUES (?, ?)";
	PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	stmt.setInt(1, orderId);
	stmt.setDate(2, new java.sql.Date(new Date().getTime())); 

	int affectedRows = stmt.executeUpdate();
	if (affectedRows > 0) {
		ResultSet generatedKeys = stmt.getGeneratedKeys();
		if (generatedKeys.next()) {
			shipmentId = generatedKeys.getInt(1);
		}
		generatedKeys.close();
	}
	
	stmt.close();
	con.close();
} catch (SQLException e) {
	
	e.printStackTrace();
}

%>

<%
boolean inventoryUpdateSuccess = true;
for (Map<String, Object> item : orderItems) {
	int productId = (int) item.get("productId");
	int quantity = (int) item.get("quantity");

	try {

		PreparedStatement checkInventory = con.prepareStatement("SELECT quantity FROM productinventory WHERE productId = ? AND warehouseId = ?");
		checkInventory.setInt(1, productId);
		checkInventory.setInt(2, 1);
		ResultSet inventoryResult = checkInventory.executeQuery();

		if (inventoryResult.next()) {
			int availableQuantity = inventoryResult.getInt("quantity");


			if (availableQuantity < quantity) {
				inventoryUpdateSuccess = false;
				%>
        <h3>Not enough quantity in inventory for a product.</h3>
<%
				break; 
			} else {

				PreparedStatement updateInventory = con.prepareStatement("UPDATE productinventory SET quantity = ? WHERE productId = ? AND warehouseId = ?");
				updateInventory.setInt(1, availableQuantity - quantity);
				updateInventory.setInt(2, productId);
				updateInventory.setInt(3, 1); 
				updateInventory.executeUpdate();
			}
		} else {

			inventoryUpdateSuccess = false;
			break;
		}
	} catch (SQLException e) {

		inventoryUpdateSuccess = false;
		e.printStackTrace();
		break; 
	}
}

if (!inventoryUpdateSuccess) {
	try {
		
		con.rollback();
		out.println("Inventory update failed. Rollback initiated.");
	} catch (SQLException rollbackEx) {
		
		rollbackEx.printStackTrace();
	}
} else {
	
	try {
		con.commit();
		out.println("Inventory updated successfully. Transaction committed.");
	} catch (SQLException commitEx) {
		
		commitEx.printStackTrace();
	}
}
%>	
	<%
    con.setAutoCommit(true);
	%>
                      				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
