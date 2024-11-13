<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Obtener el parámetro cedula enviado desde la página de listado
    String cedula = request.getParameter("cedula");

    // Variables de conexión y declaración de JDBC
    String URL = "jdbc:mysql://localhost:3306/bd_pf";
    String nombreUsuario = "root";
    String nombreClave = "Isra1107.";

    Connection conn = null;
    CallableStatement stmt = null;

    try {
        // Cargar el driver JDBC de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

        // Llamar al procedimiento almacenado 'EliminarCliente'
        String sql = "{CALL EliminarCliente(?)}"; // Llamamos al SP EliminarCliente
        stmt = conn.prepareCall(sql);

        // Establecer el valor del parámetro 'cedula' en el procedimiento almacenado
        stmt.setString(1, cedula);  // Cedula es el parámetro para el procedimiento

        // Ejecutar el procedimiento almacenado
        int filasEliminadas = stmt.executeUpdate();

        // Verificar si la eliminación fue exitosa
        if (filasEliminadas > 0) {
            out.println("<script>alert('Cliente eliminado correctamente');</script>");
        } else {
            out.println("<script>alert('No se pudo eliminar al Cliente');</script>");
        }

        // Redirigir de vuelta a la página de listado después de la eliminación
        response.sendRedirect("ConsultaC.jsp");

    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
