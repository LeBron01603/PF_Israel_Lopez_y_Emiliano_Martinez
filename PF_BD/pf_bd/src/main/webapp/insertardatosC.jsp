<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Obtener los datos del formulario
    String identificacion = request.getParameter("identificacion");
    String primerNombre = request.getParameter("primerNombre");
    String segundoNombre = request.getParameter("segundoNombre");
    String primerApellido = request.getParameter("primerApellido");
    String segundoApellido = request.getParameter("segundoApellido");
    String email = request.getParameter("Email");

    // Variables de conexión
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Emiliano01603";
    
    Connection conn = null;
    CallableStatement stmtCliente = null;
    PreparedStatement checkCedulaStmt = null;
    ResultSet rs = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Verificar si la cédula ya existe usando el procedimiento almacenado
        String checkCedulaQuery = "{CALL verificarCedula(?)}";
        checkCedulaStmt = conn.prepareCall(checkCedulaQuery);
        checkCedulaStmt.setString(1, identificacion);
        rs = checkCedulaStmt.executeQuery();

        if (rs.next()) {
            // La cédula ya existe en la base de datos
            out.println("<script>alert('Error: La cédula ya está registrada.'); window.location.href='insertarCliente.jsp';</script>");
        } else {
            // La cédula no existe, insertar el nuevo cliente
            String sqlCliente = "{CALL insertar_Cliente(?, ?, ?, ?, ?, ?)}";
            stmtCliente = conn.prepareCall(sqlCliente);
            stmtCliente.setString(1, identificacion);  // Cedula
            stmtCliente.setString(2, primerNombre);    
            stmtCliente.setString(3, segundoNombre);   
            stmtCliente.setString(4, primerApellido);  
            stmtCliente.setString(5, segundoApellido); 
            stmtCliente.setString(6, email);           

            // Ejecutar la inserción
            stmtCliente.executeUpdate();

            // Redirigir a la página de confirmación de éxito
            response.sendRedirect("clienteRegistrado.jsp");
        }

    } catch (SQLException e) {
        // Manejo de excepciones SQL
        e.printStackTrace();
        out.println("<script>alert('Error de base de datos: " + e.getMessage() + "'); window.location.href='insertarCliente.jsp';</script>");
    } catch (Exception e) {
        // Manejo de excepciones generales
        e.printStackTrace();
        out.println("<script>alert('Error inesperado: " + e.getMessage() + "'); window.location.href='insertarCliente.jsp';</script>");
    } finally {
        // Cerrar recursos
        try {
            if (rs != null) rs.close();
            if (checkCedulaStmt != null) checkCedulaStmt.close();
            if (stmtCliente != null) stmtCliente.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
