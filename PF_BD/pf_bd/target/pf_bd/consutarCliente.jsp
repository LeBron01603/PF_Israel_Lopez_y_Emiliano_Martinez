<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Obtener la cédula pasada desde el frontend
    String cedula = request.getParameter("cedula");

    // Parámetros de conexión a la base de datos
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Isra1107.";
    Connection conn = null;
    CallableStatement stmt = null;
    ResultSet rs = null;

    try {
        // Establecer la conexión con la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Preparar la llamada al procedimiento almacenado 'consultarCliente'
        String sql = "{CALL bd_pf.consultarCliente(?)}";
        stmt = conn.prepareCall(sql);
        stmt.setString(1, cedula); // Pasar la cédula como parámetro

        // Ejecutar el procedimiento y obtener el resultado
        rs = stmt.executeQuery();

        // Si hay un resultado, el cliente existe
        if (rs.next()) {
            out.print("existe");
        } else {
            // Si no se encuentra al cliente
            out.print("noExiste");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("error"); // Si hay un error en la consulta
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
