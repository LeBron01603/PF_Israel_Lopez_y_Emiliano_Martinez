<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
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

        // Llamar al procedimiento almacenado 'ActualizarCliente'
        String sql = "{CALL ActualizarCliente(?, ?, ?, ?, ?, ?)}"; 

        stmt = conn.prepareCall(sql);

        // Establecer los parámetros en el orden que los espera el procedimiento almacenado
        stmt.setString(1, request.getParameter("Cedula"));  // p_Cedula (debe ser enviado desde el campo oculto)
        stmt.setString(2, request.getParameter("Nombre1")); // p_Nombre1
        stmt.setString(3, request.getParameter("Nombre2")); // p_Nombre2
        stmt.setString(4, request.getParameter("Apellido1")); // p_Apellido1
        stmt.setString(5, request.getParameter("Apellido2")); // p_Apellido2
        stmt.setString(6, request.getParameter("Correo"));   // p_Correo

        // Ejecutar el procedimiento almacenado
        int rowsAffected = stmt.executeUpdate();
        
        if (rowsAffected > 0) {
            // Si se actualizó al menos un registro, mostrar mensaje de éxito
            mensaje = "¡Cliente actualizado con éxito!";
        } else {
            // Si no se actualizó nada, mostrar mensaje de error
            mensaje = "No se pudo actualizar al cliente.";
        }

        // Redirigir a la página de consulta pasando el mensaje como parámetro
        response.sendRedirect("ConsultaC.jsp?mensaje=" + mensaje);

    } catch (ClassNotFoundException | SQLException e) {
        mensaje = "Error: " + e.getMessage();
        response.sendRedirect("ConsultaC.jsp?mensaje=" + mensaje);
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
