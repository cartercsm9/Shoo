<%@ page trimDirectiveWhitespaces="true" import="java.sql.*,java.io.*" %>
<%@ include file="jdbc.jsp" %>

<%
String imagePath = getServletContext().getRealPath("/img/");


try {
    getConnection();

    for (int i = 1; i < 27; i++) {
        String imageName = "image_" + i + ".jpg";
        String imageFilePath = imagePath + imageName;

        File imageFile = new File(imageFilePath);
        FileInputStream fis = new FileInputStream(imageFile);
        byte[] imageData = new byte[(int) imageFile.length()];
        fis.read(imageData);
        fis.close();

        String insertSql = "INSERT INTO product (productImage) VALUES (?)";
        PreparedStatement insertStmt = con.prepareStatement(insertSql);
        insertStmt.setBytes(1, imageData);
        insertStmt.executeUpdate();
        insertStmt.close();
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    closeConnection();
}
%>
