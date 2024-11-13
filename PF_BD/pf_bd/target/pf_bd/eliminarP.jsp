<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Obtener el parámetro 'idPedido' enviado desde la página de listado
    String idPedido = request.getParameter("idPedido");

    // Variables de conexión y declaración de JDBC
    String URL = "jdbc:mysql://localhost:3306/bd_pf";
    String nombreUsuario = "root";
    String nombreClave = "Isra1107.";

    Connection conn = null;
    CallableStatement stmt = null;
    String mensaje = ""; // Para almacenar el mensaje de estado

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

        // Llamar al procedimiento almacenado 'EliminarPedido'
        String sql = "{CALL EliminarPedido(?)}"; // Llamamos al SP EliminarPedido
        stmt = conn.prepareCall(sql);

        stmt.setInt(1, Integer.parseInt(idPedido));  // idPedido es el parámetro para el procedimiento

        // Ejecutar el procedimiento almacenado
        int filasEliminadas = stmt.executeUpdate();

        // Verificar si la eliminación fue exitosa
        if (filasEliminadas > 0) {
            mensaje = "Pedido eliminado correctamente.";
        } else {
            mensaje = "No se pudo eliminar el pedido.";
        }

        // Redirigir de vuelta a la página de listado después de la eliminación
        response.sendRedirect("ConsultaP.jsp?mensaje=" + mensaje);

    } catch (ClassNotFoundException | SQLException e) {
        mensaje = "Error: " + e.getMessage();
        response.sendRedirect("ConsultaP.jsp?mensaje=" + mensaje);
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>