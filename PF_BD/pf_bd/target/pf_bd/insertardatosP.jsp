<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Obtener los datos del formulario
    String cedulaPedido = request.getParameter("cedulaPedido");
    double monto = Double.parseDouble(request.getParameter("monto"));
    String descripcion = request.getParameter("descripcion");
    Date fechaPedido = Date.valueOf(request.getParameter("fechaPedido"));

    // Variables de conexión
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Emiliano01603";
    
    Connection conn = null;
    CallableStatement stmtPedido = null;
    PreparedStatement checkCedulaStmt = null;
    ResultSet rs = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Desactivar el auto-commit para manejar transacciones
        conn.setAutoCommit(false);

        // Verificar si la cédula del cliente existe
        String checkCedulaQuery = "SELECT Cedula FROM cliente WHERE Cedula = ?";
        checkCedulaStmt = conn.prepareStatement(checkCedulaQuery);
        checkCedulaStmt.setString(1, cedulaPedido);
        rs = checkCedulaStmt.executeQuery();

        if (rs.next()) {
            // Si la cédula existe, insertar el pedido
            String sqlPedido = "{CALL insertar_Pedido(?, ?, ?, ?)}";
            stmtPedido = conn.prepareCall(sqlPedido);
            stmtPedido.setString(1, cedulaPedido);    // Cedula del cliente
            stmtPedido.setDouble(2, monto);           // Monto del pedido
            stmtPedido.setString(3, descripcion);     // Descripción del pedido
            stmtPedido.setDate(4, fechaPedido);       // Fecha del pedido
            stmtPedido.executeUpdate();

            // Confirmar la transacción
            conn.commit();

            // Mensaje de éxito
            out.println("<script>alert('Pedido registrado exitosamente'); window.location.href='menu.jsp';</script>");
        } else {
            // Si la cédula no existe, mostrar mensaje de error
            out.println("<script>alert('Error: La cédula ingresada no corresponde a un cliente registrado.'); window.location.href='registrarPedido.jsp';</script>");
        }
        
    } catch (SQLException e) {
        // Manejo de excepciones SQL
        try {
            // En caso de error, deshacer cambios
            if (conn != null) conn.rollback();
        } catch (SQLException rollbackEx) {
            out.println("<script>alert('Error al hacer rollback: " + rollbackEx.getMessage() + "'); window.location.href='registrarPedido.jsp';</script>");
        }
        e.printStackTrace();
        out.println("<script>alert('Error de base de datos: " + e.getMessage() + "'); window.location.href='registrarPedido.jsp';</script>");
    } catch (Exception e) {
        // Manejo de excepciones generales
        e.printStackTrace();
        out.println("<script>alert('Error inesperado: " + e.getMessage() + "'); window.location.href='registrarPedido.jsp';</script>");
    } finally {
        // Cerrar recursos
        try {
            if (rs != null) rs.close();
            if (checkCedulaStmt != null) checkCedulaStmt.close();
            if (stmtPedido != null) stmtPedido.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
