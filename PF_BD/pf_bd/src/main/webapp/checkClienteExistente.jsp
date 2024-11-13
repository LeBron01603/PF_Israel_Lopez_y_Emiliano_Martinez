<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String cedula = request.getParameter("cedula");

    // Variables de conexión
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Isra1107.";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Verificar si el cliente existe
        String sql = "SELECT COUNT(*) FROM cliente WHERE Cedula = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, cedula);
        rs = stmt.executeQuery();
        
        if (rs.next() && rs.getInt(1) > 0) {
            out.print("existe"); // El cliente ya existe
        } else {
            out.print("no existe"); // El cliente no existe
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
