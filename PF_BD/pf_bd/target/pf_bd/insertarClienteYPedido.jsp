<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String cedula = request.getParameter("cedula");
    String primerNombre = request.getParameter("primerNombre");
    String segundoNombre = request.getParameter("segundoNombre");
    String primerApellido = request.getParameter("primerApellido");
    String segundoApellido = request.getParameter("segundoApellido");
    String email = request.getParameter("email");
    String montoPedido = request.getParameter("montoPedido");
    String descripcionPedido = request.getParameter("descripcionPedido");
    String fechaPedido = request.getParameter("fechaPedido");

    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Isra1107.";
    Connection conn = null;
    CallableStatement stmt = null;

    try {
        // Establecer la conexión con la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Primero, consultar si el cliente existe
        String sqlConsulta = "{CALL bd_pf.consultarCliente(?)}";
        stmt = conn.prepareCall(sqlConsulta);
        stmt.setString(1, cedula);
        ResultSet rs = stmt.executeQuery();

        if (!rs.next()) {
            // Si no existe el cliente, insertarlo
            String sqlInsertarCliente = "{CALL bd_pf.insertarCliente(?, ?, ?, ?, ?, ?)}";
            stmt = conn.prepareCall(sqlInsertarCliente);
            stmt.setString(1, cedula);
            stmt.setString(2, primerNombre);
            stmt.setString(3, segundoNombre);
            stmt.setString(4, primerApellido);
            stmt.setString(5, segundoApellido);
            stmt.setString(6, email);
            stmt.executeUpdate();
        }

        // Ahora insertar el pedido para el cliente
        String sqlInsertarPedido = "{CALL bd_pf.insertarPedido(?, ?, ?, ?)}";
        stmt = conn.prepareCall(sqlInsertarPedido);
        stmt.setString(1, cedula);
        stmt.setDouble(2, Double.parseDouble(montoPedido));
        stmt.setString(3, descripcionPedido);
        stmt.setDate(4, Date.valueOf(fechaPedido));
        stmt.executeUpdate();

        out.print("Pedido registrado con éxito.");

    } catch (Exception e) {
        e.printStackTrace();
        out.print("error");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
