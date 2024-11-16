<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Variables de conexión y declaración de JDBC
    String URL = "jdbc:mysql://localhost:3306/bd_pf";
    String nombreUsuario = "root";
    String nombreClave = "Emiliano01603";

    Connection conn = null;
    CallableStatement stmt = null;
    String mensaje = ""; // Para almacenar el mensaje de estado

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

        // Llamar al procedimiento almacenado 'ActualizarPedido'
        String sql = "{CALL ActualizarPedido(?, ?, ?, ?)}"; 

        stmt = conn.prepareCall(sql);

        // Establecer los parámetros en el orden que los espera el procedimiento almacenado
        stmt.setInt(1, Integer.parseInt(request.getParameter("idPedido")));  // p_idPedido (no modificable)
        stmt.setString(2, request.getParameter("Monto"));                    // p_Monto
        stmt.setString(3, request.getParameter("Descripcion"));              // p_Descripcion
        stmt.setDate(4, java.sql.Date.valueOf(request.getParameter("Fecha"))); // p_Fecha

        // Ejecutar el procedimiento almacenado
        int rowsAffected = stmt.executeUpdate();
        
        if (rowsAffected > 0) {
            // Si se actualizó al menos un registro, mostrar mensaje de éxito
            mensaje = "¡Pedido actualizado con éxito!";
        } else {
            // Si no se actualizó nada, mostrar mensaje de error
            mensaje = "No se pudo actualizar el pedido.";
        }

        // Redirigir a la página de consulta pasando el mensaje como parámetro
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
