    <%@ page import="java.sql.*" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%
        // Obtener los datos del formulario
        String cedulaPedido = request.getParameter("cedulaPedido");
        double monto = Double.parseDouble(request.getParameter("monto"));  // Asegurarse de que es un número decimal
        String descripcion = request.getParameter("descripcion");
        Date fechaPedido = Date.valueOf(request.getParameter("fechaPedido"));  // Fecha en formato yyyy-mm-dd

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

            // Preparar la llamada al procedimiento almacenado
            String sqlPedido = "{CALL insertar_Pedido(?, ?, ?, ?)}";
            stmtPedido = conn.prepareCall(sqlPedido);
            stmtPedido.setString(1, cedulaPedido);    // Cedula del cliente
            stmtPedido.setDouble(2, monto);           // Monto del pedido
            stmtPedido.setString(3, descripcion);     // Descripción del pedido
            stmtPedido.setDate(4, fechaPedido);       // Fecha del pedido
            
            // Ejecutar el procedimiento almacenado
            stmtPedido.executeUpdate();

            // Mensaje de éxito
            out.println("<script>alert('Pedido registrado exitosamente'); window.location.href='menu.jsp';</script>");
            
        } catch (SQLException e) {
            // Manejo de excepciones SQL
            if (e.getMessage().contains("La cédula ingresada no corresponde a un cliente registrado")) {
                out.println("<script>alert('Error: La cédula ingresada no corresponde a un cliente registrado.'); window.location.href='insertarPedido.jsp';</script>");
            } else {
                e.printStackTrace();
                out.println("<script>alert('Error de base de datos: " + e.getMessage() + "'); window.location.href='insertarPedido.jsp';</script>");
            }
        } catch (Exception e) {
            // Manejo de excepciones generales
            e.printStackTrace();
            out.println("<script>alert('Error inesperado: " + e.getMessage() + "'); window.location.href='insertarPedido.jsp';</script>");
        } finally {
            // Cerrar recursos
            try {
                if (stmtPedido != null) stmtPedido.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
