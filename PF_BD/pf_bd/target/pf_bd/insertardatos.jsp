<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String accion = request.getParameter("accion");
    String identificacion = request.getParameter("identificacion");
    String primerNombre = request.getParameter("primerNombre");
    String segundoNombre = request.getParameter("segundoNombre");
    String primerApellido = request.getParameter("primerApellido");
    String segundoApellido = request.getParameter("segundoApellido");
    String email = request.getParameter("Email");
    String cedulaPedido = request.getParameter("cedulaPedido");
    double monto = Double.parseDouble(request.getParameter("monto"));
    String descripcion = request.getParameter("descripcion");
    Date fechaPedido = Date.valueOf(request.getParameter("fechaPedido"));

    // Variables de conexión
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Isra1107.";
    
    Connection conn = null;
    CallableStatement stmtCliente = null;
    CallableStatement stmtPedido = null;
    CallableStatement stmtConsultarCliente = null;
    ResultSet rsCliente = null;
    
    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Verificación de existencia de cliente
        String sqlConsultarCliente = "{CALL ConsultarCliente(?)}";
        stmtConsultarCliente = conn.prepareCall(sqlConsultarCliente);
        stmtConsultarCliente.setString(1, identificacion);
        rsCliente = stmtConsultarCliente.executeQuery();

        if (accion.equals("registrarCliente") && !rsCliente.next()) {
            // Si el cliente no existe, registrar cliente
            String sqlRegistrarCliente = "{CALL RegistrarCliente(?, ?, ?, ?, ?, ?)}";
            stmtCliente = conn.prepareCall(sqlRegistrarCliente);
            stmtCliente.setString(1, identificacion);
            stmtCliente.setString(2, primerNombre);
            stmtCliente.setString(3, segundoNombre);
            stmtCliente.setString(4, primerApellido);
            stmtCliente.setString(5, segundoApellido);
            stmtCliente.setString(6, email);
            stmtCliente.executeUpdate();

            out.println("<script>alert('Cliente registrado exitosamente.'); window.location.href='insertarP-C.jsp';</script>");
        } else if (accion.equals("registrarPedido")) {
            // Si el cliente ya existe, registrar pedido
            String sqlRegistrarPedido = "{CALL insertar_Pedido(?, ?, ?, ?)}";
            stmtPedido = conn.prepareCall(sqlRegistrarPedido);
            stmtPedido.setString(1, cedulaPedido);
            stmtPedido.setDouble(2, monto);
            stmtPedido.setString(3, descripcion);
            stmtPedido.setDate(4, fechaPedido);
            stmtPedido.executeUpdate();

            out.println("<script>alert('Pedido registrado exitosamente.'); window.location.href='menu.jsp';</script>");
        }
    } catch (Exception e) {
        // Manejo de errores
        out.println("<script>alert('Error al procesar los datos.'); window.location.href='insertarP-C.jsp';</script>");
    } finally {
        try {
            if (stmtCliente != null) stmtCliente.close();
            if (stmtPedido != null) stmtPedido.close();
            if (stmtConsultarCliente != null) stmtConsultarCliente.close();
            if (rsCliente != null) rsCliente.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
