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
    Statement stmtExistente = null;
    ResultSet rsExistente = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Desactivar autocommit para manejar transacciones manualmente
        conn.setAutoCommit(false);

        // Verificar si el cliente ya existe
        String sqlExistente = "SELECT COUNT(*) FROM cliente WHERE Cedula = ?";
        stmtExistente = conn.createStatement();
        PreparedStatement stmtCheck = conn.prepareStatement(sqlExistente);
        stmtCheck.setString(1, identificacion);
        rsExistente = stmtCheck.executeQuery();
        
        if (rsExistente.next() && rsExistente.getInt(1) > 0) {
            // Si el cliente ya existe, enviar mensaje de error
            out.println("<script>alert('El cliente con esta cédula ya existe.'); window.location.href='insertarP-C.jsp';</script>");
            return; // Salir para evitar el resto de la ejecución
        }

        // Insertar el cliente usando el procedimiento almacenado
        String sqlCliente = "{CALL insertar_Cliente(?, ?, ?, ?, ?, ?)}";
        stmtCliente = conn.prepareCall(sqlCliente);
        stmtCliente.setString(1, identificacion);  // Cedula
        stmtCliente.setString(2, primerNombre);    
        stmtCliente.setString(3, segundoNombre);   
        stmtCliente.setString(4, primerApellido);  
        stmtCliente.setString(5, segundoApellido); 
        stmtCliente.setString(6, email);           
        stmtCliente.executeUpdate();

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
        out.println("<script>alert('Cliente y Pedido registrados exitosamente'); window.location.href='menu.jsp';</script>");
        
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
        out.println("<script>alert('LA CEDULA DEL PEDIDO NO COINCIDE CON LA DEL CLIENTE.'); window.location.href='insertarP-C.jsp';</script>");
    } finally {
        try {
            // Cerrar los recursos
            if (stmtCliente != null) stmtCliente.close();
            if (stmtPedido != null) stmtPedido.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
