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
    CallableStatement stmtConsultarCliente = null; // Procedimiento para consultar cliente
    ResultSet rsCliente = null;
    
    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Consultar si el cliente existe (ejecutando el procedimiento ConsultarCliente)
        String sqlConsultarCliente = "{CALL ConsultarCliente(?)}";
        stmtConsultarCliente = conn.prepareCall(sqlConsultarCliente);
        stmtConsultarCliente.setString(1, identificacion);
        rsCliente = stmtConsultarCliente.executeQuery();

        // Si no encontramos resultados (es decir, el cliente no existe), mostrar mensaje de error
        if (!rsCliente.next()) {
            out.println("<script>alert('El cliente con esta cédula no existe.'); window.location.href='insertarP-C.jsp';</script>");
            return; // Salir para evitar continuar con la ejecución
        }

        // Si el cliente existe, puedes insertar el pedido
        String sqlPedido = "{CALL insertar_Pedido(?, ?, ?, ?)}";
        stmtPedido = conn.prepareCall(sqlPedido);
        stmtPedido.setString(1, cedulaPedido);    // Cedula del cliente (relacionado con cliente)
        stmtPedido.setDouble(2, monto);           
        stmtPedido.setString(3, descripcion);     
        stmtPedido.setDate(4, fechaPedido);       
        stmtPedido.executeUpdate();

        // Si todo va bien, hacer commit
        conn.commit();

        // Mensaje de éxito
        out.println("<script>alert('Pedido registrado exitosamente'); window.location.href='menu.jsp';</script>");
        
    } catch (Exception e) {
        // En caso de error, hacer rollback para revertir todos los cambios
        try {
            if (conn != null) {
                conn.rollback();
            }
        } catch (SQLException rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
        out.println("<script>alert('Error al procesar los datos.'); window.location.href='insertarP-C.jsp';</script>");
    } finally {
        try {
            // Cerrar los recursos
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
