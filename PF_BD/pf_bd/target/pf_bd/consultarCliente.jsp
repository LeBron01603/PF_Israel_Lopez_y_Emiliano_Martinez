<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String cedula = request.getParameter("cedula");
    String url = "jdbc:mysql://localhost:3306/bd_pf"; // Cambia si es necesario
    String user = "root";  // Cambia si es necesario
    String password = "Isra1107."; // Cambia si es necesario
    Connection conn = null;
    CallableStatement stmt = null;
    ResultSet rs = null;
    boolean existe = false;

    try {
        // Conexión a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Procedimiento almacenado para consultar si el cliente existe
        String sql = "{CALL ConsultarCliente(?)}";
        stmt = conn.prepareCall(sql);
        stmt.setString(1, cedula);
        rs = stmt.executeQuery();

        // Si la consulta devuelve resultados, significa que el cliente existe
        if (rs.next()) {
            existe = true;  // El cliente existe
        }

        // Convertir la respuesta a JSON
        out.print("{\"existe\": " + existe + "}");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"existe\": false}");  // En caso de error, se asume que no existe
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
